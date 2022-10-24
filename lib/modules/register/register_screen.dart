import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var nameControlar = TextEditingController();
  var emailControlar = TextEditingController();
  var passwordControlar = TextEditingController();
  var phoneControlar = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.regesterModel.status == true) {
              CachHelper.saveData(
                key : 'token',
                value: state.regesterModel.data!.token,
              ).then((value) {

                Token = state.regesterModel.data!.token;
                print('Register : $Token');
                NavigatorAndFinish(
                  context: context,
                  Widget:const Home_Layout(),
                );
              });
              ShowTost(
                msg: "${state.regesterModel.message}",
                state: TostState.SUCCESS,
              );
            } else {
              ShowTost(
                msg: "${state.regesterModel.message}",
                state: TostState.ERROR,
              );
            }
          }
          },

        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 35),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Register now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              prefix: Icons.person,
                              controller: nameControlar,
                              keybord: TextInputType.text,
                              lable: 'User Name',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'user name is not be Empty';
                                }
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              prefix: Icons.email_outlined,
                              controller: emailControlar,
                              keybord: TextInputType.emailAddress,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Email Address is not be Empty';
                                }
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            prefix: Icons.lock_outline,
                            controller: passwordControlar,
                            keybord: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password is not be to short';
                              }
                            },
                            lable: 'Password',
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              prefix: Icons.phone,
                              controller: phoneControlar,
                              keybord: TextInputType.phone,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone is not be Empty';
                                }
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => defaultButton(
                              colors: defaultColor,
                              text: 'Register',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    email: emailControlar.text,
                                    password: passwordControlar.text,
                                    phone: phoneControlar.text,
                                    name: nameControlar.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ]),
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
