import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/social_app/cubit/states.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (contex, state) {
          var textController = TextEditingController();
          var nowTime = DateTime.now();
          var formKey = GlobalKey<FormState>();
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: defaultAppBar(
                  context: context,
                  title: 'Create Post',
                  actions: [
                    defaultTextButton(context, function: () {
                      if (formKey.currentState!.validate()) {
                        if (SocialCubit.get(context).postImage == null) {
                          SocialCubit.get(context).createPost(
                              dateTime: nowTime.toString(),
                              text: textController.text);
                        } else if (SocialCubit.get(context).postImage != null) {
                          SocialCubit.get(context).uploadNewPostImage(
                              dateTime: nowTime.toString(),
                              text: textController.text);
                        }
                      }
                    }, text: 'Post', width: 100, height: 40)
                  ]),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  state is SocialCreatePostLoadingState
                      ? const LinearProgressIndicator(
                          minHeight: 3,
                        )
                      : Container(
                          height: 3,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        foregroundImage: NetworkImage(
                            SocialCubit.get(context).userModel!.image!),
                      ),
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
                                  SocialCubit.get(context).userModel!.name!,
                                  style: const TextStyle(
                                      height: 2,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: 10,
                      minLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please write something first';
                        }
                        return null;
                      },
                      controller: textController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          hintText: 'what is on your mind',
                          fillColor: Colors.white),
                    ),
                  ),
                  if (SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        postImageWidget(SocialCubit.get(context).postImage,
                            SocialCubit.get(context).userModel),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: IconButton(
                              onPressed: () {
                                SocialCubit.get(context).removePostImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                ),
                              )),
                        )
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              SocialCubit.get(context).getPostImage();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.photo_size_select_actual),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Add Photo')
                              ],
                            )),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Tags',
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          );
        });
  }
}

Widget postImageWidget(postImage, userModel) {
  return Card(
    color: const Color.fromARGB(0, 255, 193, 7),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: const EdgeInsets.all(8),
    child: CachedNetworkImage(
        errorWidget: (context, url, error) {
          return Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Center(
              child: Text(
                'No image available',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
          );
        },
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                image: DecorationImage(
                    image: FileImage(postImage), fit: BoxFit.cover)),
          );
        },
        imageUrl: userModel!.cover!),
  );
}
