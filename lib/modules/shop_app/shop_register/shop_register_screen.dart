// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/shop_app/shop_register/cubit/register_cubit.dart';
import 'package:flutter_application_1/modules/shop_app/shop_register/cubit/register_states.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();
var emailController = TextEditingController();
var passwordController = TextEditingController();
var nameController = TextEditingController();
var avatarController = TextEditingController();

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegsiterCubit(),
        child: BlocConsumer<RegsiterCubit, ShopRegisterStates>(
          listener: (BuildContext context, state) {
            if (state is ShopRegisterSuccessState &&
                RegsiterCubit.get(context).IsAvailable ==
                    {"isAvailable": false} &&
                state is ShopRegisterIsAvailableSuccessState) {
              Navigator.pop(context);
              ShowToastComponant(context,
                  msg: 'Registeration done Successfuly',
                  state: ToastStates.SUCCESS);
            }
            if ((state is ShopRegisterErrorState &&
                    state is ShopRegisterIsAvailableErrorState) ||
                RegsiterCubit.get(context).IsAvailable ==
                    {"isAvailable": true}) {
              ShowToastComponant(context,
                  msg: 'Please enter a correct email and password',
                  state: ToastStates.ERROR);
            }
          },
          builder: (BuildContext context, state) => Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeAppMode();
                    },
                    icon: const Icon(Icons.brightness_4_rounded))
              ],
              title: const Text('Regestiration'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 125,
                        ),
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            hintText: 'email',
                            labelText: 'email',
                            prefix: const Icon(Icons.email),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: nameController,
                            inputType: TextInputType.name,
                            hintText: 'Name',
                            labelText: 'Name',
                            prefix: const Icon(Icons.person),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: avatarController,
                            inputType: TextInputType.url,
                            hintText: 'avatar',
                            labelText: 'avatar',
                            prefix: const Icon(Icons.person),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter a picture';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            inputType: TextInputType.emailAddress,
                            hintText: 'Password',
                            labelText: 'Password',
                            prefix: const Icon(Icons.lock),
                            suffix: RegsiterCubit.get(context).suffix,
                            suffixPress: () {
                              RegsiterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            isPassword: RegsiterCubit.get(context).isPassword,
                            onSubmited: (value) {
                              if (formKey.currentState!.validate()) {
                                RegsiterCubit.get(context)
                                    .isAvailable(email: emailController.text);
                                RegsiterCubit.get(context).userRegister(
                                    password: passwordController.text,
                                    email: emailController.text,
                                    name: nameController.text,
                                    avatar: avatarController.text);
                              }
                              return null;
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (BuildContext context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegsiterCubit.get(context)
                                      .isAvailable(email: emailController.text);
                                  RegsiterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      avatar: avatarController.text);
                                }
                              },
                              text: 'Register',
                              isUpperCase: true),
                          fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
