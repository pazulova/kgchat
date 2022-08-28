part of 'contacts_bloc.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsLoading extends ContactsState {}

class ContactsPermissionGranted extends ContactsState {}

class ContactsPermissionDenied extends ContactsState {
  final PermissionStatus? permissionStatus;

  ContactsPermissionDenied(this.permissionStatus);

  @override
  List<Object> get props => [permissionStatus!];
}

class ContactsLoaded extends ContactsState {
  late final List<UserModel>? users;
  ContactsLoaded(this.users);

  @override
  List<Object> get props => [users!];
}
