import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cubit/states/states.dart';
import 'package:flutter_application_1/modules/news_app/business/business_screen.dart';
import 'package:flutter_application_1/modules/news_app/science/science_screen.dart';
import 'package:flutter_application_1/modules/news_app/setting/settings_screen.dart';
import 'package:flutter_application_1/modules/news_app/sports/sports_screen.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class newsCubit extends Cubit<newsState> {
  newsCubit() : super(NewsInitialState());
  static newsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScineceScreen(),
    const SettingsScreen(),
  ];
  void changeBottomNavBarState(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getscience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'in',
      'category': 'business',
      'apiKey': '70a37f5cb4aa4fd68f3cf604fe89a980',
    }).then((value) {
      business = value?.data?['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'in',
        'category': 'sports',
        'apiKey': '70a37f5cb4aa4fd68f3cf604fe89a980',
      }).then((value) {
        sports = value?.data?['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        // ignore: avoid_print
        print(error.toString());
        emit(NewsGetSPortsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsLoadingState());
    }
  }

  List<dynamic> science = [];
  void getscience() {
    emit(NewsGetBusinessLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'in',
        'category': 'science',
        'apiKey': '70a37f5cb4aa4fd68f3cf604fe89a980',
      }).then((value) {
        science = value?.data?['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        // ignore: avoid_print
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceLoadingState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String? value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '70a37f5cb4aa4fd68f3cf604fe89a980',
    }).then((value) {
      search = value?.data?['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
