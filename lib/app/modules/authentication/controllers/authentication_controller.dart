import 'dart:developer';

import 'package:get/get.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/data/services/auth_services/authentication_service.dart';
import 'package:kgchat/app/data/services/firebase_auth/firebase_auth_services.dart';
import 'package:kgchat/app/domain/repos/user/user_repo.dart';

import '../authentication.dart';

class AuthenticationController extends GetxController {
  final AuthenticationService _authenticationService;
  AuthenticationController(this._authenticationService);

  static final AuthenticationController? findAuthCont =
   
    Get.find <AuthenticationController>();
    //  Get.lazyPut(() => AuthenticationController());
  final Rx<AuthenticationState> _authState = AuthenticationState().obs;

  final Rx<UserModel> _userModel = UserModel().obs;

  RxBool isCreatingUser = false.obs;

  RxString verificationId = ''.obs;

  AuthenticationState get state => _authState.value;

  UserModel get getCurrentUser => _userModel.value;

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }

  void _getAuthenticatedUser() async {
    _authState.value = LoadingState();

    final _user = await _authenticationService.getCurrentUser();
    log('_user.id ==>> ${_user.userID}');
    if (_user == UserModel()) {
      _authState.value = UnAuthenticatedState();
    } else {
      _authState.value = AuthenticatedUserState(_user);
      _userModel.value = _user;
    }
  }

  Future<void> verifyPhoneNumber({String? phoneNumber}) async {
    await firebaseAuthServices!.verifyPhoneNumber(
      phoneNumber: phoneNumber,
    );

    if (verificationId.value.isNotEmpty) {
      _authState.value = OtpVerificationState(phoneNumber!);
    }
  }

  Future<void> sendSmsCode({String? smsCode}) async {
    _authState.value = LoadingState();
    final _userCredential = await userRepo.sendSmsCode(smsCode: smsCode);

    final _isUserExists =
        await userRepo.checkUserExist(_userCredential!.user!.uid);

    /// !_isUserExists  ====> _isUserExists = false

    if (!_isUserExists!) {
      _authState.value = NewUserState(_userCredential);
    } else {
      final _user = await userRepo.getUser(_userCredential.user!.uid);

      _authState.value = AuthenticatedUserState(_user!);
      _userModel.value = _user;
    }
  }

  Future<void> createAccount({
    String? name,
    String? lastName,
    String? userId,
    String? imageUrl,
    String? phone,
  }) async {
    isCreatingUser.value = true;
    update();

    UserModel _user = UserModel(
      name: name,
      lastName: lastName,
      userID: userId,
      profilePhoto: imageUrl,
      phone: phone,
    );
    final _userM = await userRepo.createAccount(_user);
    isCreatingUser.value = false;
    update();

    _authState.value = AuthenticatedUserState(_userM!);
    _userModel.value = _userM;
  }

  Future<void> signOut() async {
    final _isSignedOut = await _authenticationService.signOut();

    if (_isSignedOut!) {
      _authState.value = UnAuthenticatedState();
      _userModel.value = UserModel();
    }
  }
}
