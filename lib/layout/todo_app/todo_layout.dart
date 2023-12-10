// ignore_for_file: non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_application_1/shared/Cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// 1 create database
// 1.1 create tables
// 2 open database
// 3 insert database
// 4 get from database
// 5 update database
// 6 delete from database

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext Context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabase) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates states) => Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(AppCubit.get(context)
                .titles[AppCubit.get(context).currentIndex]),
          ),
          body: ConditionalBuilder(
            condition: states is! AppGetDatabaseLoadingState,
            builder: (context) => AppCubit.get(context)
                .Screens[AppCubit.get(context).currentIndex],
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (AppCubit.get(context).isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  AppCubit.get(context).insertToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text);
                }
              } else {
                scaffoldKey.currentState
                    ?.showBottomSheet(
                      (context) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  defaultFormField(
                                      controller: titleController,
                                      inputType: keyboardType,
                                      hintText: 'Task Title',
                                      labelText: 'Task Title',
                                      prefix: const Icon(Icons.title),
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'title must not be empty ';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  defaultFormField(
                                      controller: timeController,
                                      inputType: timeType,
                                      hintText: 'Time',
                                      labelText: 'TIme',
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeController.text =
                                              value!.format(context);
                                        });
                                      },
                                      prefix: const Icon(Icons.timelapse),
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'time must not be empty ';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  defaultFormField(
                                      controller: dateController,
                                      inputType: dateType,
                                      hintText: 'Date',
                                      labelText: 'Date',
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2030-12-31'))
                                            .then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                        });
                                      },
                                      prefix: const Icon(Icons.calendar_today),
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'date must not be empty';
                                        }
                                        return null;
                                      }),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      elevation: 50,
                    )
                    .closed
                    .then((value) {
                      AppCubit.get(context).changeBottomSheetState(
                          isShown: false, icon: Icons.edit);
                    });
                AppCubit.get(context)
                    .changeBottomSheetState(isShown: true, icon: Icons.add);
              }
            },
            child: Icon(
              AppCubit.get(context).fabicon,
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              elevation: 50,
              backgroundColor: Colors.blue,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (index) {
                AppCubit.get(context).ChangeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archieved'),
              ]),
        ),
      ),
    );
  }
}
