import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cubit/cubit/cubit.dart';
import 'package:flutter_application_1/layout/news_app/cubit/states/states.dart';
import 'package:flutter_application_1/modules/news_app/search/search_screen.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsState>(
      builder: (BuildContext context, state) {
        var cubit = newsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                  onPressed: () {
                    NavigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_4_rounded))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBottomNavBarState(index);
              },
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems),
          body: cubit.screens[cubit.currentIndex],
        );
      },
      listener: (BuildContext context, state) {},
    );
  }
}
