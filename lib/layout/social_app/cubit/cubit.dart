// ignore_for_file: non_constant_identifier_names, avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cubit/states.dart';
import 'package:flutter_application_1/models/social_app/message_model.dart';
import 'package:flutter_application_1/models/social_app/post_model.dart';
import 'package:flutter_application_1/models/social_app/social_user_model.dart';
import 'package:flutter_application_1/modules/social_app_modules/new_post/new_post_screen.dart';
import 'package:flutter_application_1/modules/social_app_modules/chats/chats_screen.dart';
import 'package:flutter_application_1/modules/social_app_modules/feeds/feeds_screen.dart';
import 'package:flutter_application_1/modules/social_app_modules/settings/settings_screen.dart';
import 'package:flutter_application_1/modules/social_app_modules/users/users_screen.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void GetUser() {
    uId = CacheHelper.getData(key: 'uId');
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      emit(SocialGetUserSuccessState());
      userModel = SocialUserModel.fromJson(value.data()!);
    }).catchError((error) {
      if (userModel == null) {
        CacheHelper.removeData(key: 'uId');
      }
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen()
  ];

  List<String> titles = ['Home', 'Chats', 'posts', 'Users', 'Settings'];

  void ChangeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  String? profileImageUrl;
  void uploadProfileImage({
    required String name,
    required String phone,
    String? cover,
    String? image,
    required String bio,
    String? email,
    bool? isEmailVerified,
  }) {
    emit(SocialUploadProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/$uId/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      emit(SocialUploadProfileImageSuccessState());
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: userModel!.cover,
            image: profileImageUrl,
            email: userModel!.email,
            isEmailVerified: userModel!.isEmailVerified);
        print(value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String? coverImageUrl;
  void uploadCoverImage({
    required String name,
    required String phone,
    String? cover,
    String? image,
    required String bio,
    String? email,
    bool? isEmailVerified,
  }) {
    emit(SocialUploadCoverImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/$uId/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        coverImageUrl = value;
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: coverImageUrl,
            image: userModel?.image,
            email: userModel!.email,
            isEmailVerified: userModel!.isEmailVerified);
        print(value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void UploadProfileAndCoverImage({
    required String name,
    required String phone,
    String? cover,
    String? image,
    required String bio,
    String? email,
    bool? isEmailVerified,
  }) {
    emit(SocialUploadCoverAndProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/$uId/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        updateProfileAndImageUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: coverImageUrl,
            image: userModel?.image,
            email: userModel!.email,
            isEmailVerified: userModel!.isEmailVerified);
        emit(SocialUploadCoverAndProfileImageLoadingState());
        FirebaseStorage.instance
            .ref()
            .child(
                'users/$uId/${Uri.file(profileImage!.path).pathSegments.last}')
            .putFile(profileImage!)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            profileImageUrl = value;
            updateProfileAndImageUser(
                name: name,
                phone: phone,
                bio: bio,
                cover: userModel!.cover,
                image: profileImageUrl,
                email: userModel!.email,
                isEmailVerified: userModel!.isEmailVerified);
          }).catchError((error) {
            emit(SocialUploadCoverAndProfileImageErrorState());
          });
        }).catchError((error) {
          emit(SocialUploadCoverAndProfileImageErrorState());
        });
        emit(SocialUploadCoverAndProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverAndProfileImageErrorState());
      });
    });
  }

  void updateUser({
    required String name,
    required String phone,
    String? cover,
    String? image,
    required String bio,
    String? email,
    bool? isEmailVerified,
  }) {
    emit(SocialUserUpdateLoadingStata());

    SocialUserModel model = SocialUserModel(
        image: image,
        cover: cover,
        name: name,
        email: userModel!.email,
        phone: phone,
        uId: userModel!.uId,
        bio: bio,
        isEmailVerified: userModel!.isEmailVerified);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      emit(SocialUserUpdateSuccessStata());
      GetUser();
    }).catchError((error) {
      emit(SocialUserUpdateErrorStata());
    });
  }

  void updateProfileAndImageUser({
    required String name,
    required String phone,
    String? cover,
    String? image,
    required String bio,
    String? email,
    bool? isEmailVerified,
  }) {
    SocialUserModel model = SocialUserModel(
        image: image,
        cover: cover,
        name: name,
        email: userModel!.email,
        phone: phone,
        uId: userModel!.uId,
        bio: bio,
        isEmailVerified: userModel!.isEmailVerified);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      GetUser();
    }).catchError((error) {});
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadNewPostImage({required String dateTime, required String text}) {
    emit(SocialCreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/$uId/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      emit(SocialCreatePostSuccessState());
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(dateTime: dateTime, text: text, postImage: value);

        print(value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      image: userModel!.image,
      name: userModel!.name,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
      likesList: [],
      commentslist: [],
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialPostImagePickedRemovedState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<dynamic> comments = [];
  List<dynamic> likes = [];

  void getPosts() {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
      // ignore: avoid_types_as_parameter_names
      value.docs.forEachIndexed((Index, element) {
        PostModel singlePost = PostModel.fromJson(element.data());
        comments.add(singlePost.commentslist);
        likes.add(singlePost.likesList);
        postsId.add(element.id);
        posts.add(singlePost);
      });

      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostErrorState(error));
    });
  }

  List<dynamic>? availableLikes;

  void likePost(String postId, index, liked) {
    availableLikes = likes[index];
    if (availableLikes?.toString().contains("${userModel?.uId}") == false) {
      availableLikes?.add({'${userModel?.uId}': true});
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update({'likes': availableLikes}).then((value) {
        availableLikes = [];
        emit(SocialLikePostSuccessState());
      }).catchError((error) {
        emit(SocialLikePostErrorState(error.toString()));
      });
    } else if (availableLikes?.toString().contains("${userModel?.uId}") ==
        true) {
      availableLikes
          ?.removeWhere((element) => element['${userModel?.uId}'] != null);
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update({'likes': availableLikes}).then((value) {
        availableLikes = [];
        emit(SocialLikePostSuccessState());
      }).catchError((error) {
        emit(SocialLikePostErrorState(error.toString()));
      });
    }
  }

  void commentPost(String postId, String comment, index) {
    comments[index].add({'${userModel?.uId}': comment});
    print(comments[index]);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update({'comment_section': comments[index]}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    users = [];
    emit(SocialGetAllUserLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel?.uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUserSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUserErrorState(error.toString()));
    });
  }

  void sendMessage(
      {required String receiverId,
      required String dateTime,
      required String text}) {
    MessageModel model = MessageModel(
        text: text,
        senderId: userModel?.uId,
        receiverId: receiverId,
        dateTime: dateTime);

    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    // set reciver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}
