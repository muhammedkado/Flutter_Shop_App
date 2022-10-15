import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';

class HomeCuibt extends Cubit<HomeState> {
  HomeCuibt() : super(HomeInitialState());

  static HomeCuibt get(context) => BlocProvider.of(context);

  int CarantIndex = 0;

  List<Widget> list = [
    ProductsScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];
void ChangeBottom(index)
{
 CarantIndex=index;
}

}
