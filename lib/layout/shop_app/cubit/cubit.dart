// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/states.dart';
import 'package:flutter_application_1/models/shop_app/list_model.dart';
import 'package:flutter_application_1/models/shop_app/login_model.dart';
import 'package:flutter_application_1/modules/shop_app/categories/categories_screen.dart';
import 'package:flutter_application_1/modules/shop_app/products/products_screen.dart';
import 'package:flutter_application_1/modules/shop_app/settings/settings_screen.dart';
import 'package:flutter_application_1/modules/shop_app/users/user_screen.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_application_1/shared/network/end_points.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const UsersScreen(),
    const ProductsScreen(),
    const CategoriesScreen(),
    const SettingsScreen2()
  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNav());
  }

  ShopLoginModel? loginModel;
  void GetHomeData(token) {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      token: token,
      url: USERS,
    ).then((value) {
      loginModel = ShopLoginModel.fromjson(value!.data!);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error.toString()));
      print(error);
    });
  }

  ListModel? productData = ListModel();
  int? offset = 0;
  int page = 1;
  List<int>? pageList;
  void GetproductDat2a() {
    emit(ShopLoadingProductsDataState());

    DioHelper.getData(
      query: {},
      url: PRODUCTS,
    ).then((value) {
      productData = ListModel.fromJson({"data": value?.data});
      emit(ShopSuccessProductsDataState());
      pageList = [];
      offset = 0;
      page = 1;
      while (offset! < productData!.data!.length) {
        offset = offset! + 10;
        pageList?.add(page);
        page++;
        emit(ShopPagination());
      }
    }).catchError((error) {
      emit(ShopErrorProductsDataState(error.toString()));
      print(error);
    });
  }

  ListModel? pagedData = ListModel();
  void GetproductData() {
    emit(ShopLoadingPagedProductsDataState());
    DioHelper.getData(
      query: {},
      url: "$PRODUCTS?offset=$offset&limit=10",
    ).then((value) {
      pagedData = ListModel.fromJson({"data": value!.data});

      emit(ShopSuccessPagedProductsDataState());
    }).catchError((error) {
      emit(ShopErrorPagedProductsDataState(error.toString()));
      print(error);
    });
  }

  void changePage(index) {
    offset = (pageList![index] - 1) * 10;
    emit(ShopChangePage());
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

  void updateUser(
      {required String email, required String name, required int ID}) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      token: token,
      url: REGISTER + '/$ID',
      query: null,
      data: {
        'email': email,
        'name': name,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromjson(value!.data!);
      emit(ShopSuccessUpdateUserState());
    }).catchError((error) {
      emit(ShopErrorUpdateUserState(error.toString()));
      print(error);
    });
  }
}
