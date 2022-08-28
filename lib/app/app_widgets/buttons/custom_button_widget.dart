import 'package:flutter/material.dart';
import 'package:kgchat/app/app_constants/colors/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String? buttonText;
  final TextStyle buttonTextStyle;
  final double? buttonVert;
  final double? buttonHor;
  final VoidCallback? onTap;
  final Color? bgColor;

  const CustomButtonWidget({
    required this.buttonText,
    required this.buttonTextStyle,
    required this.onTap,
    this.bgColor = AppColors.mainColor,
    this.buttonVert = 10.0,
    this.buttonHor = 40.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: buttonVert!, horizontal: buttonHor!),
          child: Text(
            buttonText!,
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
