import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/domain/repos/contacts/contacts_repo.dart';
import 'package:kgchat/app/utils/di_locator/di_locator.dart';
import 'package:kgchat/app/utils/geolocation_utils/permissions_util.dart';
import 'package:permission_handler/permission_handler.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactsRepo _contactsRepo;
  ContactsBloc()
      : _contactsRepo = getIt<ContactsRepo>(),
        super(ContactsLoading()) {
    on<AskPermissionEvent>(_askPermission);
    on<GetContactsEvent>(_getContacts);
  }

  void _askPermission(
    AskPermissionEvent event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());

    PermissionStatus _permissionStatus =
        await PermissionsUtil.getContactPermission();
    if (_permissionStatus == PermissionStatus.granted) {
      emit(ContactsPermissionGranted());
    } else {
      emit(ContactsPermissionDenied(_permissionStatus));
    }
  }

  void _getContacts(
    GetContactsEvent event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    final _users = await _contactsRepo
        .getContactsAndUsersAndFilterUsers(event.currentUser);

    emit(ContactsLoaded(_users));
  }
}
