// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/categories/cat_cubit/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/login/cubit/login_cubit.dart';
import 'package:flutter_application_1/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

var formKey = GlobalKey<FormState>();
late Database database;
var bottomSheetController;
var scaffoldKey = GlobalKey<ScaffoldState>();
var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();
var keyboardType = TextInputType.text;
var timeType = TextInputType.datetime;
var dateType = TextInputType.datetime;
String? token;
String? uId;

// POST
//UPDATE
//DELETE
//GET
// base url : https://newsapi.org/
// method url : v2/top-headlines?
// queries : country=eg&category=business&apiKey=70a37f5cb4aa4fd68f3cf604fe89a980

void SignOut(context) {
  ShopCubit.get(context).offset = 0;
  ShopCubit.get(context).page = 1;
  ShopCubit.get(context).currentIndex = 0;
  inat = 0;
  ShopCategoriesCubit.get(context).productData = null;
  ShopCubit.get(context).productData = null;
  ShopCubit.get(context).pagedData = null;
  ShopCubit.get(context).loginModel = null;
  CacheHelper.removeData(key: 'email');
  CacheHelper.removeData(key: 'password');
  CacheHelper.removeData(
    key: 'access_token',
  ).then((value) {
    if (value!) {
      navigateAndFinish(context, ShopLoginScreen());
      ShopLoginCubit();
    }
  });
}

void updateUser(coverImage, profileImage, context, nameController,
    phoneController, bioController, userModel) {
  if (coverImage != null && profileImage == null) {
    SocialCubit.get(context).uploadCoverImage(
        name: nameController.text,
        phone: phoneController.text,
        bio: bioController.text);
  } else if (profileImage != null && coverImage == null) {
    SocialCubit.get(context).uploadProfileImage(
        name: nameController.text,
        phone: phoneController.text,
        bio: bioController.text);
  } else if (coverImage != null && profileImage != null) {
    SocialCubit.get(context).UploadProfileAndCoverImage(
        name: nameController.text,
        phone: phoneController.text,
        bio: bioController.text);
  } else if (coverImage == null && profileImage == null) {
    SocialCubit.get(context).updateUser(
      image: userModel.image,
      cover: userModel.cover,
      name: nameController.text,
      phone: phoneController.text,
      bio: bioController.text,
    );
  }
}
