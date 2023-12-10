// ignore: camel_case_types
abstract class newsState {}

class NewsInitialState extends newsState {}

class NewsGetBusinessSuccessState extends newsState {}

class NewsGetBusinessLoadingState extends newsState {}

class NewsGetBusinessErrorState extends newsState {
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsBottomNavState extends newsState {}

class NewsGetSportsSuccessState extends newsState {}

class NewsGetSportsLoadingState extends newsState {}

class NewsGetSPortsErrorState extends newsState {
  final String error;
  NewsGetSPortsErrorState(this.error);
}

class NewsGetScienceSuccessState extends newsState {}

class NewsGetScienceLoadingState extends newsState {}

class NewsGetScienceErrorState extends newsState {
  final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsGetSearchSuccessState extends newsState {}

class NewsGetSearchLoadingState extends newsState {}

class NewsGetSearchErrorState extends newsState {
  final String error;
  NewsGetSearchErrorState(this.error);
}

class NewsStartWebView extends newsState {}
