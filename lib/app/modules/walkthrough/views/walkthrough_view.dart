import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kgchat/app/app_constants/assets/app_assets.dart';
import 'package:kgchat/app/app_constants/text_styles/app_text_styles.dart';
import 'package:kgchat/app/app_constants/texts/app_texts.dart';
import 'package:kgchat/app/app_constants/widgets/app_constant_widgets.dart';
import 'package:kgchat/app/app_widgets/buttons/custom_button_widget.dart';
import 'package:kgchat/app/routes/app_pages.dart';

import '../controllers/walkthrough_controller.dart';

class WalkthroughView extends GetView<WalkthroughController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 42.0),
              child: AppAssets.walkthrough(height: 260.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Connect easily with your family and friends over countries',
                style: AppTextStyles.mulishBlack24w900,
                textAlign: TextAlign.center,
              ),
            ),
            AppConstantWidgets.heightOrWidthWidget(height: 20.0),
            Column(
              children: [
                Text(
                  AppTexts.termsAndPolicies,
                  style: AppTextStyles.mulishBlack14w600,
                ),
                AppConstantWidgets.heightOrWidthWidget(height: 10.0),
                CustomButtonWidget(
                  buttonText: 'Start Messaging',
                  buttonTextStyle: AppTextStyles.mulishWhite16w600,
                  buttonHor: Get.size.width * 0.25,
                  // MediaQuery.of(context).size.width * 0.25,
                  buttonVert: 15.0,
                  onTap: () {
                    Get.toNamed(Routes.PHONE_VERIFICATION);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
