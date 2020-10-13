import 'package:flutter/services.dart';

class DateTimeUtils{
  static const timeChannel = EventChannel("com.trantan/time");
  Stream getCurrentTime() {
    return timeChannel.receiveBroadcastStream();
  }
}