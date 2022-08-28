import 'package:get_it/get_it.dart';
import 'package:kgchat/app/data/services/auth_services/authentication_service.dart';
import 'package:kgchat/app/data/services/user_services/user_services.dart';
import 'package:kgchat/app/domain/repos/auth_repo/auth_repo.dart';
import 'package:kgchat/app/domain/repos/chats/chat_repo.dart';
import 'package:kgchat/app/domain/repos/contacts/contacts_repo.dart';
import 'package:kgchat/app/domain/repos/user/user_repo.dart';

final getIt = GetIt.instance;

void init() {
  _initServices();
  _initRepositories();
}

void _initServices() {
  getIt.registerSingleton<FirebaseAuthenticationService>(
      FirebaseAuthenticationService());

  getIt.registerSingleton<UserServices>(UserServices());
}

void _initRepositories() {
  getIt.registerSingleton<AuthenticationRepository>(
      AuthenticationRepository(getIt<FirebaseAuthenticationService>()));

  getIt.registerSingleton<UserRepo>(UserRepo(getIt<UserServices>()));
  getIt.registerSingleton<ContactsRepo>(ContactsRepo());
  getIt.registerSingleton<ChatRepo>(ChatRepo());
}
