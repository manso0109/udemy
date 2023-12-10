import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Shop_app/login_model.dart';
import 'package:flutter_application_1/modules/social_app_modules/social_login/cubit/social_login_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;
    emit(SocialPasswordVisibilty());
  }

  List<dynamic> user = [];

  // void getUser(
  //   String value,
  //   int id,
  // ) {
  //   emit(LoginGetUserLoadingState());
  //   DioHelper.getData(url: 'https://fakestoreapi.com/', query: {
  //     'users': 'everything',
  //     'username': value,
  //   }).then((value) {
  //     user = value?.data?['users/{$id}'];
  //     print(user.length);
  //     emit(LoginGetUserSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(LoginGetUserErrorState(error.toString()));
  //   });
  // }
}
