part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentUserEvent extends AuthEvent {}

class VerifyPhoneEvent extends AuthEvent {
  final String? phoneNumber;

  VerifyPhoneEvent(this.phoneNumber);
}

class VerifySmsCodeEvent extends AuthEvent {
  final String? smsCode;

  VerifySmsCodeEvent(this.smsCode);
}

// When the user signing in with phone number this event is called and the [AuthRepository] is called to sign in the user
class SignInEvent extends AuthEvent {
  final String? phoneNumber;

  SignInEvent(this.phoneNumber);
}

// When the user signing up with email and password this event is called and the [AuthRepository] is called to sign up the user
class CreateAccountEvent extends AuthEvent {
  final UserCredential? userCredential;

  CreateAccountEvent(this.userCredential);
}
