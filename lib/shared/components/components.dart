import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

NavigatorAndFinish({required context, required Widget}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Widget), (route) => false);
Navigato({required context, required Widget}) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

@override
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keybord,
  required Function validate,
  required IconData prefix,
  String lable = 'Email Addrees',
  IconData? suffix,
  Function? onSubmit,
  Function? suffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      obscureText: isPassword,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      controller: controller,
      keyboardType: keybord,
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        filled: true,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        labelText: lable,
        prefixIcon: Icon(
          prefix,
        ),
        border: OutlineInputBorder(),
      ),
    );

@override
Widget defaultButton({
  double width = double.infinity,
  double? height,
  required Color colors,
  required String text,
  required Function function,
}) =>
    Container(
      height: height,
      width: width,
      color: colors,
      child: MaterialButton(
        // color: defaultColor,
        onPressed: () {
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String lable,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(lable.toUpperCase()),
    );
