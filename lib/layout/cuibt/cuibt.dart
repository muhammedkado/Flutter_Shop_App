import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/catagories/catagories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomeCuibt extends Cubit<HomeState> {
  HomeCuibt() : super(HomeInitialState());

  static HomeCuibt get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;

  List<Widget> BottomScreen = const [
    ProductsScreen(),
    FavoritesScreen(),
    CategorieScreen(),
    SettingScreen(),
  ];
  void ChangeBottom(index) {
    CurrentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(HomeLoadingState());

    DioHelper.getData(
      url: HOME,
      token: Token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
     // printFullText(homeModel!.data!.banners![0].image);


      emit(HomeSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(HomeErrorState(onError));
    });
  }
}
