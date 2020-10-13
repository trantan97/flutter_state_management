import 'package:flutter/services.dart';

class CalculateUtils {
  static const calculateChannel = MethodChannel("com.trantan/calculate");

  CalculateUtils() {
    calculateChannel.setMethodCallHandler((call) async{
      switch (call.method) {
        case "square":
          if (call.arguments is num) return call.arguments * call.arguments;
          throw PlatformException(code: "Not is Number");
        default:
          throw MissingPluginException();
      }
    });
  }

  Future<int> increment(int number) async {
    final result = await calculateChannel.invokeMethod("increment", number);
    print('---->$result');
    return result;
  }

  Future<int> decrement(int number) async {
    final result = await calculateChannel.invokeMethod("decrement", number);
    print('---->$result');
    return result;
  }

  Future<int> square(int number) async {
    final result = await calculateChannel.invokeMethod("square", number);
    print('---->$result');
    return result;
  }
}
