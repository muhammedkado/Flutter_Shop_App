import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/login_screen/cubit/state.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({Key? key}) : super(key: key);
  var emailControlar = TextEditingController();
  var passwordControlar = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 35),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            prefix:Icons.email_outlined ,
                              controller: emailControlar,
                              keybord: TextInputType.emailAddress,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Email Adrees is Empty';
                                }
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            prefix: Icons.lock_outline,
                            isPassword: LoginCubit.get(context).isPassword,
                            suffix: LoginCubit.get(context).suffix,
                            controller: passwordControlar,
                            keybord: TextInputType.visiblePassword,
                            onSubmit: (valuee) {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailControlar.text,
                                  password: passwordControlar.text,
                                );
                              }
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password is to short';
                              }
                            },
                            lable: 'Password',
                           suffixPressed: (){
                             LoginCubit.get(context).ChangePasswordVisibility();
                           }
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLodingState,
                            builder: (context) => defaultButton(
                              colors: defaultColor,
                              text: 'Login',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    email: emailControlar.text,
                                    password: passwordControlar.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Dons\'t Have Account?'),
                              defaultTextButton(
                                  function: () {
                                    print('object');
                                    Navigato(
                                        context: context,
                                        Widget: const RegisterScreen());
                                  },
                                  lable: 'Register ')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
