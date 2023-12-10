import 'package:flutter/material.dart';

class BMIscreenResult extends StatelessWidget {
  final double result;
  final bool isMale;
  final int age;
  const BMIscreenResult(
      {super.key, required this.result, required this.isMale, required this.age});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Result'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Gender : ${isMale ? 'MALE' : 'FEMALE'}',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            'Result : ${result.round()}',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            'Age: $age',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
