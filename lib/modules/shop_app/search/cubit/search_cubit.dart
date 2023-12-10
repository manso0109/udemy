// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shop_app/list_search_model.dart';
import 'package:flutter_application_1/modules/shop_app/search/cubit/search_states.dart';
import 'package:flutter_application_1/shared/network/end_points.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<searchStates> {
  SearchCubit() : super(intialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  ListSearchModel? catModel;
  void Search(
      {required String? title,
      required String priceMin,
      required String priceMax,
      required String ID}) {
    emit(SearchLoadingState());

    DioHelper.getData(
            url: PRODUCTS +
                '?title=$title&price_min=$priceMin&price_max=$priceMax&categoryId=$ID')
        .then((value) {
      catModel = ListSearchModel.fromJson({"data": value!.data});
      print(catModel?.data?.length);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState(error));
      print(error);
    });
  }

  var selectedRange = const RangeValues(0, 10000);

  void changeRange(value) {
    selectedRange = value;

    emit(SearchSliderState());
  }

  var category;

  void changeCategory(value) {
    category = value;
    print(category);
    emit(ShopChangeCategory());
  }

  void deleteData({
    required dynamic ID,
  }) {
    emit(ShopLoadingDeleteProductsDataState());
    DioHelper.deleteData(url: "products/${ID}", query: null).then((value) {
      emit(ShopSuccessDeleteProductsDataState());
      print(value?.data.toString());
    }).catchError((error) {
      emit(ShopErrorDeleteProductsDataState(error.toString()));
      print(error.toString());
    });
  }
}
