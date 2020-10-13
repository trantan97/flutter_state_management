import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo_state_management/platform_channel/date_time_utils.dart';

class DateTimeCubit extends Cubit<DateTime> {
  StreamSubscription _subscription;
  DateTimeUtils _dateTimeUtils = DateTimeUtils();

  DateTimeCubit() : super(DateTime.now());

  void getCurrentTime() {
    _subscription = _dateTimeUtils.getCurrentTime().listen((time) {
      print('------>$time');
      emit(DateTime.fromMillisecondsSinceEpoch(time));
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
