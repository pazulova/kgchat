import 'package:flutter/material.dart';
import 'package:kgchat/app/app_constants/text_styles/app_text_styles.dart';

class KeyPad extends StatelessWidget {
  double buttonSize = 60.0;
  final TextEditingController? pinController;
  final Function? onChange;
  final Function? onSubmit;

  final Function(String)? onTapped;

  KeyPad({
    required this.onTapped,
    this.onChange,
    this.onSubmit,
    this.pinController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE6E6E6),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('1'),
              buttonWidget('2'),
              buttonWidget('3'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('4'),
              buttonWidget('5'),
              buttonWidget('6'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('7'),
              buttonWidget('8'),
              buttonWidget('9'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: buttonSize,
              ),
              buttonWidget('0'),
              iconButtonWidget(Icons.backspace, () {
                if (pinController!.text.length > 0) {
                  pinController!.text = pinController!.text
                      .substring(0, pinController!.text.length - 1);
                }
                if (pinController!.text.length > 5) {
                  pinController!.text = pinController!.text.substring(0, 3);
                }
                onChange!(pinController!.text);
              }),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  buttonWidget(String buttonText) {
    return Container(
      height: buttonSize,
      width: buttonSize,
      child: TextButton(
        onPressed: () {
          onTapped!(buttonText);
        },
        child: Center(
          child: Text(
            buttonText,
            style: AppTextStyles.mulishBlack24w900,
          ),
        ),
      ),
    );
  }

  iconButtonWidget(IconData icon, Function() function) {
    return InkWell(
      onTap: function,
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration:
            BoxDecoration(color: Colors.orangeAccent, shape: BoxShape.circle),
        child: Center(
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
