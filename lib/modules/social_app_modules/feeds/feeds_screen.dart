// ignore_for_file: sized_box_for_whitespace, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/cubit/states.dart';
import 'package:flutter_application_1/models/social_app/post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: SocialCubit.get(context).posts.length > 0 &&
                  SocialCubit.get(context).userModel != null,
              fallback: (context) {
                return const Column(
                  children: [
                    SizedBox(
                      height: 300,
                    ),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              },
              builder: (context) {
                return Column(
                  children: [
                    Card(
                      color: const Color.fromARGB(0, 255, 193, 7),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      margin: const EdgeInsets.all(8),
                      child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: const Center(
                                          child: CircularProgressIndicator()));
                                },
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                20),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  );
                                },
                                imageUrl:
                                    'https://img.freepik.com/free-photo/happy-arab-woman-hijab-portrait-smiling-girl-posing-red-studio-background-young-emotional-woman-human-emotions-facial-expression-concept-front-view_155003-22795.jpg?size=626&ext=jpg&ga=GA1.1.152173877.1700485886&semt=sph'),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Comunicate with friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                              ),
                            )
                          ]),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                        SocialCubit.get(context).posts[index],
                        context,
                        index,
                      ),
                      itemCount: SocialCubit.get(context).posts.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                );
              });
        });
  }
}

Widget buildPostItem(PostModel model, context, index) {
  var formKey = GlobalKey<FormState>();
  bool liked = true;

  var commentController = TextEditingController();
  return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(model.image!)),
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
                            model.name!,
                            style: const TextStyle(
                                height: 2, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 18,
                          )
                        ],
                      ),
                      Text(model.dateTime!,
                          style: const TextStyle(
                              height: 1, fontWeight: FontWeight.w200))
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {})
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              model.text!,
              style: const TextStyle(height: 1.15, fontSize: 13),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 4),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                            minWidth: 1.2,
                            height: 20,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: const Text(
                              '#software',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 4),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                            minWidth: 1.2,
                            height: 20,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: const Text(
                              '#flutter',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (model.postImage != '')
              Card(
                  color: const Color.fromARGB(0, 255, 193, 7),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) {
                        return Container(
                            height: 200,
                            width: double.infinity,
                            child: const Center(
                                child: CircularProgressIndicator()));
                      },
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(20),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        );
                      },
                      imageUrl: model.postImage!)),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    child: InkWell(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.thumb_up_off_alt_sharp,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 6),
                            child: SocialCubit.get(context)
                                        .posts[index]
                                        .likesList
                                        ?.length ==
                                    null
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Text(
                                    '${SocialCubit.get(context).posts[index].likesList?.length}',
                                  ),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.comment_rounded,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 6),
                            child: SocialCubit.get(context)
                                        .posts[index]
                                        .commentslist ==
                                    null
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Text(
                                    '${SocialCubit.get(context).posts[index].commentslist?.length}',
                                  ),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Form(
              key: formKey,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundImage: CachedNetworkImageProvider(
                                SocialCubit.get(context).userModel!.image!)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextFormField(
                          minLines: 1,
                          maxLines: 3,
                          controller: commentController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialCubit.get(context).commentPost(
                                        SocialCubit.get(context).postsId[index],
                                        commentController.text,
                                        index);
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_circle_right_rounded,
                                  color: Colors.blue,
                                ),
                              ),
                              fillColor: Colors.white,
                              hintText: 'write a comment ..',
                              hintStyle: const TextStyle(fontSize: 12)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please write something';
                            } else {
                              return null;
                            }
                          },
                        ))
                      ],
                    ),
                  ),
                  InkWell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          SocialCubit.get(context)
                                  .likes[index]
                                  .toString()
                                  .contains(
                                      '${SocialCubit.get(context).userModel?.uId}')
                              ? Icons.thumb_down
                              : Icons.thumb_up_off_alt_sharp,
                          color: SocialCubit.get(context)
                                  .likes[index]
                                  .toString()
                                  .contains(
                                      '${SocialCubit.get(context).userModel?.uId}')
                              ? Colors.red
                              : Colors.blue,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 6),
                          child: Text(
                            SocialCubit.get(context)
                                    .likes[index]
                                    .toString()
                                    .contains(
                                        '${SocialCubit.get(context).userModel?.uId}')
                                ? 'dislike'
                                : 'like',
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).likePost(
                          SocialCubit.get(context).postsId[index],
                          index,
                          liked);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}
