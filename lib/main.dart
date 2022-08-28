import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kgchat/app/data/services/firestore/firestore_collections.dart';
import 'package:kgchat/app/modules/authentication/bloc/auth_bloc.dart';
import 'package:kgchat/app/modules/contacts/bloc/contacts_bloc.dart';
import 'package:kgchat/app/modules/home/bloc/home_bloc.dart';
import 'package:kgchat/app/modules/launcher/views/launcher_view.dart';
import 'package:kgchat/app/utils/di_locator/di_locator.dart' as di_locator;
// import 'package:get/get.dart';
import 'package:kgchat/app/utils/local_storage/local_storage.dart';
// import 'package:kgchat/app/modules/authentication/bindings/authentication_binding.dart';

// import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorage.initLocalStorage();
  di_locator.init();
  FirestoreCollections.getInstance();

  runApp(const MyApp());

  //GetX
  // runApp(
  //   GetMaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: "KG Chat",
  //     initialRoute: AppPages.INITIAL,
  //     getPages: AppPages.routes,
  //     initialBinding: AuthenticationBiding(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => ContactsBloc(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "KG Chat",
        home: LauncherView(),
      ),
    );
  }
}




///Design architecture
///UI - buisness logic - repo - services
///
/// data: 1. local 2. server