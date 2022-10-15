import 'package:shop_app/models/login_model.dart';

abstract class LoginState {}
class LoginInitialState extends LoginState{}
class LoginLodingState extends LoginState{}
class LoginSuccessState extends LoginState{
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);

}
class LoginErrorState extends LoginState{
  final String Error;

  LoginErrorState(this.Error);
}
class LoginChangePasswordVisibilityState extends LoginState{}
