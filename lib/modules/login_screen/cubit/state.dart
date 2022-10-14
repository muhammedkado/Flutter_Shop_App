abstract class LoginState {}
class LoginInitialState extends LoginState{}
class LoginLodingState extends LoginState{}
class LoginSuccessState extends LoginState{}
class LoginErrorState extends LoginState{
  final String Error;

  LoginErrorState(this.Error);
}
class LoginChangePasswordVisibilityState extends LoginState{}
