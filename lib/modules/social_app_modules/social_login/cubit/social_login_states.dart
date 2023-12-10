// ignore_for_file: camel_case_types

abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uId;
  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialPasswordVisibilty extends SocialLoginStates {}

class changeOnBoardingScreen extends SocialLoginStates {}

class LoginGetUserLoadingState extends SocialLoginStates {}

class LoginGetUserSuccessState extends SocialLoginStates {}

class LoginGetUserErrorState extends SocialLoginStates {
  final String error;
  LoginGetUserErrorState(this.error);
}
