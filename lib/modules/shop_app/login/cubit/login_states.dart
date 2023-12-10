// ignore_for_file: camel_case_types

import 'package:flutter_application_1/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel? loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopPasswordVisibilty extends ShopLoginStates {}

class changeOnBoardingScreen extends ShopLoginStates {}

class LoginGetUserLoadingState extends ShopLoginStates {}

class LoginGetUserSuccessState extends ShopLoginStates {}

class LoginGetUserErrorState extends ShopLoginStates {
  final String error;
  LoginGetUserErrorState(this.error);
}
