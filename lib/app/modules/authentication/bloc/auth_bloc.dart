import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/domain/repos/auth_repo/auth_repo.dart';
import 'package:kgchat/app/domain/repos/user/user_repo.dart';
import 'package:kgchat/app/utils/di_locator/di_locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authRepo;
  final UserRepo _userRepo;
  AuthBloc()
      : _userRepo = getIt<UserRepo>(),
        _authRepo = getIt<AuthenticationRepository>(),
        super(AuthLoading()) {
    on<GetCurrentUserEvent>(_getCurrentUser);
    on<VerifyPhoneEvent>(_verifyPhone);
    on<VerifySmsCodeEvent>(_verifySmsCode);
  }

  ///Memory leak
  ///OOP

  void _getCurrentUser(
      GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final _user = await _authRepo.getCurrentUser();
    // await Future.delayed(Duration(seconds: 2));
    if (_user == UserModel()) {
      emit(AuthLoadedWithNoUser());
    } else {
      emit(AuthLoadedWithUser(_user));
    }
  }

  void _verifyPhone(VerifyPhoneEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await _authRepo.verifyPhoneNumber(event.phoneNumber);

    emit(AuthOtpVerified(event.phoneNumber));
  }

  void _verifySmsCode(VerifySmsCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final _userCredential = await _userRepo.sendSmsCode(smsCode: event.smsCode);

    final _isUserExists =
        await _userRepo.checkUserExist(_userCredential!.user!.uid);

    if (!_isUserExists!) {
      emit(AuthLoadedWithNewUser(_userCredential));
    } else {
      final _user = await _userRepo.getUser(_userCredential.user!.uid);

      emit(AuthLoadedWithUser(_user));
    }
  }
}
