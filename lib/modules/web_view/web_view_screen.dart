import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_application_1/shared/Cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('WebView'),
          ),
          body: WebViewWidget(
            controller: AppCubit.get(context).controller,
          ),
        );
      },
      listener: (BuildContext context, AppStates state) {},
    );
  }
}
