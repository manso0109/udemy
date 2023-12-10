import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/cubit/states.dart';
import 'package:flutter_application_1/models/social_app/message_model.dart';
import 'package:flutter_application_1/models/social_app/social_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel? userModel;

  const ChatDetailsScreen({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (context, states) {
          var messageController = TextEditingController();
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(userModel!.image!),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(userModel!.name!)
                ],
              ),
            ),
            body: ConditionalBuilder(
                // ignore: prefer_is_empty
                condition: SocialCubit.get(context).messages.length > 0,
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              // ignore: body_might_complete_normally_nullable
                              itemBuilder: (context, index) {
                                var message =
                                    SocialCubit.get(context).messages[index];
                                if (SocialCubit.get(context).userModel?.uId ==
                                    message.senderId) {
                                  return buildMyMessage(message);
                                } else {
                                  return buildMessage(message);
                                }
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 15,
                                  ),
                              itemCount:
                                  SocialCubit.get(context).messages.length),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black),
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 60,
                                  color: Colors.black,
                                  child: Center(
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      controller: messageController,
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: Colors.grey[500]),
                                          hintText:
                                              'Type your message here...'),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 60,
                                color: Colors.blue,
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        receiverId: userModel!.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                  },
                                  minWidth: 1,
                                  child: const Icon(
                                    Icons.send,
                                    size: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
        },
      );
    });
  }
}

Widget buildMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10))),
          child: Text(model.text!)),
    );

Widget buildMyMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10))),
          child: Text(model.text!)),
    );
