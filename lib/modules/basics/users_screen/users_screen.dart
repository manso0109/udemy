// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user/user_model.dart';

// ignore: must_be_immutable
class UsersScreens extends StatelessWidget {
  List<UserModel> dataModel = [
    UserModel(ID: 1, phone: '+02012235548', name: 'manso is the killer'),
    UserModel(ID: 2, phone: '+02012235548', name: 'epona is the killer'),
    UserModel(ID: 3, phone: '+02012235548', name: 'link is the killer'),
    UserModel(ID: 4, phone: '+02012235548', name: 'zelda is the killer'),
    UserModel(ID: 5, phone: '+02012235548', name: 'ahmed is the killer'),
    UserModel(ID: 6, phone: '+02012235548', name: 'salah is the killer'),
    UserModel(ID: 7, phone: '+02012235548', name: 'mousa is the killer'),
    UserModel(ID: 8, phone: '+02012235548', name: 'mohamed is the killer'),
    UserModel(ID: 9, phone: '+02012235548', name: 'mansour is the killer'),
    UserModel(ID: 10, phone: '+02012235548', name: 'shaimaa is the killer'),
    UserModel(ID: 11, phone: '+02012235548', name: 'manar is the killer'),
  ];

  UsersScreens({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => BuildUserItem(dataModel[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Container(
                    width: double.infinity,
                    height: 2,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount: dataModel.length));
  }

  Widget BuildUserItem(UserModel data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            child: Text(
              '${data.ID}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                data.phone,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
  // 1 build item
  // 2 build list
  // 3 add item to list
}
