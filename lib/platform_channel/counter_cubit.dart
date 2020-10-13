import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo_state_management/platform_channel/calculate_utils.dart';

class CounterCubit extends Cubit<int> {
  final CalculateUtils calculateUtils = CalculateUtils();

  CounterCubit() : super(0);

  Future<void> increment() async {
    final newState = await calculateUtils.increment(state);
    emit(newState);
  }

  Future<void> decrement() async {
    final newState = await calculateUtils.decrement(state);
    emit(newState);
  }

  Future<void> square() async {
    final newState = await calculateUtils.square(state);
    emit(newState);
  }
}
