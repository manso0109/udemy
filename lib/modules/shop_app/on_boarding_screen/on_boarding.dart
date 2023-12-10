import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({required this.body, required this.image, required this.title});
}

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        body: 'On Board body 1',
        image: 'assets/images/onBoard_1.jpg',
        title: 'On Board Title 1'),
    BoardingModel(
        body: 'On Board body 2',
        image: 'assets/images/onBoard_2.jpg',
        title: 'On Board Title 2'),
    BoardingModel(
        body: 'On Board body 3',
        image: 'assets/images/onBoard_3.jpg',
        title: 'On Board Title 3')
  ];

  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'isLast', value: true).then((value) {
      if (value = true) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBoardingItem(BoardingModel model) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Image(
              image: AssetImage('${model.image}'),
              fit: BoxFit.cover,
            )),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${model.title}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${model.body}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            )
          ],
        );
    var boardController = PageController();
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(context,
                function: submit, text: 'SKIP', width: 40, height: 40)
          ],
          title: const Text('On Boarding Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      effect: const ExpandingDotsEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          expansionFactor: 4,
                          spacing: 5,
                          activeDotColor: Colors.amber,
                          dotColor: Colors.grey),
                      controller: boardController,
                      count: boarding.length),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastEaseInToSlowEaseOut);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
