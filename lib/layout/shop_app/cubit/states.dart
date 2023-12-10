abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNav extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopLoadingProductsDataState extends ShopStates {}

class ShopSuccessProductsDataState extends ShopStates {}

class ShopErrorProductsDataState extends ShopStates {
  final String error;
  ShopErrorProductsDataState(this.error);
}

class ShopLoadingPagedProductsDataState extends ShopStates {}

class ShopSuccessPagedProductsDataState extends ShopStates {}

class ShopErrorPagedProductsDataState extends ShopStates {
  final String error;
  ShopErrorPagedProductsDataState(this.error);
}

class ShopPagination extends ShopStates {}

class ShopChangePage extends ShopStates {}

class ShopCheckConnectivity extends ShopStates {}

class ShopLoadingDeleteProductsDataState extends ShopStates {}

class ShopSuccessDeleteProductsDataState extends ShopStates {}

class ShopErrorDeleteProductsDataState extends ShopStates {
  final String error;
  ShopErrorDeleteProductsDataState(this.error);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates {
  final String error;
  ShopErrorUpdateUserState(this.error);
}
