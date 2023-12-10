import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/social_layout.dart';
import 'package:flutter_application_1/modules/social_app_modules/social_register/cubit/register_cubit.dart';
import 'package:flutter_application_1/modules/social_app_modules/social_register/cubit/register_states.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();
var emailController = TextEditingController();
var passwordController = TextEditingController();
var nameController = TextEditingController();
var phoneController = TextEditingController();

class SocialRegisterScreen extends StatelessWidget {
  const SocialRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegsiterCubit(),
        child: BlocConsumer<RegsiterCubit, SocialRegisterStates>(
          listener: (BuildContext context, state) {
            if (state is SocialCreateUserSuccessState) {
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                navigateAndFinish(context, const SocialLayout());
                SocialCubit.get(context).GetUser();
              });

              ShowToastComponant(context,
                  msg: 'Register done successfully',
                  state: ToastStates.SUCCESS);
            }
            if ((state is SocialRegisterErrorState)) {
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
                        const SizedBox(
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
                          'Register now to communicate with friends',
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
                            controller: phoneController,
                            inputType: TextInputType.phone,
                            hintText: 'phone',
                            labelText: 'phone',
                            prefix: const Icon(Icons.phone),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone number';
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
                            // ignore: body_might_complete_normally_nullable
                            onSubmited: (value) {
                              if (formKey.currentState!.validate()) {
                                RegsiterCubit.get(context).userRegister(
                                    cover:
                                        'https://img.freepik.com/free-photo/happy-arab-woman-hijab-portrait-smiling-girl-posing-red-studio-background-young-emotional-woman-human-emotions-facial-expression-concept-front-view_155003-22795.jpg?size=626&ext=jpg&ga=GA1.1.152173877.1700485886&semt=sph',
                                    bio: 'Please enter your bio',
                                    image:
                                        'https://img.freepik.com/free-photo/happy-successful-muslim-businesswoman-posing-outside_74855-2007.jpg?w=740&t=st=1700485965~exp=1700486565~hmac=2c5d492236a5659daa6697a6f269ed26db96fa8d293c14648c5c26c754ca835a',
                                    password: passwordController.text,
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text);
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
                          condition: state is! SocialRegisterLoadingState,
                          builder: (BuildContext context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegsiterCubit.get(context).userRegister(
                                      cover:
                                          'https://img.freepik.com/free-photo/happy-arab-woman-hijab-portrait-smiling-girl-posing-red-studio-background-young-emotional-woman-human-emotions-facial-expression-concept-front-view_155003-22795.jpg?size=626&ext=jpg&ga=GA1.1.152173877.1700485886&semt=sph',
                                      bio: 'Please write your bio',
                                      image:
                                          'https://img.freepik.com/free-photo/happy-successful-muslim-businesswoman-posing-outside_74855-2007.jpg?w=740&t=st=1700485965~exp=1700486565~hmac=2c5d492236a5659daa6697a6f269ed26db96fa8d293c14648c5c26c754ca835a',
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
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
