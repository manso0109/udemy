abstract class ShopCategoriesStates {}

class ShopCategoriesInitialState extends ShopCategoriesStates {}

class ShopLoadingCategoriesDataState extends ShopCategoriesStates {}

class ShopSuccessCategoriesDataState extends ShopCategoriesStates {}

class ShopErrorCategoriesDataState extends ShopCategoriesStates {
  final String error;
  ShopErrorCategoriesDataState(this.error);
}

class ShopPagination extends ShopCategoriesStates {}

class ShopLoadingPagedCategoriesDataState extends ShopCategoriesStates {}

class ShopSuccessPagedCategoriesDataState extends ShopCategoriesStates {}

class ShopErrorPagedCategoriesDataState extends ShopCategoriesStates {
  final String error;
  ShopErrorPagedCategoriesDataState(this.error);
}

class ShopChangePage extends ShopCategoriesStates {}
