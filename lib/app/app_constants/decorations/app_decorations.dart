import 'package:flutter/material.dart';
import 'package:kgchat/app/app_constants/colors/app_colors.dart';

class AppDecorations {
  static const messageContainerDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: AppColors.mainColor, width: 2.0),
    ),
  );

  static const messageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
  );
}
