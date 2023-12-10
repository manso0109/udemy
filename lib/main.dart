// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';

import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/social_layout.dart';
import 'package:flutter_application_1/modules/native_code/native_code.dart';
import 'package:flutter_application_1/modules/shop_app/categories/cat_cubit/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/login/cubit/login_cubit.dart';
import 'package:flutter_application_1/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:flutter_application_1/modules/social_app_modules/social_login/social_login_screen.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_application_1/shared/Cubit/states.dart';
import 'package:flutter_application_1/shared/bloc_observer_bloc.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  // 1. checkout master
  // 2. update master
  // 3. create branch
  // 4. code ..
  // 5. commit
  // 6. checkout master
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android == true
          ? DefaultFirebaseOptions.android
          : DefaultFirebaseOptions.web);
  if (DefaultFirebaseOptions.android == true) {
    var token2 = await FirebaseMessaging.instance.getToken();
    print(token2.toString());
  } else {}

  if (DefaultFirebaseOptions.web == true) {
    await windowManager.ensureInitialized();
  }

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    minimumSize: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  // FirebaseMessaging.onBackgroundMessage((message) => );
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? isLast = CacheHelper.getData(key: 'isLast');
  token = CacheHelper.getData(key: 'access_token');
  String? email = CacheHelper.getData(key: 'email');
  Widget? widget;
  uId = CacheHelper.getData(key: 'uId');
  String? password = CacheHelper.getData(key: 'password');
  isDark ??= false;
  isLast ??= false;
  token ??= '';
  // ignore: unnecessary_null_comparison
  widget ??= widget;
  if (uId == null) {
    widget = const SocialLoginScreen();
  } else {
    widget = const SocialLayout();
  }
  email ??= '';
  password ??= '';
  runApp(MyApp(
    isDark: isDark,
    isLast: isLast,
    token: token ?? '',
    widget: widget,
    email: email,
    password: password,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final bool isLast;
  final Widget widget;
  final String token;
  final String email;
  final String password;

  const MyApp(
      {super.key,
      required this.isDark,
      required this.isLast,
      required this.token,
      required this.widget,
      required this.email,
      required this.password});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) =>
                AppCubit()..changeAppMode(fromShared: isDark),
          ),
          BlocProvider(
            create: (BuildContext context) => ShopLoginCubit(),
          ),
          BlocProvider(
              create: ((context) =>
                  ShopCategoriesCubit()..GetCategoriesData())),
          BlocProvider(
              create: ((context) => ShopCubit()
                ..GetHomeData(token)
                ..GetproductDat2a()
                ..GetproductData())),
          BlocProvider(create: ((context) => SearchCubit())),
          BlocProvider(
              create: ((context) => SocialCubit()
                ..GetUser()
                ..getUsers()
                ..getPosts()))
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppCubit.get(context).isDark
                  ? AppCubit.get(context).darkTheme
                  : AppCubit.get(context).lightTheme,
              themeMode: AppCubit.get(context).isDark
                  ? AppCubit.get(context).appMode = ThemeMode.dark
                  : AppCubit.get(context).appMode = ThemeMode.light,
              home: const NativeCodeScreen()),
        ),
        hjgh);
  }
}

// 1. checkout master
// 2. update master
// 3. create branch
// 4. code ..
// 5. commit
// 6. checkout master
// 7. update master
// 8. checkout your local
// 9. merge master with my current branch
// 10. 