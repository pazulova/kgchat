import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kgchat/app/modules/contacts/controllers/contacts_controller.dart';

class HomeController extends GetxController {
  Rx<PageController> pageController = PageController(
    initialPage: 0,
    keepPage: true,
  ).obs;

  @override
  onInit() {
    Get.lazyPut(() => ContactsController());
    super.onInit();
  }

  RxInt bottomSelectedIndex = 0.obs;

  void pageChanged(int index) {
    bottomSelectedIndex.value = index;
  }

  void bottomTapped(int index) {
    bottomSelectedIndex.value = index;
    pageController.value.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }
}
