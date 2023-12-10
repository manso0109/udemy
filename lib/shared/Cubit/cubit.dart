// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/modules/todo_app/archieved/archieved_tasks.dart';
import 'package:flutter_application_1/modules/todo_app/done/done_tasks.dart';
import 'package:flutter_application_1/modules/todo_app/tasks/new_tasks.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_application_1/shared/Cubit/states.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> Screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchievedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archieved Tasks',
  ];

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archievedTasks = [];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      onCreate: (database, version) {
        // 1 id integar
        // 2 title string
        // 3 date String
        // 4 time String
        // 5 status String
        print('database Created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      version: 1,
      onOpen: (database) {
        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  insertToDatabase(
      {required String title, required String date, required String time}) {
    database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabase());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('error when inserting new record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    archievedTasks = [];
    doneTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery("SELECT * FROM tasks").then((value) {
      print('database opened');
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archievedTasks.add(element);
        }
      });
      emit(AppGetDatabase());
    });
  }

  IconData? fabicon = Icons.edit;
  bool isBottomSheetShown = false;

  void changeBottomSheetState({required bool isShown, required icon}) async {
    isBottomSheetShown = isShown;
    fabicon = icon;
    emit(AppChangeBottomSheetState());
  }

  updateDataFromDatabase({required String status, required int ID}) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        [status, '$ID']).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabase());
    });
  }

  void deleteFromDatabase({required int ID}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$ID']).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteFromDatabase());
    });
  }

  bool isDark = false;

  ThemeData darkTheme = ThemeData(
    fontFamily: 'bdo',
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.amberAccent,
      focusColor: Colors.white,
      filled: true,
      fillColor: Colors.black,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20)),
      prefixIconColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.black),
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    primarySwatch: Colors.amber,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        scrolledUnderElevation: 12,
        titleTextStyle: TextStyle(
            fontFamily: 'bdo',
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber[400],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black),
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: TextTheme(
      headlineSmall: const TextStyle(fontSize: 15).apply(color: Colors.white),
      headlineMedium: const TextStyle(fontSize: 25).apply(color: Colors.white),
      bodyLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          .apply(color: Colors.white),
    ),
  );

  ThemeMode appMode = ThemeMode.light;
  ThemeData lightTheme = ThemeData(
      fontFamily: 'bdo',
      inputDecorationTheme: const InputDecorationTheme(
          suffixIconColor: Colors.black,
          prefixIconColor: Colors.black,
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.black)),
      primarySwatch: Colors.amber,
      textTheme: TextTheme(
          headlineSmall:
              const TextStyle(fontSize: 15).apply(color: Colors.black),
          headlineMedium:
              const TextStyle(fontSize: 25).apply(color: Colors.black),
          bodyLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              .apply(color: Colors.black)),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color.fromARGB(255, 59, 45, 15)),
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.amber,
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: Colors.amber,
          scrolledUnderElevation: 12,
          titleTextStyle: TextStyle(
              fontFamily: 'bdo',
              color: Color.fromARGB(255, 59, 45, 15),
              fontSize: 25,
              fontWeight: FontWeight.bold)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.amber[400],
          unselectedItemColor: const Color.fromARGB(255, 59, 45, 15)));

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;

      emit(NewsAppChangeModeState());
    } else {
      isDark = !isDark;
    }
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(NewsAppChangeModeState());
      print(isDark);
    });
  }

  late WebViewController controller;
  void WebView({required String url}) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          if (request.url != url) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(url));
    emit(NewsStartWebView());
  }
}
