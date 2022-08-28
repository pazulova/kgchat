import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kgchat/app/app_widgets/dialogs/custom_dialog.dart';

import 'package:kgchat/app/modules/authentication/authentication.dart';

class FirebaseAuthServices {
  final _auth = FirebaseAuth.instance;

  String _verificationId = '';

  bool success = false;
  // final AuthenticationController _authenticationController =
  //     Get.find<AuthenticationController>();

  Future<User?> getCurrentUser() async {
    return await _auth.authStateChanges().first;
  }

  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    try {
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> verifyPhoneNumber({String? phoneNumber}) async {
    // await _auth.setLanguageCode('ru');

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber!,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        // await signInWithCredential(credential);
      },
      codeSent: (String? verificationId, int? resendToken) async {
        ///TODO: verificationId
        // _authenticationController.verificationId.value = verificationId!;

        _verificationId = verificationId!;

        Get.snackbar('Код отправлен',
            'Пожалуйста, проверьте свои сообщения, чтобы получить код',
            duration: Duration(seconds: 3));
      },
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
      verificationFailed: (FirebaseAuthException e) async {
        if (e.code == 'invalid-phone-number') {
          await CustomDialog().getDialog(
            title: "Ошибка!",
            content: "Предоставленный номер телефона недействителен.",
            isError: true,
          );
        } else if (e.code == 'too-many-requests') {
          await CustomDialog().getDialog(
            title: "Ошибка!",
            content:
                "Мы заблокировали из-за необычной активности. Попробуйте позже.",
            isError: true,
          );
        } else {
          await CustomDialog().getDialog(
            title: "Ошибка!",
            content: "Что-то пошло не так. Пожалуйста, попытайтесь еще раз",
            isError: true,
          );
        }

        // Handle other errors
      },
    );
  }

  Future<UserCredential> validateOtp(String smsCode) async {
    final AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);

    return await signInWithCredential(_authCredential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

late final FirebaseAuthServices? firebaseAuthServices = FirebaseAuthServices();
