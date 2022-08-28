import 'package:flutter/material.dart';

class AppConstantWidgets {
  static const Widget emptyWidget = SizedBox();
  static Widget heightOrWidthWidget({double? height, double? width}) =>
      SizedBox(height: height, width: width);
}
