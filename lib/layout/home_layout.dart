import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/cuibt.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class Home_Layout extends StatelessWidget {
  Home_Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCuibt cuibt = HomeCuibt.get(context);
    return BlocConsumer<HomeCuibt, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ShopApp'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigatorto(context: context, Widget: const SearchScreen());
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cuibt.CurrentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'FAVORITE',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                label: 'CATEGORIES',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'SETTINGS',
              ),
            ],
            onTap: (index) {
              cuibt.ChangeBottom(index);
            },
          ),
          body: cuibt.BottomScreen[cuibt.CurrentIndex],
        );
      },
    );
  }
}
