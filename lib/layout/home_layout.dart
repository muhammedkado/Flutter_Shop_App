import 'package:flutter/material.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

class Home_Layout extends StatelessWidget {
  Home_Layout({Key? key}) : super(key: key);
  CachHelper? token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopApp'),
        actions: [
          IconButton(
              onPressed: () {
                NavigatorAndFinish(context: context, Widget: SearchScreen());
                ShowTost(msg: 'search screen', state: TostState.WARNING);
              },
              icon: Icon(Icons.search)),
        ],
      ),


    );
  }
}
