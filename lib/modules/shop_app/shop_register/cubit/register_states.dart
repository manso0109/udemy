abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  ShopRegisterSuccessState();
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterIsAvailableLoadingState extends ShopRegisterStates {}

class ShopRegisterIsAvailableSuccessState extends ShopRegisterStates {
  ShopRegisterIsAvailableSuccessState();
}

class ShopRegisterIsAvailableErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterIsAvailableErrorState(this.error);
}

class RegisterPasswordVisibilty extends ShopRegisterStates {}
