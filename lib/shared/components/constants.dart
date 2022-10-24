import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

void singOut(context){

  CachHelper.removeData(key:'token').then((value)
  {
    NavigatorAndFinish(context: context, Widget: Login_Screen());
  }) ;
}

void printFullText(String text){

  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>
    print(match.group(0))
  );
}
String? Token='';