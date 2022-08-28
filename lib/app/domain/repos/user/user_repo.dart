import 'package:firebase_auth/firebase_auth.dart';
import 'package:kgchat/app/data/local_data/users/local_user_service.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/data/services/firebase_auth/firebase_auth_services.dart';
import 'package:kgchat/app/data/services/firebase_storage/firebase_storage.dart';
import 'package:kgchat/app/data/services/user_services/user_services.dart';
import 'package:kgchat/app/utils/di_locator/di_locator.dart';

class UserRepo {
  final UserServices _userServices;
  UserRepo(this._userServices);
  Future<UserCredential?>? sendSmsCode({String? smsCode}) async {
    return await firebaseAuthServices!.validateOtp(smsCode!);
  }

  Future<bool?>? checkUserExist(String? userID) async {
    return await _userServices.checkUserExist(userID);
  }

  Future<UserModel>? createAccount(UserModel? userModel) async {
    return await _userServices.createAccount(userModel!);
  }

  Future<UserModel>? getUser(String? userID) async {
    return await _userServices.getUser(userID!)!;
  }

  Future<String> uploadFile(String filePath, String fileName) async {
    return await firebaseStorage.uploadFile(filePath, fileName);
  }

  Future<UserModel> getCurrentUser() async {
    final _userFromCache = localUserService.getUserFromCache();

    if (_userFromCache != null) {
      return _userFromCache;
    } else {
      final _user = await FirebaseAuthServices().getCurrentUser();
      if (_user == null) {
        return UserModel();
      } else {
        return await getUser(_user.uid)!;
      }
    }
  }

  Future<bool?> signOut() async {
    return await _userServices.signOut();
  }

  Future<List<UserModel>> getUsers() async {
    return await _userServices.getUsers();
  }

  Future<void> verifyPhoneNumber({String? phoneNumber}) async {
    await firebaseAuthServices!.verifyPhoneNumber(
      phoneNumber: phoneNumber,
    );
  }
}

final UserRepo userRepo = UserRepo(getIt<UserServices>());
