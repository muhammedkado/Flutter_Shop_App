import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/cuibt.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/thememod.dart';
import 'package:shop_app/shared/components/constants.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  Widget? Start;
  bool? onBoarding = CachHelper.getData(key: 'onBoarding');
   Token = CachHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (Token != null) {
      Start = Home_Layout();
    } else {
      Start = Login_Screen();
    }
  } else {
    Start = OnBoardingScreen();
  }
  runApp(MyApp(Start));
}

class MyApp extends StatelessWidget {
  final Widget Start;
  MyApp(this.Start);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCuibt()..getHomeData(),
        ),
      ],
      child: BlocConsumer<HomeCuibt, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: LightTheme,
            darkTheme: DarkTheme,
            home: Start,
          );
        },
      ),
    );
  }
}
