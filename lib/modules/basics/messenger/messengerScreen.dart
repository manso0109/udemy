// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MessengarScreen extends StatelessWidget {
  const MessengarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 20,
          elevation: 0.0,
          title: const Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-photo/portrait-young-woman-with-natural-make-up_23-2149084942.jpg'),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Chats',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 25,
                    child: Icon(
                      Icons.camera_alt,
                      size: 15,
                      color: Colors.white,
                    ))),
            IconButton(
                onPressed: () {},
                icon: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 25,
                    child: Icon(
                      Icons.edit,
                      size: 15,
                      color: Colors.white,
                    ))),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12),
                padding: const EdgeInsets.all(5),
                child: const Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Search'),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 110,
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildChatItem2();
                  },
                  itemCount: 10,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: 20)
            ]),
          ),
        ));
  }
  // 1 build item
  // 2 build list
  // 3 add item to list

  Widget buildChatItem() {
    return Row(
      children: [
        const Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/portrait-young-woman-with-natural-make-up_23-2149084942.jpg'),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: 2, end: 2),
              child: CircleAvatar(
                radius: 9,
                backgroundColor: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: 2, end: 2),
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ahmed Mansour el gamed neek asdfas  sadfasdf  asdf ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'hello momken net3araf ya 7abeb 2albyafdgdf dsfgsdfg sd sdfg sdfg sd',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                    ),
                  ),
                  const Text('2:00 PM')
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

Widget buildChatItem2() {
  return const SizedBox(
    width: 60,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/portrait-young-woman-with-natural-make-up_23-2149084942.jpg'),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: 2, end: 2),
              child: CircleAvatar(
                radius: 9,
                backgroundColor: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: 2, end: 2),
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'El Moza El gamda gamda awy kaman',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
