import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Text('Users Screen', style: Theme.of(context).textTheme.bodyLarge));
  }
}
