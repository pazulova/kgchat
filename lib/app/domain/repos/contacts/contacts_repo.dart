import 'package:contacts_service/contacts_service.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/domain/repos/user/user_repo.dart';

class ContactsRepo {
  Future<List<UserModel>> getContactsAndUsersAndFilterUsers(
      UserModel currentUser) async {
    List<UserModel> _usersFromContacts = <UserModel>[];

    final _contacts = await getContacts();

    for (final _contact in _contacts) {
      if (_contact.phones!.isNotEmpty) {
        final _userModel = UserModel(
          /// Remove whitespaces inside phone numbers
          /// Phone numbers from contacts may have spaces in phone text
          /// ex: 996 550 11 22 33
          /// replaceAll(RegExp(r"\s+"), "") is changing
          /// from 996 550 11 22 33 to 996550112233
          phone: _contact.phones!.first.value!.replaceAll(RegExp(r"\s+"), ""),
          name: _contact.displayName ??
              _contact.familyName ??
              _contact.givenName ??
              'N/A',
          lastName: _contact.familyName ?? 'N/A',
          createdAt: '',
          userID: '',
          profilePhoto: _contact.avatar.toString(),
          isRegistered: false,
        );

        _usersFromContacts.add(_userModel);
      }
    }

    final _usersFromServer = await getUsersFromServer();

    return getFilteredUsers(_usersFromServer, _usersFromContacts, currentUser);
  }

  Future<List<Contact>> getContacts() async {
    return await ContactsService.getContacts();
  }

  Future<List<UserModel>> getUsersFromServer() async {
    return await userRepo.getUsers();
  }

  List<UserModel> getFilteredUsers(
    List<UserModel> _usersFromServer,
    List<UserModel> _usersFromContacts,
    UserModel currentUser,
  ) {
    List<UserModel> _filteredUsers = <UserModel>[];

    for (final _userFromServer in _usersFromServer) {
      _filteredUsers = _usersFromContacts.where((_userFromContacts) {
        if (_userFromServer.phone == _userFromContacts.phone) {
          /// Getting registered users and changing their user values
          /// ex: isRegistered = true, or userID = _userFromServer.userID
          _userFromContacts.isRegistered = true;
          _userFromContacts.userID = _userFromServer.userID;
          _userFromContacts.profilePhoto = _userFromServer.profilePhoto;

          return true;
        } else {
          /// Show users even if they are not registered

          return true;
        }
      }).toList();
    }

    /// Sort: Show registered users first
    _filteredUsers.sort((a, b) {
      if (b.isRegistered == true) {
        return 1;
      } else {
        return -1;
      }
    });

    _filteredUsers.removeWhere((user) => user.userID == currentUser.userID);

    return _filteredUsers;
  }
}

final ContactsRepo contactsRepo = ContactsRepo();
