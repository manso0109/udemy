// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // main axis alignment = start
    // cross axis alignment = center
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
        body: Column(children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.blue,
                    child: const Text(
                      'manso is the killer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child: const TextButton(
                      onPressed: onNotification2,
                      child: Text(
                        'fuck you',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.deepOrange,
                    child: const Text(
                      'manso is fkng beast',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.deepPurple,
                    child: const TextButton(
                      onPressed: onNotification2,
                      child: Text('duck',
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: double.infinity,
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: Colors.green,
                    child: const Text(
                      'first',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    child: const Text('second',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    color: Colors.amber,
                    child: const Text('third',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    color: Colors.purple,
                    child: const Text('fourth',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}

// when notification icon is clicked
void onNotification() {
  print('button pressed sucessfully');
}

void onNotification2() {
  print('hello mother father');
}
