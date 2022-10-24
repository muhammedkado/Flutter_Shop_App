import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cuibt/cuibt.dart';
import 'package:shop_app/layout/cuibt/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';


class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCuibt, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCuibt.get(context).userModel!;
        nameController.text = cubit.data!.name!;
        emailController.text = cubit.data!.email!;
        phoneController.text = cubit.data!.phone!;

        return BuildCondition(
          condition: HomeCuibt.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                   /* if (state is UpdateLoadingState)
                      const LinearProgressIndicator(),

                    */
                    const SizedBox(height: 15),
                    defaultFormField(
                      controller: nameController,
                      lable: "Name",
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Name must not be empty";
                        }
                      },
                      keybord: TextInputType.name,
                    ),
                    const SizedBox(height: 15),
                    defaultFormField(
                      controller: emailController,
                      lable: "Email Address",
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Email Address must not be empty";
                        }
                      },
                      keybord: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    defaultFormField(
                      controller: phoneController,
                     lable: 'phone',
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Phone must not be empty";
                        }
                      },

                      keybord: TextInputType.phone,
                    ),

                    const SizedBox(height: 20),
                    defaultButton(
                       colors:Colors.red,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          HomeCuibt.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: "UPDATE",
                    ),


                    const SizedBox(height: 15),
                    defaultButton(
                        function: () {
                          singOut(context);
                        },
                        text: "logout", colors: Colors.red),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}