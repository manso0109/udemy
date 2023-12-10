// ignore_for_file: camel_case_types

abstract class searchStates {}

class intialSearchState extends searchStates {}

class SearchLoadingState extends searchStates {}

class SearchSuccessState extends searchStates {}

class SearchErrorState extends searchStates {
  final String error;
  SearchErrorState(this.error);
}

class SearchSliderState extends searchStates {}

class ShopChangeCategory extends searchStates {}

class ShopLoadingDeleteProductsDataState extends searchStates {}

class ShopSuccessDeleteProductsDataState extends searchStates {}

class ShopErrorDeleteProductsDataState extends searchStates {
  final String error;
  ShopErrorDeleteProductsDataState(this.error);
}
