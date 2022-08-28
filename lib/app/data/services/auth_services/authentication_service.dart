import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/domain/repos/user/user_repo.dart';
import 'package:kgchat/app/utils/di_locator/di_locator.dart';

abstract class AuthenticationService {
  Future<UserModel> getCurrentUser();
  Future<dynamic> signInWithPhone(String phoneNumber);
  Future<bool?> signOut();
  Future<void> verifyPhoneNumber(String? phoneNumber);
}

class FirebaseAuthenticationService extends AuthenticationService {
  @override
  Future<UserModel> getCurrentUser() async {
    return await getIt<UserRepo>().getCurrentUser();
  }

  @override
  Future signInWithPhone(String phoneNumber) {
    // TODO: implement signInWithPhone
    throw UnimplementedError();
  }

  @override
  Future<bool?> signOut() async {
    return await getIt<UserRepo>().signOut();
  }

  @override
  Future<void> verifyPhoneNumber(String? phoneNumber) async {
    await getIt<UserRepo>().verifyPhoneNumber(
      phoneNumber: phoneNumber,
    );
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}

class AwsAuthenticationService extends AuthenticationService {
  @override
  Future<UserModel> getCurrentUser() async {
    return Future.delayed(Duration(seconds: 1), () {
      return UserModel(userID: '002', name: 'AWS');
    });
  }

  @override
  Future signInWithPhone(String phoneNumber) {
    // TODO: implement signInWithPhone
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> verifyPhoneNumber(String? phoneNumber) {
    // TODO: implement verifyPhoneNumber
    throw UnimplementedError();
  }
}
