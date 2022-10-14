import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLodingState());
    print('email:$email');
    print('password:$password');
    DioHelper.postData(
      url: 'login',
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print('email:$email');
      print('password:$password');
      emit(LoginSuccessState());
      print(value.data);
    }).catchError((onError) {
      print(onError.toString());

      emit(LoginErrorState(onError.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
 bool isPassword=true;
   ChangePasswordVisibility(){
     isPassword=!isPassword;
    suffix=isPassword ? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());

  }

}
