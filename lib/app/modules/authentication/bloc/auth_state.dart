part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class AuthLoadedWithNoUser extends AuthState {}

class AuthLoadedWithUser extends AuthState {
  final UserModel? user;

  AuthLoadedWithUser(this.user);

  @override
  List<Object> get props => [user!];
}

class AuthLoadedWithNewUser extends AuthState {
  final UserCredential? user;

  AuthLoadedWithNewUser(this.user);

  @override
  List<Object> get props => [user!];
}

class AuthOtpVerified extends AuthState {
  final String? phoneNumber;

  AuthOtpVerified(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber!];
}

class AuthNoLocation extends AuthState {}

class AuthLoadedWithError extends AuthState {}
