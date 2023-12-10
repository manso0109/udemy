// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/cubit/states.dart';
import 'package:flutter_application_1/modules/social_app_modules/edit_profile/edit_profile_screen.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = SocialCubit.get(context).userModel;
          return Column(
            children: [
              Container(
                height: 285,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Card(
                        color: const Color.fromARGB(0, 255, 193, 7),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        margin: const EdgeInsets.all(8),
                        child: CachedNetworkImage(
                            progressIndicatorBuilder: (context, url, progress) {
                              return Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: const Center(
                                      child: CircularProgressIndicator()));
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Text(
                                    'No image available',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 30),
                                  ),
                                ),
                              );
                            },
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              );
                            },
                            imageUrl: userModel!.cover!),
                      ),
                    ),
                    CachedNetworkImage(
                        errorWidget: (context, url, error) {
                          return Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          shape: BoxShape.circle),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          shape: BoxShape.circle,
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                                'https://img.freepik.com/free-vector/flat-design-no-photo-sign_23-2149272417.jpg?w=826&t=st=1700609578~exp=1700610178~hmac=14ea92cb7402eab735147f2319a5ce808af52634b1196ba058425cdf6304eb35'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ],
                                ),
                              ]);
                        },
                        imageBuilder: (context, imageProvider) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: BoxShape.circle),
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ],
                          );
                        },
                        imageUrl: userModel.image!)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${userModel.name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w900, fontSize: 22),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      height: 60,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                      color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '100',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      height: 60,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Photos',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                      color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '100',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      height: 60,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Following',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                      color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '100',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      height: 60,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Followers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                      color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '10k',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () {}, child: const Text('Add photo'))),
                  const SizedBox(
                    width: 20,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      NavigateTo(context, const EditProfileScreen());
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 25,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance.subscribeToTopic('');
                        },
                        child: const Text('Subscribe')),
                    const Spacer(),
                    OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance.unsubscribeFromTopic('');
                        },
                        child: const Text('Unsubscribe')),
                  ],
                ),
              )
            ],
          );
        });
  }
}
