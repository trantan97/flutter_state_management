import 'dart:math';

import 'package:demo_state_management/bloc/counter_bloc.dart';
import 'package:demo_state_management/platform_channel/counter_cubit.dart';
import 'package:demo_state_management/platform_channel/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Platform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CounterCubit>(
            create: (context) => CounterCubit(),
          ),
          BlocProvider<DateTimeCubit>(
            create: (context) => DateTimeCubit()..getCurrentTime(),
          ),
        ],
        child: HomeScreen(title: 'Flutter Demo Platform Home Page'),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String title;

  const HomeScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          color: Colors.accents[Random().nextInt(10)],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BlocBuilder<DateTimeCubit, DateTime>(
                builder: (context, state) {
                  return Text("${state.hour}:${state.minute}:${state.second}");
                },
              ),
              Text(
                'You have pushed the button this many times:',
              ),
              BlocBuilder<CounterCubit, int>(
                builder: (context, state) {
                  return Text(
                    state.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.bloc<CounterCubit>().increment();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              context.bloc<CounterCubit>().decrement();
            },
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          // FloatingActionButton(
          //   onPressed: () {
          //     context.bloc<CounterCubit>().square();
          //   },
          //   tooltip: 'Square',
          //   child: Icon(Icons.ac_unit),
          // ),
        ],
      ),
    );
  }
}
