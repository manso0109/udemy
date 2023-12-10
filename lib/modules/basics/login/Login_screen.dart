// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/Components/components.dart';

export '../home/homeScreen.dart';
export '../../../main.dart';
// 1 reusable componant
// 2 refactor
// 3 quality

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  defaultFormField(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      hintText: 'Email Address',
                      labelText: 'Email Address',
                      prefix: const Icon(Icons.email)),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty';
                        }
                        return null;
                      },
                      controller: passwordController,
                      inputType: TextInputType.emailAddress,
                      hintText: 'Password',
                      labelText: 'Password',
                      isPassword: isPassword,
                      prefix: const Icon(Icons.lock),
                      suffix:
                          isPassword ? Icons.visibility : Icons.visibility_off,
                      suffixPress: () {
                        print(isPassword);
                        setState(() {
                          isPassword = !isPassword;
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      },
                      text: 'login'),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: defaultButton(
                        background: Colors.black,
                        width: 300,
                        isUpperCase: false,
                        function: () {
                          print(emailController.text);
                          print(passwordController.text);
                        },
                        text: 'login'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('don\'t have and account?'),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {}, child: const Text('Register now'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
