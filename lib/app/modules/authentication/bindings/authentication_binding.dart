import 'package:get/get.dart';
import 'package:kgchat/app/data/services/auth_services/authentication_service.dart';

import '../authentication.dart';

class AuthenticationBiding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthenticationController>(
      AuthenticationController(Get.put(FirebaseAuthenticationService())),
      permanent: true,
    );
    // Get.put<AuthenticationController>(
    //     AuthenticationController(Get.put(ServerAuthenticationService())),
    //     permanent: true);
  }
}
