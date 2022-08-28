import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgchat/app/app_widgets/progress/progress.dart';
import 'package:kgchat/app/modules/authentication/bloc/auth_bloc.dart';
import 'package:kgchat/app/modules/create_account/views/create_account_view.dart';
import 'package:kgchat/app/modules/home/views/home_view.dart';
import 'package:kgchat/app/modules/phone_verification/views/phone_otp.dart';
import 'package:kgchat/app/modules/phone_verification/views/phone_verification_view.dart';

class LauncherView extends StatefulWidget {
  const LauncherView({Key? key}) : super(key: key);

  @override
  _LauncherViewState createState() => _LauncherViewState();
}

class _LauncherViewState extends State<LauncherView> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    _initAuth();
    super.initState();
  }

  void _initAuth() {
    _authBloc = context.read<AuthBloc>();

    _authBloc.add(GetCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _authBloc,
      builder: (context, state) {
        log('state ===> ${state.runtimeType}');
        if (state is AuthLoading) {
          return Scaffold(
            body: Center(
              child: circularProgress(),
            ),
          );
        }

        if (state is AuthLoadedWithNoUser) {
          return const PhoneVerificationView();
        }

        if (state is AuthLoadedWithUser) {
          return HomeView(currentUser: state.user);
        }

        if (state is AuthLoadedWithNewUser) {
          return CreateAccountView(
            userCredential: state.user,
            showBackButton: true,
          );
        }

        if (state is AuthOtpVerified) {
          return PhoneOtp(
            code: state.phoneNumber!,
          );
        }

        return const Scaffold(
          body: Center(
            child: Text('Something went wrong! Please try again!'),
          ),
        );
      },
    );
  }
}
