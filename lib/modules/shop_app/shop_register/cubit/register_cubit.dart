// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shop_app/login_model.dart';
import 'package:flutter_application_1/modules/shop_app/shop_register/cubit/register_states.dart';
import 'package:flutter_application_1/shared/network/end_points.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegsiterCubit extends Cubit<ShopRegisterStates> {
  RegsiterCubit() : super(ShopRegisterInitialState());

  static RegsiterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String avatar,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'password': password,
      'name': name,
      'avatar': avatar,
      'email': email
    }).then((value) {
      print(value?.data);
      emit(ShopRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  dynamic IsAvailable;

  void isAvailable({
    required String email,
  }) {
    emit(ShopRegisterIsAvailableLoadingState());
    DioHelper.postData(url: IsAVAILABLE, data: {
      'email': email,
    }).then((value) {
      IsAvailable = value;
      print(value?.data);
      emit(ShopRegisterIsAvailableSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterIsAvailableErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;
    emit(RegisterPasswordVisibilty());
  }
}
