// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shop_app/categories_list.dart';
import 'package:flutter_application_1/modules/shop_app/categories/cat_cubit/states.dart';
import 'package:flutter_application_1/shared/network/end_points.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCategoriesCubit extends Cubit<ShopCategoriesStates> {
  ShopCategoriesCubit() : super(ShopCategoriesInitialState());

  static ShopCategoriesCubit get(context) => BlocProvider.of(context);
  int? offset = 0;
  int page = 1;
  List<int>? pageList = [];
  List<String>? catList = [];
  List<int>? catIntList = [];

  CategoryListModel? productData = CategoryListModel();
  void GetCategoriesData() {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(
      query: {},
      url: CATEGORIES,
    ).then((value) {
      productData = CategoryListModel.fromJson({"catData": value!.data});
      catList!.add('none');
      catIntList!.add(0);
      productData?.catData?.forEach((element) {
        catList!.add(element.name.toString());
        catIntList!.add(element.id!.toInt());
        List<dynamic> finalList = [catList, catIntList];

        print(catList);
        print(catIntList);
        print(finalList);
      });
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      emit(ShopErrorCategoriesDataState(error.toString()));
      print(error);
    });
  }

  CategoryListModel? pagedData = CategoryListModel();
  void GetCategoryPagedData() {
    emit(ShopLoadingPagedCategoriesDataState());
    DioHelper.getData(
      query: {},
      url: CATEGORIES,
    ).then((value) {
      pagedData = CategoryListModel.fromJson({"catData": value!.data});
      emit(ShopSuccessPagedCategoriesDataState());
    }).catchError((error) {
      emit(ShopErrorPagedCategoriesDataState(error.toString()));
      print(error);
    });
  }

  ScrollController listScrollController = ScrollController();

  void scrollToTop() {
    final position = listScrollController.position.minScrollExtent;
    if (listScrollController.hasClients) {
      listScrollController.animateTo(
        position,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }
}
