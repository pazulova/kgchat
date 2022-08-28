import 'dart:developer';

import 'package:kgchat/app/data/local_data/users/local_user_service.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/data/services/firebase_auth/firebase_auth_services.dart';
import 'package:kgchat/app/data/services/firestore/firestore_services.dart';

class UserServices {
  Future<bool?>? checkUserExist(String? userID) async {
    return await firestoreServices.checkUserExists(userID);
  }

  Future<UserModel>? getUser(String userID) async {
    final _userModel = await firestoreServices.getUser(userID);
    await localUserService.addUserToCache(_userModel);

    return _userModel;
  }

  Future<UserModel> createAccount(UserModel user) async {
    try {
      final _isSaved = await firestoreServices.saveUserToFirestore(user);

      log('_isSaved ==>> $_isSaved');
      if (_isSaved) {
        await LocalUserService().addUserToCache(user);
      }

      return await getUser(user.userID!)!;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool?> signOut() async {
    await firebaseAuthServices?.signOut();

    return await localUserService.clearUserFromCache();
  }

  Future<List<UserModel>> getUsers() async {
    return await firestoreServices.getUsers();
  }
}

// final UserServices userServices = UserServices();
