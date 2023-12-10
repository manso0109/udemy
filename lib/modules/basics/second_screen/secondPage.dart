// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';

export '../home/homeScreen.dart';
export '../../../main.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
        ),
        title: const Text(
          'manso is the killer bitch',
        ),
        actions: const [
          IconButton(
            onPressed: onNotification2,
            icon: Icon(
              Icons.abc_outlined,
              color: Colors.black26,
            ),
          ),
          IconButton(
              // call it as an annonnymous function
              onPressed: onNotification,
              icon: Icon(Icons.access_alarm_rounded)),
          IconButton(
            onPressed: onNotification2,
            icon: Text('MFJ'),
          ),
          Icon(
            Icons.search_off,
            color: Colors.redAccent,
          ),
          TextButton(onPressed: onNotification2, child: Text('FK')),
        ],
        centerTitle: true,
        elevation: 30,
        backgroundColor: Colors.amberAccent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(10))),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      const Image(
                        image: NetworkImage(
                            'https://p1.pxfuel.com/preview/653/702/399/rose-flower-flowers-red-rose-royalty-free-thumbnail.jpg'),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.5),
                        child: const Text(
                          'Beautiful flower',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              const Text(
                'manso',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'second',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'third',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'fourth',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'manso',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'second',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'third',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'fourth',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'manso',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'second',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'third',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'fourth',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'manso',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'second',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'third',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'fourth',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'manso',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'second',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'third',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'fourth',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'manso',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'second',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'third',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'fourth',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'manso',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'second',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'third',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'fourth',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'manso',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'second',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'third',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const Text(
                'fourth',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void onNotification() {
  print('button pressed sucessfully');
}

void onNotification2() {
  print('hello mother father');
}
