import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  late final String imge;
  late final String title;
  late final String body;
  OnBoardingModel(
      {required this.imge, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> list = [
    OnBoardingModel(
        imge: 'asset/image/onboarding_1.png',
        title: 'On boarding title 1',
        body:
            'The terms described in the above link have precedence over the terms described in the present document.'),
    OnBoardingModel(
        imge: 'asset/image/onboarding_2.png',
        title: 'On boarding title 2',
        body:
            'The terms described in the above link have precedence over the terms described in the present document.'),
    OnBoardingModel(
        imge: 'asset/image/onboarding_3.png',
        title: 'On boarding title 3',
        body:
            'The terms described in the above link have precedence over the terms described in the present document.'),
  ];

  bool isLast = false;

  PageController pageController = PageController();
void submit(){
  CachHelper.saveData(key: 'onBoarding', value: true).then((value)
  {
  if(value)
  {
    NavigatorAndFinish(
        Widget: Login_Screen(), context: context);
  }
  }
  );

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          defaultTextButton(function: ()
          {
            submit();
          },
            lable:'SKIP',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == list.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                itemBuilder: (context, indext) =>
                    buildOnBoardingItem(list[indext]),
                itemCount: list.length,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController, // PageController
                  count: list.length,
                  effect: const WormEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                  ), // your preferred effect
                  onDotClicked: (index) {},
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(OnBoardingModel list) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(list.imge),
            ),
          ),
          Text(
            list.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            list.body,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      );
}
