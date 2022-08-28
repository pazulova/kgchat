import 'dart:convert';

import 'package:kgchat/app/app_constants/texts/app_texts.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/utils/local_storage/local_storage.dart';

class LocalUserService {
  Future<bool>? addUserToCache(UserModel userModel) async {
    final _userData = json.encode(userModel.toCacheJson());

    return await LocalStorage.setString(AppTexts.userToCacheKey, _userData)!;
  }

  UserModel? getUserFromCache() {
    final _user = LocalStorage.getString(AppTexts.userToCacheKey);
    if (_user == null) {
      return null;
    }
    return UserModel.fromCacheJson(json.decode(_user));
  }

  Future<bool?> clearUserFromCache() async {
    return await LocalStorage.remove(AppTexts.userToCacheKey);
  }
}

final LocalUserService localUserService = LocalUserService();
