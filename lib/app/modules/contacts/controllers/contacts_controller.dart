import 'package:get/get.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/domain/repos/contacts/contacts_repo.dart';
import 'package:kgchat/app/modules/authentication/authentication.dart';
import 'package:kgchat/app/utils/geolocation_utils/permissions_util.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsController extends GetxController {
  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  final AuthenticationController? _authenticationController =
      AuthenticationController.findAuthCont!;

  @override
  onInit() {
    super.onInit();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    isLoading.value = true;
    PermissionStatus _permissionStatus =
        await PermissionsUtil.getContactPermission();
    if (_permissionStatus == PermissionStatus.granted) {
      getContacts();
    } else {
      PermissionsUtil.handleInvalidPermissions(_permissionStatus);
      isLoading.value = false;
    }
  }

  Future<void> getContacts() async {
    users.value = await contactsRepo.getContactsAndUsersAndFilterUsers(
        _authenticationController!.getCurrentUser);
    isLoading.value = false;
    // update();
  }
}
