import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsUtil {
  static final PermissionsUtil _singleton = PermissionsUtil._internal();

  factory PermissionsUtil() {
    return _singleton;
  }

  PermissionsUtil._internal();

  static Future<PermissionStatus> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      return await Permission.contacts.request();
    } else {
      return permission;
    }
  }

  static void handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      Get.snackbar('Warning', 'Access to contact data denied!');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Get.snackbar('Warning', 'Contact data not available on device!');
    }
  }
}
