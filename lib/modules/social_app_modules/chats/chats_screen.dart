import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/cubit/states.dart';
import 'package:flutter_application_1/modules/social_app_modules/chat_details/chat_details_screen.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var model = SocialCubit.get(context).users;

        return ConditionalBuilder(
          builder: (context) {
            return Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildChatItem(context, index);
                    },
                    separatorBuilder: (context, index) => myDivider(context),
                    itemCount: model.length),
                const SizedBox(
                  height: 30,
                ),
              ],
            );
          },
          // ignore: prefer_is_empty
          condition: model.length > 0,
          fallback: (BuildContext context) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 350,
              ),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Loading...',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildChatItem(context, index) {
    var model = SocialCubit.get(context).users;

    return Material(
      color: Colors.white,
      child: InkWell(
        splashColor: Colors.amber,
        highlightColor: Colors.amber,
        focusColor: Colors.amber,
        onTap: () {
          NavigateTo(
              context,
              ChatDetailsScreen(
                userModel: model[index],
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      CachedNetworkImageProvider(model[index].image!)),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          model[index].name!,
                          style: const TextStyle(
                              height: 2, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
