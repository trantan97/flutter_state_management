import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.trantan/calculate", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({(call: FlutterMethodCall,result: FlutterResult) -> Void in
            switch(call.method){
            case "increment": self.increment(call: call,result: result)
            case "decrement": self.decrement(call: call,result: result)
            default: result(FlutterMethodNotImplemented);
            }
        });
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func increment(call:FlutterMethodCall,result: FlutterResult){
        if call.arguments is Int{
            result(Int(call.arguments as! Int + 1))
        }else{
            result(FlutterError(code: "Not is number", message: nil, details: nil))
        }
    }
    
    private func decrement(call:FlutterMethodCall,result: FlutterResult){
        if call.arguments is Int{
            result(Int(call.arguments as! Int - 1))
        }else{
            result(FlutterError(code: "Not is number", message: nil, details: nil))
        }
    }
}
