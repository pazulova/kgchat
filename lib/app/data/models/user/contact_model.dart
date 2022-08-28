import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  final String? phone;
  final String? displayName;
  final String? familyName;
  final String? givenName;
  final String? avatar;
  final bool? isRegistered;

  ContactModel({
    this.phone,
    this.displayName,
    this.familyName,
    this.givenName,
    this.avatar,
    this.isRegistered,
  });

  @override
  List<Object?> get props => [
        phone,
        displayName,
        familyName,
        givenName,
        avatar,
        isRegistered,
      ];
}
