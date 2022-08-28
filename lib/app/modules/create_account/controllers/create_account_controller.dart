import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kgchat/app/domain/repos/user/user_repo.dart';

class CreateAccountController extends GetxController {
  RxString profileImageUrl = ''.obs;

  RxBool isLoadingImage = false.obs;

  Future<XFile> getImage(ImageSource _imageSource) async {
    isLoadingImage.value = true;
    update();
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? _image = await _picker.pickImage(source: _imageSource);

    log('_image ===> $_image');

    final _fileName = _image!.path.split('/').last;
    profileImageUrl.value = await uploadFile(_image.path, _fileName);

    isLoadingImage.value = false;
    update();
    return _image;
  }

  Future<String> uploadFile(String filePath, String fileName) async {
    return await userRepo.uploadFile(filePath, fileName);
  }
}
