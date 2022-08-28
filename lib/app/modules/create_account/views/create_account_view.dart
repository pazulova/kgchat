import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kgchat/app/app_constants/colors/app_colors.dart';
import 'package:kgchat/app/app_constants/text_styles/app_text_styles.dart';
import 'package:kgchat/app/app_constants/widgets/app_constant_widgets.dart';
import 'package:kgchat/app/app_widgets/buttons/custom_button_widget.dart';
import 'package:kgchat/app/app_widgets/inputs/custom_text_form_field.dart';
import 'package:kgchat/app/app_widgets/progress/progress.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/modules/authentication/authentication.dart';
import 'package:kgchat/app/modules/create_account/widgets/circle_profile_widget.dart';

import '../controllers/create_account_controller.dart';

class CreateAccountView extends StatelessWidget {
  CreateAccountView({
    this.userCredential,
    this.showBackButton = false,
    Key? key,
  }) : super(key: key);
  final UserCredential? userCredential;
  final bool showBackButton;

  final TextEditingController _nameCont = TextEditingController();
  final TextEditingController _lastNameCont = TextEditingController();

  final AuthenticationController _authenticationController =
      AuthenticationController.findAuthCont!;

  final CreateAccountController _createAccountController =
      Get.put<CreateAccountController>(CreateAccountController());

  final _formKey = GlobalKey<FormState>();

  XFile? _file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: showBackButton
            ? IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: AppColors.black,
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            : AppConstantWidgets.emptyWidget,
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          'Create Account',
          style: AppTextStyles.mulishBlack18w600,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => _authenticationController.isCreatingUser.value ||
                _createAccountController.isLoadingImage.value
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    circularProgress(),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Obx(
                            () => CircleProfileWidget(
                              imageUrl: _createAccountController
                                  .profileImageUrl.value,
                              onTap: () async {
                                await _showBottomSheet(context);
                              },
                            ),
                          ),
                          CustomTextFormField(
                            controller: _nameCont,
                            hintText: 'First Name (Required)',
                          ),
                          const SizedBox(height: 18),
                          CustomTextFormField(
                            controller: _lastNameCont,
                            hintText: 'Last Name (Required)',
                          ),
                          const SizedBox(height: 54),
                          CustomButtonWidget(
                            buttonVert: 15,
                            buttonHor: MediaQuery.of(context).size.width * 0.4,
                            buttonText: 'Save',
                            buttonTextStyle: AppTextStyles.mulishWhite16w600,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_nameCont.text.isNotEmpty &&
                                    _lastNameCont.text.isNotEmpty &&
                                    _createAccountController
                                        .profileImageUrl.value.isNotEmpty) {
                                  await _authenticationController.createAccount(
                                    name: _nameCont.text,
                                    lastName: _lastNameCont.text,
                                    userId: userCredential!.user!.uid,
                                    imageUrl: _createAccountController
                                        .profileImageUrl.value,
                                    phone: userCredential!.user!.phoneNumber,
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: AppColors.mainColor.withOpacity(0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomButtonWidget(
                  buttonText: 'Choose from Gallery',
                  buttonTextStyle: AppTextStyles.mulishWhite16w600,
                  onTap: () async {
                    _file = await _createAccountController
                        .getImage(ImageSource.gallery);

                    log('_file >>> $_file');

                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),
                CustomButtonWidget(
                  buttonText: 'Choose from Camera',
                  buttonTextStyle: AppTextStyles.mulishWhite16w600,
                  onTap: () async {
                    _file = await _createAccountController
                        .getImage(ImageSource.camera);
                    log('_file >>> $_file');
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),
                CustomButtonWidget(
                  bgColor: Colors.transparent,
                  buttonText: 'Close',
                  buttonTextStyle: AppTextStyles.mulishBlack16w600,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
