part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class AskPermissionEvent extends ContactsEvent {}

class GetContactsEvent extends ContactsEvent {
  final UserModel currentUser;

  GetContactsEvent(this.currentUser);
}
