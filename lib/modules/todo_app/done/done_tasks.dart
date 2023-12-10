import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_application_1/shared/Cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) => ConditionalBuilder(
              condition: AppCubit.get(context).doneTasks.isNotEmpty,
              builder: (BuildContext context) => ListView.separated(
                  itemBuilder: (context, index) => buildTaskItem(
                      AppCubit.get(context).doneTasks[index], context),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                  itemCount: AppCubit.get(context).doneTasks.length),
              fallback: (BuildContext context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done_sharp,
                      color: Colors.grey[400],
                      size: 100,
                    ),
                    const Text(
                      'You haven\t finished any tasks yet',
                      style: TextStyle(fontSize: 16, color: Colors.cyan),
                    )
                  ],
                ),
              ),
            ));
  }
}
