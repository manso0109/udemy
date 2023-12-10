import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/social_layout.dart';
import 'package:flutter_application_1/modules/social_app_modules/social_login/cubit/social_login_states.dart';
import 'package:flutter_application_1/modules/social_app_modules/social_login/cubit/social_login_cubit.dart';
import 'package:flutter_application_1/modules/social_app_modules/social_register/social_register_screen.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (BuildContext context, Object? state) {
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, const SocialLayout());
              SocialCubit.get(context).GetUser();
            });

            ShowToastComponant(context,
                msg: 'Login success', state: ToastStates.SUCCESS);
          }
          if (state is SocialLoginErrorState) {
            ShowToastComponant(context,
                msg: state.error, state: ToastStates.ERROR);
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
                      'Login now to communicate with friends',
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
                        suffix: SocialLoginCubit.get(context).suffix,
                        suffixPress: () {
                          SocialLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        isPassword: SocialLoginCubit.get(context).isPassword,
                        onSubmited: (value) {
                          if (formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
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
                      condition: state is! SocialLoginLoadingState,
                      builder: (BuildContext context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
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
                          NavigateTo(context, const SocialRegisterScreen());
                        }, text: 'register now', width: 120, height: 30)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
