import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';


class Home_Layout extends StatelessWidget {
   Home_Layout({Key? key}) : super(key: key);
  CachHelper? token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('ShopApp'),
        actions: [
          IconButton(onPressed: ()
          {
            CachHelper.removeData(key: 'token').then((value)
            {
            if(value)
              {
                NavigatorAndFinish(context: context, Widget: Login_Screen());
                ShowTost(msg: 'تم تسجيل الخروج بنجاح', state: TostState.SUCCESS);
              }
            }
            );
          }, icon: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
