import 'package:flutter/material.dart';
import 'package:kgchat/app/app_constants/colors/app_colors.dart';

Container circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: CircularProgressIndicator(
      backgroundColor: AppColors.mainColor.withOpacity(0.5),
      valueColor: AlwaysStoppedAnimation(AppColors.mainColor.withOpacity(0.8)),
    ),
  );
}

Container linearProgress() {
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      backgroundColor: AppColors.mainColor.withOpacity(0.5),
      valueColor: AlwaysStoppedAnimation(AppColors.mainColor.withOpacity(0.8)),
    ),
  );
}
