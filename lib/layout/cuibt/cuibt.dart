import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/changefavorites.dart';
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
    CategorieScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];
  void ChangeBottom(index) {
    CurrentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorits = {};
  void getHomeData() async {
    emit(HomeLoadingState());

    await DioHelper.getData(
      url: HOME,
      token: Token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // printFullText(homeModel!.data!.banners![0].image);

      homeModel!.data!.products.forEach((element) {
        favorits.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print(favorits.toString());

      emit(HomeSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(HomeErrorState(onError));
    });
  }

  CategoriesModel? categoriesModel;
  DataModel? dataModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      //  print(dataModel?.image);

      emit(CategoriesSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(CategoriesErrorState(onError));
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int? productID) {
    DioHelper.postData(
      url: FAVORITES,
      token: Token,
      data: {'product_id': productID},
    ).then((value) {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      emit(FavoritesSuccessState());

    }).catchError((onError) {
      emit(
        FavoritesErrorState(
          onError.toString(),
        ),
      );
    });
  }
}
