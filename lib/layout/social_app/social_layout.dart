// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/cubit/states.dart';
import 'package:flutter_application_1/modules/social_app_modules/new_post/new_post_screen.dart';
import 'package:flutter_application_1/modules/social_app_modules/social_login/social_login_screen.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
}

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('on message opened app');
      print(event.data.toString());
      ShowToastComponant(context,
          msg: 'on message opened app', state: ToastStates.SUCCESS);
    });
    FirebaseMessaging.onMessage.listen((event) {
      print('on message');
      print(event.data.toString());
      ShowToastComponant(context,
          msg: 'on message', state: ToastStates.SUCCESS);
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, SocialStates state) {
        if (state is SocialNewPostState) {
          NavigateTo(context, const NewPostScreen());
        }
      },
      builder: (BuildContext context, SocialStates state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notifications)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              TextButton(
                  onPressed: () {
                    CacheHelper.removeData(key: 'uId');
                    cubit.posts = [];
                    cubit.postsId = [];
                    cubit.likes = [];
                    cubit.comments = [];
                    FirebaseAuth.instance.signOut();
                    navigateAndFinish(context, const SocialLoginScreen());
                  },
                  child: const Text('Sign out'))
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConditionalBuilder(
              builder: (context) {
                return Column(
                  children: [
                    !FirebaseAuth.instance.currentUser!.emailVerified
                        ? Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            height: 70,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.info,
                                  size: 40,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Expanded(
                                    child: Text(
                                  'Please verify your email',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                defaultButton(
                                    width: 80,
                                    function: () {
                                      FirebaseAuth.instance.currentUser!
                                          .sendEmailVerification()
                                          .then((value) {
                                        ShowToastComponant(context,
                                            msg: 'check your mail',
                                            state: ToastStates.SUCCESS);
                                      }).catchError((error) {});
                                    },
                                    text: 'Send'),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          )
                        : Container(),
                    cubit.screens[cubit.currentIndex]
                  ],
                );
              },
              condition: SocialCubit.get(context).userModel != null,
              fallback: (BuildContext context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_rounded), label: 'Add'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_history), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            onTap: (index) {
              cubit.ChangeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
