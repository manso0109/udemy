// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/ShopLayout/shop_layout.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/models/shop_app/login_model.dart';
import 'package:flutter_application_1/modules/shop_app/categories/cat_cubit/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/login/cubit/login_cubit.dart';
import 'package:flutter_application_1/modules/shop_app/login/cubit/login_states.dart';
import 'package:flutter_application_1/modules/shop_app/shop_register/shop_register_screen.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();
var emailController = TextEditingController();
var passwordController = TextEditingController();
ShopLoginModel? loginModel;

// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {
  var id;
  dynamic username;

  ShopLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (BuildContext context, ShopLoginStates state) {
            if (state is ShopLoginSuccessState) {
              navigateAndFinish(context, const ShopLayout());
              ShowToastComponant(context,
                  msg: 'Login Successfuly', state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                      key: 'access_token', value: state.loginModel?.token)
                  .then((value) {
                print(value);
              });
              ShopCubit.get(context)
                  .GetHomeData(token = state.loginModel?.token);
              ShopCubit.get(context).GetproductData();
              ShopCategoriesCubit.get(context).GetCategoriesData();
            }
            if (state is ShopLoginErrorState) {
              ShowToastComponant(context,
                  msg: 'Please enter a correct email and password',
                  state: ToastStates.ERROR);
            }
          },
          builder: (BuildContext context, ShopLoginStates state) => Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeAppMode();
                    },
                    icon: const Icon(Icons.brightness_4_rounded))
              ],
              title: const Text('Login Screen'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Login now to browse our hot offers',
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
                          controller: passwordController,
                          inputType: TextInputType.emailAddress,
                          hintText: 'Password',
                          labelText: 'Password',
                          prefix: const Icon(Icons.lock),
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPress: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          onSubmited: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  username: emailController.text,
                                  password: passwordController.text);
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
                        condition: state is! ShopLoginLoadingState,
                        builder: (BuildContext context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    username: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'Login',
                            isUpperCase: true),
                        fallback: (BuildContext context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an accountt ? ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w300),
                          ),
                          defaultTextButton(context, function: () {
                            NavigateTo(context, const ShopRegisterScreen());
                          }, text: 'register now', width: 120, height: 30)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
