// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/counter_screen_app/cubit/cubit.dart';
import 'package:flutter_application_1/modules/counter_screen_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// stateless needs one class provide widget

// statefull contain classes

// 1 first class provide widger
// 2 second class provide state from this widget
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (BuildContext context, state) {
          if (state
              is CounterPlusState) {} //print('Plus State ${state.counter}');
          if (state
              is CounterMinusState) {} //print('Minus State ${state.counter}');
        },
        builder: (BuildContext context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Counter Screen'),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    CounterCubit.get(context).minus();
                    print(CounterCubit.get(context).counter);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  '${CounterCubit.get(context).counter}',
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 50,
                ),
                MaterialButton(
                  onPressed: () {
                    CounterCubit.get(context).plus();
                    print(CounterCubit.get(context).counter);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
