import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';

class SettingsScreen2 extends StatelessWidget {
  const SettingsScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
              color:
                  AppCubit.get(context).isDark ? Colors.white : Colors.black),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  'Change app theme mode',
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                      color: AppCubit.get(context).isDark
                          ? Colors.black
                          : Colors.white),
                ),
                const Spacer(),
                Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppCubit.get(context).isDark
                          ? Colors.black
                          : Colors.white),
                  child: IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeAppMode();
                      },
                      icon: Icon(
                        Icons.brightness_4_rounded,
                        color: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                      )),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Center(
          child: defaultTextButton(context, function: () {
            SignOut(context);
          }, text: 'sign out', width: 100, height: 40),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
