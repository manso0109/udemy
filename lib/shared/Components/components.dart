// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, avoid_types_as_parameter_names, constant_identifier_names, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/models/shop_app/categories_list.dart';
import 'package:flutter_application_1/models/shop_app/list_model.dart';
import 'package:flutter_application_1/models/shop_app/list_search_model.dart';
import 'package:flutter_application_1/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:flutter_application_1/modules/web_view/web_view_screen.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_application_1/shared/Cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.amber,
  required VoidCallback function,
  required String text,
  bool isUpperCase = true,
  double borderRadius = 15,
}) =>
    Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      width: width,
      height: 40,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType inputType,
  required String hintText,
  required String labelText,
  Icon? prefix,
  IconData? suffix,
  bool isPassword = false,
  final String? Function(String?)? onSubmited,
  final String? Function(String?)? onchange,
  final VoidCallback? onTap,
  final VoidCallback? suffixPress,
  required final String? Function(String?)? validate,
  bool isCilcable = true,
  double radius = 20,
  var key,
}) =>
    BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, AppStates state) => TextFormField(
        style: TextStyle(
            color: AppCubit.get(context).isDark ? Colors.white : Colors.black),
        key: key,
        keyboardType: inputType,
        controller: controller,
        onFieldSubmitted: (value) => onSubmited,
        onChanged: onchange,
        obscureText: isPassword,
        onTap: onTap,
        enabled: isCilcable,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            prefixIcon: prefix,
            suffixIcon: suffix != null
                ? IconButton(
                    icon: Icon(suffix),
                    onPressed: suffixPress,
                  )
                : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)))),
        validator: validate,
      ),
      listener: (BuildContext context, AppStates state) {},
    );

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    background: Container(
      decoration: const BoxDecoration(color: Colors.cyan),
    ),
    key: Key('${model['id']}'),
    onDismissed: (DismissDirection direction) {
      AppCubit.get(context).deleteFromDatabase(ID: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${model['date']}',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateDataFromDatabase(status: 'done', ID: model['id']);
            },
            icon: const Icon(Icons.check_circle),
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateDataFromDatabase(status: 'archieved', ID: model['id']);
            },
            icon: const Icon(Icons.archive),
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}

Widget buildArticleItem(
  article,
  context,
) {
  dynamic url = article['urlToImage'];

  return BlocConsumer<AppCubit, AppStates>(
    builder: (BuildContext context, state) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          AppCubit.get(context).WebView(url: article['url']);
          NavigateTo(context, const WebViewScreen());
        },
        child: Row(
          children: [
            CachedNetworkImage(
              errorWidget: (context, url, error) => SizedBox(
                width: 120,
                height: 120,
                child: CachedNetworkImage(
                    imageUrl:
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'),
              ),
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black87,
                    borderRadius: BorderRadius.circular(10)),
                width: 120,
                height: 120,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Loading',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              imageUrl:
                  '${url == article[null] ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png' : url}',
              imageBuilder: (context, imageProvider) => Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
            )

            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Image.network(
            //     '${url == article[null] ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png' : url}',
            //     errorBuilder: (context, error, stackTrace) => Image.network(
            //         'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'),
            //   ),
            //   width: 120,
            //   height: 120,
            // ),
            ,
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text('${article['title']}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
    listener: (BuildContext context, Object? state) {},
  );
}

Widget myDivider(context) {
  return Container(
    color: Colors.grey[400],
    height: 1,
    width: double.infinity,
  );
}

Widget articleBuilder(list, context, items, {bool isSearch = false}) =>
    ConditionalBuilder(
        condition: list.length > 0,
        builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItem(list[index], context),
              separatorBuilder: (context, index) => myDivider(context),
              itemCount: list.length,
            ),
        fallback: (context) => isSearch
            ? Container(
                child: Text(
                  'type your search please',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            : const Center(child: CircularProgressIndicator()));

Widget defaultTextButton(context,
    {required VoidCallback function,
    required String text,
    required double width,
    required double height}) {
  return TextButton(
      onPressed: function,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.amber,
        ),
        width: width,
        height: height,
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  backgroundColor: Colors.amber,
                  color: Colors.black,
                ),
          ),
        ),
      ));
}

Widget defaultTextButtonPage(context, Color color, Color color2,
    {required VoidCallback function,
    required String text,
    required double width,
    required double height}) {
  return TextButton(
      onPressed: function,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        width: width,
        height: height,
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(backgroundColor: color, color: color2),
          ),
        ),
      ));
}

Future NavigateTo(context, widget) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

void ShowToastComponant(context,
        {required String msg, required ToastStates state}) =>
    showToast(msg,
        borderRadius: BorderRadius.circular(20),
        reverseAnimation: StyledToastAnimation.scale,
        backgroundColor: chooseToastColor(state),
        animation: StyledToastAnimation.fade,
        context: context,
        isHideKeyboard: true,
        fullWidth: true,
        position: StyledToastPosition.center);

enum ToastStates { SUCCESS, ERROR }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green.withOpacity(0.85);
      break;
    case ToastStates.ERROR:
      color = Colors.red.withOpacity(0.85);
      break;
  }
  return color;
}

Widget errorWidget(context) {
  return Center(
      child: Container(
    child: Text(
      'please pick another page because there is no products here :)',
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  ));
}

Widget noProductWidget(context, cubit) {
  return SingleChildScrollView(
    controller: cubit.listScrollController,
    child: Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 250, horizontal: 30),
        child: Text(
          'No Products available please pick another page',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      )),
    ),
  );
}

Widget productWidget(
  ListModel? model,
  context,
  cubit,
) {
  return model?.data?.length == null
      ? Column(
          children: [
            const SizedBox(
                height: 550,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                )),
            defaultTextButton(context, function: () {
              cubit.productData = null;
              cubit.pagedData = null;
              cubit.GetHomeData(token);
              cubit.GetproductDat2a();
              cubit.GetproductData();
            }, text: 'Refresh', width: 120, height: 30),
          ],
        )
      : SingleChildScrollView(
          controller: cubit.listScrollController,
          child: Column(children: [
            Row(
              children: [
                // text container
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black),
                    child: Center(
                      child: Text(
                        '${model?.data?[0].title}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.apply(
                            color: AppCubit.get(context).isDark
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  ),
                ),
                // carousel slider
                Expanded(
                  flex: 3,
                  child: CarouselSlider(
                    items: model?.data?[0].images
                        ?.map((e) => Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CachedNetworkImage(
                                  errorWidget: (context, url, error) {
                                    return SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'),
                                    );
                                  },
                                  width: 235.6363,
                                  imageUrl:
                                      '${e ?? Text('No image availabe', style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center)}',
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ))
                        .toList(),
                    options: CarouselOptions(
                        initialPage: 0,
                        height: 250,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        reverse: false,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
              child: GridView.count(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1 / 1.6,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                    model!.data!.length,
                    (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        singleAllProducts(context, index)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    height: 140,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                          '${model.data?[index].category?.image}',
                                        ))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    '${model.data?[index].title}',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppCubit.get(context).isDark
                                                ? Colors.black
                                                : Colors.white),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Price:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                              color:
                                                  AppCubit.get(context).isDark
                                                      ? Colors.black
                                                      : Colors.white),
                                    ),
                                    const SizedBox(width: 5),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.5),
                                      child: Text(
                                        '${model.data?[index].price?.round()} \$',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? Colors.black
                                                        : Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
              ),
            ),
            // pages
            const SizedBox(
              height: 20,
            ),

            const SizedBox(
              height: 10,
            )
          ]),
        );
}

Widget SearchproductWidget(
  ListSearchModel? model,
  context,
  cubit,
) {
  return model?.data?.length == null
      ? Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Text('please enter your search',
                style: Theme.of(context).textTheme.bodyLarge)
          ],
        )
      : SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
              child: GridView.count(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1 / 1.6,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                    model!.data!.length,
                    (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        singleAllSearchProducts(
                                            context, index, model)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    height: 140,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                          '${model.data?[index].category?.image}',
                                        ))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    '${model.data?[index].title}',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppCubit.get(context).isDark
                                                ? Colors.black
                                                : Colors.white),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Price:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                              color:
                                                  AppCubit.get(context).isDark
                                                      ? Colors.black
                                                      : Colors.white),
                                    ),
                                    const SizedBox(width: 5),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.5),
                                      child: Text(
                                        '${model.data?[index].price?.round()} \$',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? Colors.black
                                                        : Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
              ),
            ),
            // pages
            const SizedBox(
              height: 20,
            ),

            const SizedBox(
              height: 10,
            )
          ]),
        );
}

Widget singleAllProducts(context, index) {
  return Scaffold(
    appBar: AppBar(
      title: Center(
          child: Text(
              '${ShopCubit.get(context).pagedData?.data?[index].id} ${ShopCubit.get(context).pagedData?.data?[index].title}')),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child: Text(
              '${ShopCubit.get(context).pagedData?.data?[index].id} :  ${ShopCubit.get(context).pagedData?.data?[index].title} ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(30),
                    bottomEnd: Radius.circular(30)),
                color:
                    AppCubit.get(context).isDark ? Colors.white : Colors.black,
              ),
              height: 50,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                    'Category :  ${ShopCubit.get(context).pagedData?.data?[index].category?.name}',
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: AppCubit.get(context).isDark
                              ? Colors.black
                              : Colors.white,
                        )),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                  width: 230,
                  child: CarouselSlider(
                    items: ShopCubit.get(context)
                        .pagedData
                        ?.data?[index]
                        .images!
                        .map((e) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  child: CachedNetworkImage(
                                    imageBuilder: (context, e) {
                                      return Container(
                                        width: 200.0,
                                        height: 200.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: e, fit: BoxFit.cover),
                                        ),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'),
                                      );
                                    },
                                    width: 200,
                                    imageUrl: '$e',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                    options: CarouselOptions(
                        initialPage: 0,
                        height: 230,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        reverse: false,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${ShopCubit.get(context).pagedData?.data?[index].price} \$',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${ShopCubit.get(context).pagedData?.data?[index].description}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: IconButton(
                    onPressed: () {
                      ShopCubit.get(context).deleteData(
                          ID: ShopCubit.get(context)
                              .pagedData
                              ?.data?[index]
                              .id);
                      ShopCubit.get(context).productData = null;
                      ShopCubit.get(context).pagedData = null;
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.remove_circle_outlined,
                      size: 70,
                      color: Colors.amber,
                    )),
              ),
            ],
          ),
        ]),
      ),
    ),
  );
}

Widget singleAllSearchProducts(context, index, ListSearchModel? model) {
  return Scaffold(
    appBar: AppBar(
      title: Center(
          child:
              Text('${model?.data?[index].id} ${model?.data?[index].title}')),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child: Text(
              '${model?.data?[index].id} :  ${model?.data?[index].title} ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(30),
                    bottomEnd: Radius.circular(30)),
                color:
                    AppCubit.get(context).isDark ? Colors.white : Colors.black,
              ),
              height: 50,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text('Category :  ${model?.data?[index].category?.name}',
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: AppCubit.get(context).isDark
                              ? Colors.black
                              : Colors.white,
                        )),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                  width: 230,
                  child: CarouselSlider(
                    items: ShopCubit.get(context)
                        .pagedData
                        ?.data?[index]
                        .images!
                        .map((e) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  child: CachedNetworkImage(
                                    imageBuilder: (context, e) {
                                      return Container(
                                        width: 200.0,
                                        height: 200.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: e, fit: BoxFit.cover),
                                        ),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'),
                                      );
                                    },
                                    width: 200,
                                    imageUrl: '$e',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                    options: CarouselOptions(
                        initialPage: 0,
                        height: 230,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        reverse: false,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${model?.data?[index].price} \$',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${model?.data?[index].description}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: IconButton(
                    onPressed: () {
                      SearchCubit.get(context).deleteData(
                          ID: ShopCubit.get(context)
                              .pagedData
                              ?.data?[index]
                              .id);
                      ShopCubit.get(context).productData = null;
                      ShopCubit.get(context).pagedData = null;
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.remove_circle_outlined,
                      size: 70,
                      color: Colors.amber,
                    )),
              ),
            ],
          ),
        ]),
      ),
    ),
  );
}

Widget builderWidget(Widget? widget) {
  return widget!;
}

Widget CategoryBuilderWidget(CategoryListModel? model, index, context, cubit) {
  return SingleChildScrollView(
    controller: cubit.listScrollController,
    child: ConditionalBuilder(
      condition: model?.catData?.length != null,
      builder: (BuildContext context) => Column(children: [
        Row(
          children: [
            // text container
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black),
                child: Center(
                  child: Text(
                    'Categories',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: AppCubit.get(context).isDark
                            ? Colors.black
                            : Colors.white),
                  ),
                ),
              ),
            ),
            // carousel slider
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
          child: GridView.count(
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1 / 1.6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(
                model!.catData!.length,
                (index) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CachedNetworkImage(
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: imageProvider)),
                                        width: 140,
                                        height: 140,
                                      ),
                                  errorWidget: (context, url, error) {
                                    return CachedNetworkImage(
                                        imageBuilder: (context,
                                                imageProvider) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: imageProvider)),
                                              width: 140,
                                              height: 140,
                                            ),
                                        imageUrl:
                                            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png');
                                  },
                                  imageUrl: '${model.catData?[index].image}')),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '${model.catData?[index].name}',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppCubit.get(context).isDark
                                          ? Colors.black
                                          : Colors.white),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'ID : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                        color: AppCubit.get(context).isDark
                                            ? Colors.black
                                            : Colors.white),
                              ),
                              const SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.5),
                                child: Text(
                                  '${model.catData?[index].id}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: AppCubit.get(context).isDark
                                              ? Colors.black
                                              : Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
          ),
        ),
        // pages
        const SizedBox(
          height: 20,
        ),

        const SizedBox(
          height: 10,
        )
      ]),
      fallback: (BuildContext context) => const SizedBox(
          height: 550,
          width: double.infinity,
          child: Center(child: CircularProgressIndicator())),
    ),
  );
}

int inat = 0;
AutoScrollController pagesController = AutoScrollController();
Widget pageSelectorBuilder(context, cubit) {
  return Column(
    children: [
      Text(
        'Pages',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(
        height: 10,
      ),
      ConditionalBuilder(
        condition: cubit.pageList != null,
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              controller: pagesController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                // ignore: unnecessary_null_comparison
                Color color = inat != null && inat == i
                    ? AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black
                    : Colors.amber;
                // ignore: unnecessary_null_comparison
                Color color2 = inat != null && inat == i
                    ? AppCubit.get(context).isDark
                        ? Colors.black
                        : Colors.white
                    : Colors.black;
                return AutoScrollTag(
                    key: ValueKey(i),
                    index: i,
                    controller: pagesController,
                    builder: (context, highlight) => defaultTextButtonPage(
                          text: '${cubit.pageList?[i]}',
                          width: 40,
                          height: 40,
                          context,
                          color,
                          color2,
                          function: () {
                            cubit.productData = null;
                            cubit.pagedData = null;
                            cubit.GetproductDat2a();
                            cubit.scrollToTop();
                            pagesController.scrollToIndex(i,
                                preferPosition: AutoScrollPosition.middle);
                            cubit.changePage(
                              inat = i,
                            );
                            cubit.GetproductData();
                          },
                        ));
              },
              itemCount: cubit.pageList?.length,
            ),
          ),
        ),
        fallback: (BuildContext context) => const CircularProgressIndicator(),
      ),
    ],
  );
}

PreferredSizeWidget defaultAppBar(
        {required BuildContext context,
        String? title,
        List<Widget>? actions}) =>
    AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left_rounded)),
      title: Text('$title'),
      actions: actions,
    );
