// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shop_app/login_model.dart';
import 'package:flutter_application_1/modules/shop_app/login/cubit/login_states.dart';
import 'package:flutter_application_1/shared/network/end_points.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({
    required String username,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {'email': username, 'password': password}).then((value) {
      loginModel = ShopLoginModel.fromjson(value?.data);
      print(value?.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;
    emit(ShopPasswordVisibilty());
  }

  List<dynamic> user = [];

  void getUser(
    String value,
    int id,
  ) {
    emit(LoginGetUserLoadingState());
    DioHelper.getData(url: 'https://fakestoreapi.com/', query: {
      'users': 'everything',
      'username': value,
    }).then((value) {
      user = value?.data?['users/{$id}'];
      print(user.length);
      emit(LoginGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginGetUserErrorState(error.toString()));
    });
  }
}
