import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/cubit/states.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if (state is SocialUserUpdateSuccessStata) {
          SocialCubit.get(context).profileImage = null;
        } else if (state is SocialUserUpdateSuccessStata) {
          SocialCubit.get(context).coverImage = null;
        } else if (state is SocialUploadCoverAndProfileImageSuccessState) {
          SocialCubit.get(context).coverImage = null;
          SocialCubit.get(context).profileImage = null;
        }
      },
      builder: (context, SocialStates state) {
        var formKey = GlobalKey<FormState>();
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        var nameController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            defaultTextButton(context, function: () {
              {
                if (formKey.currentState!.validate()) {
                  updateUser(coverImage, profileImage, context, nameController,
                      phoneController, bioController, userModel);
                }
              }
            }, text: 'Update', width: 100, height: 30)
          ]),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingStata ||
                      state is SocialUploadProfileImageLoadingState ||
                      state is SocialUploadCoverImageLoadingState ||
                      state is SocialUploadCoverAndProfileImageLoadingState)
                    const LinearProgressIndicator(
                      minHeight: 3,
                    )
                  else
                    Container(
                      height: 3,
                    ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 285,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: coverImageWidget(
                                    state, coverImage, userModel)),
                            state is SocialUploadProfileImageLoadingState ||
                                    state
                                        is SocialUploadCoverAndProfileImageLoadingState ||
                                    state is SocialUserUpdateLoadingStata ||
                                    state
                                        is SocialUploadProfileImageSuccessState ||
                                    state
                                        is SocialUploadCoverAndProfileImageSuccessState
                                ? Container(
                                    width: 160,
                                    height: 160,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black),
                                    child: const Center(
                                        child: CircularProgressIndicator()))
                                : profileImageWidget(profileImage, userModel)
                          ],
                        ),
                        Container(
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          margin: const EdgeInsetsDirectional.only(
                              end: 15, top: 15),
                          child: IconButton(
                            onPressed: () {
                              SocialCubit.get(context).getCoverImage();
                            },
                            icon: const Icon(Icons.edit_document),
                            color: Colors.white,
                            iconSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: state is SocialUploadCoverImageLoadingState ||
                            state
                                is SocialUploadCoverAndProfileImageLoadingState ||
                            state is SocialUserUpdateLoadingStata ||
                            state
                                is SocialUploadCoverAndProfileImageSuccessState ||
                            state is SocialUploadCoverImageSuccessState
                        ? textFormFieldLoadingWidget()
                        : defaultFormField(
                            controller: nameController,
                            inputType: TextInputType.name,
                            hintText: 'Name',
                            labelText: 'Name',
                            prefix: const Icon(Icons.person),
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'name must not be empty';
                              }
                              return null;
                            }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: state is SocialUploadCoverImageLoadingState ||
                            state
                                is SocialUploadCoverAndProfileImageLoadingState ||
                            state is SocialUserUpdateLoadingStata ||
                            state
                                is SocialUploadCoverAndProfileImageSuccessState ||
                            state is SocialUploadCoverImageSuccessState
                        ? textFormFieldLoadingWidget()
                        : defaultFormField(
                            controller: bioController,
                            inputType: TextInputType.name,
                            hintText: 'Bio',
                            labelText: 'Bio',
                            prefix: const Icon(Icons.info),
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'bio must not be empty';
                              }
                              return null;
                            }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: state is SocialUploadCoverImageLoadingState ||
                            state
                                is SocialUploadCoverAndProfileImageLoadingState ||
                            state is SocialUserUpdateLoadingStata ||
                            state
                                is SocialUploadCoverAndProfileImageSuccessState ||
                            state is SocialUploadCoverImageSuccessState
                        ? textFormFieldLoadingWidget()
                        : defaultFormField(
                            controller: phoneController,
                            inputType: TextInputType.name,
                            hintText: 'Phone',
                            labelText: 'Phone',
                            prefix: const Icon(Icons.phone),
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'phone must not be empty';
                              }
                              return null;
                            }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget textFormFieldLoadingWidget() {
  return Container(
      width: double.infinity,
      height: 59,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          border: BoxBorder.lerp(
              const Border(
                bottom: BorderSide(width: 2, color: Colors.white),
                left: BorderSide(width: 2, color: Colors.white),
                right: BorderSide(width: 2, color: Colors.white),
                top: BorderSide(width: 2, color: Colors.white),
              ),
              const Border(
                bottom: BorderSide(width: 1.5, color: Colors.white),
                left: BorderSide(width: 1.5, color: Colors.white),
                right: BorderSide(width: 1.5, color: Colors.white),
                top: BorderSide(width: 1.5, color: Colors.white),
              ),
              2)),
      child: const Center(child: CircularProgressIndicator()));
}

Widget coverImageWidget(state, coverImage, userModel) {
  return Card(
    color: const Color.fromARGB(0, 255, 193, 7),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: const EdgeInsets.all(8),
    child: CachedNetworkImage(
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
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
          );
        },
        imageBuilder: (context, imageProvider) {
          return state is SocialUploadCoverImageLoadingState ||
                  state is SocialUploadCoverAndProfileImageLoadingState ||
                  state is SocialUserUpdateLoadingStata ||
                  state is SocialUploadCoverAndProfileImageSuccessState ||
                  state is SocialUploadCoverImageSuccessState
              ? Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      image: DecorationImage(
                          image: coverImage == null
                              ? imageProvider
                              : FileImage(coverImage),
                          fit: BoxFit.cover)),
                );
        },
        imageUrl: userModel.cover!),
  );
}

Widget profileImageWidget(profileImage, userModel) {
  return CachedNetworkImage(
      errorWidget: (context, url, error) {
        return Stack(alignment: Alignment.bottomRight, children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle),
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://img.freepik.com/free-vector/flat-design-no-photo-sign_23-2149272417.jpg?w=826&t=st=1700609578~exp=1700610178~hmac=14ea92cb7402eab735147f2319a5ce808af52634b1196ba058425cdf6304eb35'),
                      fit: BoxFit.cover,
                    )),
              ),
            ],
          ),
          Container(
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            margin: const EdgeInsetsDirectional.only(end: 7.5, bottom: 7.5),
            child: IconButton(
              onPressed: () {
                SocialCubit.get(context).getImage();
              },
              icon: const Icon(Icons.edit_document),
              color: Colors.white,
              iconSize: 20,
            ),
          )
        ]);
      },
      imageBuilder: (context, imageProvider) {
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
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle),
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: profileImage == null
                            ? imageProvider
                            : FileImage(profileImage),
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
            Container(
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              margin: const EdgeInsetsDirectional.only(end: 7.5, bottom: 7.5),
              child: IconButton(
                onPressed: () {
                  SocialCubit.get(context).getImage();
                },
                icon: const Icon(Icons.edit_document),
                color: Colors.white,
                iconSize: 20,
              ),
            ),
          ],
        );
      },
      imageUrl: userModel.image!);
}
