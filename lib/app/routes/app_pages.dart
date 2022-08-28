import 'package:get/get.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';

import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/contacts/bindings/contacts_binding.dart';
import '../modules/contacts/views/contacts_view.dart';
import '../modules/create_account/bindings/create_account_binding.dart';
import '../modules/create_account/views/create_account_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/phone_verification/bindings/phone_verification_binding.dart';
import '../modules/phone_verification/views/phone_verification_view.dart';
import '../modules/redirect/bindings/redirect_binding.dart';
import '../modules/redirect/views/redirect_view.dart';
import '../modules/walkthrough/bindings/walkthrough_binding.dart';
import '../modules/walkthrough/views/walkthrough_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.REDIRECT;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WALKTHROUGH,
      page: () => WalkthroughView(),
      binding: WalkthroughBinding(),
    ),
    GetPage(
      name: _Paths.PHONE_VERIFICATION,
      page: () => PhoneVerificationView(),
      binding: PhoneVerificationBinding(),
    ),
    GetPage(
      name: _Paths.REDIRECT,
      page: () => RedirectView(),
      binding: RedirectBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ACCOUNT,
      page: () => CreateAccountView(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTS,
      page: () => ContactsView(currentUser: UserModel()),
      binding: ContactsBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
  ];
}
