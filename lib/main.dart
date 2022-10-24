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
import 'dart:async';
import 'package:bloc/bloc.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
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
          create: (context) => HomeCuibt()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getUserData(),
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


class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- bloc: ${bloc.runtimeType}');
  }
}

void cubitMain() {
  print('----------CUBIT----------');

  /// Create a `CounterCubit` instance.
  final cubit = CounterCubit();

  /// Access the state of the `cubit` via `state`.
  print(cubit.state); // 0

  /// Interact with the `cubit` to trigger `state` changes.
  cubit.increment();

  /// Access the new `state`.
  print(cubit.state); // 1

  /// Close the `cubit` when it is no longer needed.
  cubit.close();
}

Future<void> blocMain() async {
  print('----------BLOC----------');

  /// Create a `CounterBloc` instance.
  final bloc = CounterBloc();

  /// Access the state of the `bloc` via `state`.
  print(bloc.state);

  /// Interact with the `bloc` to trigger `state` changes.
  bloc.add(CounterIncrementPressed());

  /// Wait for next iteration of the event-loop
  /// to ensure event has been processed.
  await Future<void>.delayed(Duration.zero);

  /// Access the new `state`.
  print(bloc.state);

  /// Close the `bloc` when it is no longer needed.
  await bloc.close();
}

/// A `CounterCubit` which manages an `int` as its state.
class CounterCubit extends Cubit<int> {
  /// The initial state of the `CounterCubit` is 0.
  CounterCubit() : super(0);

  /// When increment is called, the current state
  /// of the cubit is accessed via `state` and
  /// a new `state` is emitted via `emit`.
  void increment() => emit(state + 1);
}

/// The events which `CounterBloc` will react to.
abstract class CounterEvent {}

/// Notifies bloc to increment state.
class CounterIncrementPressed extends CounterEvent {}

/// A `CounterBloc` which handles converting `CounterEvent`s into `int`s.
class CounterBloc extends Bloc<CounterEvent, int> {
  /// The initial state of the `CounterBloc` is 0.
  CounterBloc() : super(0) {
    /// When a `CounterIncrementPressed` event is added,
    /// the current `state` of the bloc is accessed via the `state` property
    /// and a new state is emitted via `emit`.
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
  }
}
