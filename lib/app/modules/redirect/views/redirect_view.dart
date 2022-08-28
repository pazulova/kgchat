import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kgchat/app/app_widgets/progress/progress.dart';
import 'package:kgchat/app/modules/authentication/authentication.dart';
import 'package:kgchat/app/modules/create_account/views/create_account_view.dart';
import 'package:kgchat/app/modules/home/controllers/home_controller.dart';
import 'package:kgchat/app/modules/home/views/home_view.dart';
import 'package:kgchat/app/modules/phone_verification/views/phone_otp.dart';
import 'package:kgchat/app/modules/phone_verification/views/phone_verification_view.dart';

class RedirectView extends StatelessWidget {
  final AuthenticationController? _authCont =
      AuthenticationController.findAuthCont!;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_authCont!.state is LoadingState) {
          return Scaffold(
            body: Center(
              child: circularProgress(),
            ),
          );
        } else if (_authCont!.state is OtpVerificationState) {
          return PhoneOtp(
              code: (_authCont!.state as OtpVerificationState).phoneNumber);
        } else if (_authCont!.state is UnAuthenticatedState) {
          return const PhoneVerificationView();
        } else if (_authCont!.state is AuthenticatedUserState) {
          Get.lazyPut(() => HomeController());
          return HomeView();
        } else if (_authCont!.state is NewUserState) {
          return CreateAccountView(
            userCredential: (_authCont!.state as NewUserState).user,
            showBackButton: true,
          );
        }

        ///
        return const Scaffold(
          body: Center(
            child: Text('Something went wrong! Please try again!'),
          ),
        );
      },
    );
  }
}


/// final
/// const