// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/social_app/social_user_model.dart';
import 'package:flutter_application_1/modules/social_app_modules/social_register/cubit/register_states.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RegsiterCubit extends Cubit<SocialRegisterStates> {
  RegsiterCubit() : super(SocialRegisterInitialState());

  static RegsiterCubit get(context) => BlocProvider.of(context);

  void CreateUser({
    required String email,
    required String name,
    required String phone,
    required String uId,
    required String image,
    required String cover,
    required String bio,
    required bool isEmailVerified,
  }) {
    SocialUserModel model = SocialUserModel(
        cover: cover,
        image: image,
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        bio: bio,
        isEmailVerified: isEmailVerified);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState(uId));
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String image,
    required String cover,
    required String bio,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.saveData(key: 'uId', value: value.user?.uid);
      CreateUser(
        bio: bio,
        cover: cover,
        image: image =
            'https://img.freepik.com/free-photo/happy-successful-muslim-businesswoman-posing-outside_74855-2007.jpg?w=740&t=st=1700485965~exp=1700486565~hmac=2c5d492236a5659daa6697a6f269ed26db96fa8d293c14648c5c26c754ca835a',
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
        isEmailVerified: false,
      );
      print(value.user?.email);
      print(value.user?.uid);
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  dynamic IsAvailable;

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;
    emit(RegisterPasswordVisibilty());
  }
}
