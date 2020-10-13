package com.trantan.demo_state_management

import android.os.Handler
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity : FlutterActivity(), EventChannel.StreamHandler {
    private lateinit var handler: Handler
    private var events: EventChannel.EventSink? = null

    companion object {
        const val METHOD_CHANNEL_NAME = "com.trantan/calculate";
        const val EVENT_CHANNEL_NAME = "com.trantan/time";
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL_NAME)
        val timeChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL_NAME)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "increment" -> increment(call, result)
                "decrement" -> decrement(call, result)
                "square" -> platformCallDart(channel, call, result)
                else -> result.notImplemented()
            }
        }
        handler = Handler();
        timeChannel.setStreamHandler(this)
    }

    private fun increment(call: MethodCall, result: MethodChannel.Result) {
        val number = call.arguments
        if (number is Int) result.success(number + 1)
        else result.error(null, "Not is number", null)
    }

    private fun decrement(call: MethodCall, result: MethodChannel.Result) {
        val number = call.arguments
        if (number is Int) result.success(number - 1)
        else result.error(null, "Not is number", null)
    }

    private fun platformCallDart(channel: MethodChannel, call: MethodCall, result: MethodChannel.Result) {
        channel.invokeMethod("square", call.arguments, object : MethodChannel.Result {
            override fun success(resultFormDart: Any?) {
                result.success(resultFormDart)
            }

            override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {

                result.error(errorCode, errorMessage, errorDetails)
            }

            override fun notImplemented() {
                result.notImplemented()
            }

        })
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        this.events = events
        startGetTime()
    }

    override fun onCancel(arguments: Any?) {
        stopGetTime()
        events = null
    }

    var mGetTime = object : Runnable {
        override fun run() {
            events?.apply { this.success(Calendar.getInstance().timeInMillis) }
            handler.postDelayed(this, 1000)
        }
    }

    private fun startGetTime() {
        mGetTime.run()
    }

    private fun stopGetTime() {
        handler.removeCallbacks(mGetTime)
    }
}
