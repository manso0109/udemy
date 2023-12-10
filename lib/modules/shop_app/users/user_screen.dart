// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/states.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var emailController = TextEditingController();
var nameController = TextEditingController();
var formKey = GlobalKey<FormState>();

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel != null,
          builder: (BuildContext context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: AppCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Text(
                          'Your ID :',
                          style: Theme.of(context).textTheme.bodyLarge?.apply(
                              color: AppCubit.get(context).isDark
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        const Spacer(),
                        Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppCubit.get(context).isDark
                                    ? Colors.black
                                    : Colors.white),
                            child: Center(
                                child: Text(
                              '${cubit.loginModel?.id}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25),
                            ))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: AppCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Text(
                          'Your Email :',
                          style: Theme.of(context).textTheme.bodyLarge?.apply(
                              color: AppCubit.get(context).isDark
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        const Spacer(),
                        Container(
                            height: 100,
                            width: 240,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppCubit.get(context).isDark
                                    ? Colors.black
                                    : Colors.white),
                            child: Center(
                                child: Text(
                              '${cubit.loginModel?.email}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                            ))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                              errorWidget: (context, url, error) => Center(
                                      child: Text(
                                    'No image available',
                                    style: TextStyle(
                                        color: AppCubit.get(context).isDark
                                            ? Colors.black
                                            : Colors.white),
                                  )),
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image:
                                        DecorationImage(image: imageProvider),
                                  ),
                                );
                              },
                              imageUrl: '${cubit.loginModel!.avatar}'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 205,
                            child: Text(
                              '${cubit.loginModel!.name}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                            ),
                          ),
                          Text(
                            'role : ${cubit.loginModel!.role}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                      child: IconButton(
                          onPressed: () {
                            emailController.text =
                                ShopCubit.get(context).loginModel!.email!;
                            nameController.text =
                                ShopCubit.get(context).loginModel!.name!;
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor:
                                    const Color.fromARGB(0, 255, 193, 7),
                                context: context,
                                builder: (BuildContext context) {
                                  return Form(
                                    key: formKey,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadiusDirectional
                                                    .only(
                                                    topStart:
                                                        Radius.circular(40),
                                                    topEnd:
                                                        Radius.circular(40)),
                                            color: AppCubit.get(context).isDark
                                                ? Colors.grey[900]
                                                : Colors.white),
                                        height: 350,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Text(
                                                'Update your profile',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: defaultFormField(
                                                    controller: emailController,
                                                    inputType: TextInputType
                                                        .emailAddress,
                                                    hintText: 'email',
                                                    labelText: 'email',
                                                    prefix:
                                                        const Icon(Icons.email),
                                                    validate: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'please enter your email address';
                                                      }
                                                      return null;
                                                    }),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: defaultFormField(
                                                    controller: nameController,
                                                    inputType:
                                                        TextInputType.name,
                                                    hintText: 'name',
                                                    labelText: 'name',
                                                    prefix: const Icon(
                                                        Icons.person),
                                                    validate: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'please enter your name';
                                                      }
                                                      return null;
                                                    }),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              defaultTextButton(context,
                                                  function: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  ShopCubit.get(context)
                                                      .updateUser(
                                                          ID: ShopCubit
                                                                  .get(context)
                                                              .loginModel!
                                                              .id!,
                                                          email:
                                                              emailController
                                                                  .text,
                                                          name: nameController
                                                              .text);
                                                  ShopCubit.get(context)
                                                      .loginModel = null;

                                                  Navigator.pop(context);
                                                }
                                              },
                                                  text: 'Apply',
                                                  width: 150,
                                                  height: 30)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: AppCubit.get(context).isDark
                                ? Colors.black
                                : Colors.white,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            );
          },
          fallback: (BuildContext context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 250,
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                  defaultTextButton(context, function: () {
                    cubit.productData = null;
                    cubit.pagedData = null;
                    cubit.GetHomeData(token);
                    cubit.GetproductDat2a();
                    cubit.GetproductData();
                  }, text: 'Refresh', width: 120, height: 30),
                ],
              ),
            );
          },
        );
      },
      listener: (BuildContext context, ShopStates state) {
        if (state is ShopSuccessUpdateUserState &&
            ShopCubit.get(context).loginModel == null) {
          ShopCubit.get(context).GetHomeData(token);
        }
        if (state is ShopSuccessUpdateUserState) {
          ShowToastComponant(context,
              msg: 'Profile updated succesfully', state: ToastStates.SUCCESS);
        }
        if (state is ShopErrorUpdateUserState) {
          ShowToastComponant(context,
              msg: 'Something Went wrong', state: ToastStates.ERROR);
        }
      },
    );
  }
}
