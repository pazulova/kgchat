import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/data/services/auth_services/authentication_service.dart';

class AuthenticationRepository implements AuthenticationService {
  // AuthenticationRepository(AuthenticationService authenticationService)
  //     : _authenticationService = authenticationService;

  AuthenticationRepository(this._authenticationService);

  final AuthenticationService _authenticationService;

  @override
  Future<UserModel> getCurrentUser() {
    return _authenticationService.getCurrentUser();
  }

  @override
  Future signInWithPhone(String phoneNumber) {
    return _authenticationService.signInWithPhone(phoneNumber);
  }

  @override
  Future<bool?> signOut() {
    return _authenticationService.signOut();
  }

  @override
  Future<void> verifyPhoneNumber(String? phoneNumber) {
    return _authenticationService.verifyPhoneNumber(phoneNumber);
  }
}
