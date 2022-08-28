import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kgchat/app/app_constants/colors/app_colors.dart';
import 'package:kgchat/app/app_constants/text_styles/app_text_styles.dart';
import 'package:kgchat/app/app_constants/widgets/app_constant_widgets.dart';
import 'package:kgchat/app/modules/authentication/authentication.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class PhoneOtp extends StatefulWidget {
  const PhoneOtp({required this.code, Key? key}) : super(key: key);

  final String code;

  @override
  _PhoneOtpState createState() => _PhoneOtpState();
}

class _PhoneOtpState extends State<PhoneOtp> {
  final AuthenticationController _authenticationController =
      AuthenticationController.findAuthCont!;
  final TextEditingController controller = TextEditingController();

  String text = '';

  @override
  void initState() {
    super.initState();
  }

  void _onKeyboardTap(String value) async {
    setState(() {
      text = text + value;
    });

    if (text.length == 6) {
      await _authenticationController.sendSmsCode(smsCode: text);
    }
  }

  Widget otpNumberWidget(int position) {
    try {
      // log('otpNumberWidget.position: $position ');

      return Container(
        height: 40,
        width: 40,
        child: Center(
            child: Text(
          text[position],
          style: AppTextStyles.mulishBlack24w900,
        )),
      );
    } catch (e) {
      return Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: AppColors.greyDarker,
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: AppColors.black.withAlpha(20),
            ),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 16,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                'Enter Code',
                                style: AppTextStyles.mulishBlack24w900,
                              ),
                              Text(
                                'We have sent you an SMS with the code to ${widget.code}',
                                style: AppTextStyles.mulishBlack14w600,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          // _phoneContainer(),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                otpNumberWidget(0),
                                otpNumberWidget(1),
                                otpNumberWidget(2),
                                otpNumberWidget(3),
                                otpNumberWidget(4),
                                otpNumberWidget(5),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Resend Code',
                        style: AppTextStyles.mulishMainColor16w600,
                      ),
                    ),
                    AppConstantWidgets.heightOrWidthWidget(height: 24.0),
                    Container(
                      color: AppColors.grey,
                      child: NumericKeyboard(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        onKeyboardTap: _onKeyboardTap,
                        textColor: AppColors.black,
                        rightIcon: Icon(
                          Icons.backspace,
                          color: AppColors.black,
                        ),
                        rightButtonFn: () {
                          setState(() {
                            if (text.isNotEmpty) {
                              text = text.substring(0, text.length - 1);
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
