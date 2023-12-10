import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cubit/cubit/cubit.dart';
import 'package:flutter_application_1/layout/news_app/cubit/states/states.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScineceScreen extends StatelessWidget {
  const ScineceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsState>(
      builder: (BuildContext context, state) {
        var list = newsCubit.get(context).science;
        return articleBuilder(list, context, list.length);
      },
      listener: (BuildContext context, state) {},
    );
  }
}
