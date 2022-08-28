import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kgchat/app/app_constants/colors/app_colors.dart';
import 'package:kgchat/app/app_constants/text_styles/app_text_styles.dart';
import 'package:kgchat/app/app_constants/texts/app_texts.dart';
import 'package:kgchat/app/app_constants/widgets/app_constant_widgets.dart';
import 'package:kgchat/app/app_widgets/buttons/custom_button_widget.dart';
import 'package:kgchat/app/data/models/global_models/country_with_flags.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/domain/repos/local_data/local_data_repo.dart';
import 'package:kgchat/app/modules/authentication/authentication.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class PhoneVerificationView extends StatefulWidget {
  const PhoneVerificationView();
  @override
  State<PhoneVerificationView> createState() => _PhoneVerificationViewState();
}

class _PhoneVerificationViewState extends State<PhoneVerificationView> {
  final AuthenticationController _authenticationController =
      AuthenticationController.findAuthCont!;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();

  String _usersPhoneNumber = '';

  List<DropdownMenuItem<CountryWithFlags>>? _dropdownMenuItems;

  CountryWithFlags? _selectedCountry;

  /// Strongly typed
  /// Data types
  /// dynamic
  /// var
  /// final
  /// const
  /// String, int, double, bool, UserModel, List<UserModel>, konkrettuu tipter

  final _name = true;
  dynamic _dynamic = 'string';

  _changeName() {
    log('_name before: $_name');
    // _name = false;
    _dynamic = false;
    log('_name after: $_name');

    _dynamic = 12312;

    _dynamic = UserModel();
  }

  @override
  void initState() {
    _changeName();
    _dropdownMenuItems = LocalDataRepo.buildDropDownMenuItems();
    _selectedCountry = _dropdownMenuItems![0].value;

    super.initState();
  }

  void _onKeyboardTap(String value) {
    /// if Kyrgyzstan's phone number
    if (_selectedCountry!.phoneCode!.length == 4) {
      if (_usersPhoneNumber.length < 9) {
        _usersPhoneNumber = _usersPhoneNumber + value;
      }
    }

    /// if Russia's phone number
    else if (_selectedCountry!.phoneCode!.length == 2) {
      if (_usersPhoneNumber.length < 10) {
        _usersPhoneNumber = _usersPhoneNumber + value;
      }
    }

    /// if Turkey's phone number
    else if (_selectedCountry!.phoneCode!.length == 3) {
      if (_usersPhoneNumber.length < 10) {
        _usersPhoneNumber = _usersPhoneNumber + value;
      }
    }

    setState(() {});
  }

  Widget _phoneContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 45,
          width: Get.size.width * 0.25,
          decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.1),
            // border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(2.0),
              child: DropdownButton<CountryWithFlags>(
                  underline: AppConstantWidgets.emptyWidget,
                  icon: AppConstantWidgets.emptyWidget,
                  value: _selectedCountry,
                  items: _dropdownMenuItems,
                  onChanged: (CountryWithFlags? value) {
                    setState(() {
                      _selectedCountry = value;
                    });
                  }),
            ),
          ),
        ),
        AppConstantWidgets.heightOrWidthWidget(width: 10.0),
        Container(
          height: 45,
          width: Get.size.width * 0.65,
          decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  (_usersPhoneNumber == '')
                      ? 'Phone number'
                      : _usersPhoneNumber,
                  style: AppTextStyles.mulishBlack14w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: AppColors.black.withAlpha(20),
            ),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 16,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: (Get.size.width * 0.05) - 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                'Enter Your Phone Number',
                                style: AppTextStyles.mulishBlack24w900,
                              ),
                              Text(
                                'Please confirm your country code and enter your phone number',
                                style: AppTextStyles.mulishBlack14w600,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          _phoneContainer(),
                        ],
                      ),
                    ),
                    CustomButtonWidget(
                      buttonHor: Get.size.width * 0.35,
                      buttonVert: 15,
                      buttonText: AppTexts.buttonContinueText,
                      buttonTextStyle: AppTextStyles.mulishWhite16w600,
                      onTap: () async {
                        String? _phoneNumber;

                        if (_usersPhoneNumber.isEmpty) {
                          Get.snackbar(
                              'Warning!', 'Please enter your phone number!');
                        } else if (_selectedCountry!.phoneCode == '+996' &&
                            _usersPhoneNumber.length == 9) {
                          _phoneNumber = _setCodeBeforeSending();
                          setState(() {});

                          await _authenticationController.verifyPhoneNumber(
                              phoneNumber: _phoneNumber);
                        } else if (_selectedCountry!.phoneCode == '+7' &&
                            _usersPhoneNumber.length == 10) {
                          _phoneNumber = _setCodeBeforeSending();
                          setState(() {});

                          await _authenticationController.verifyPhoneNumber(
                              phoneNumber: _phoneNumber);
                        } else if (_selectedCountry!.phoneCode == '+90' &&
                            _usersPhoneNumber.length == 10) {
                          _phoneNumber = _setCodeBeforeSending();
                          setState(() {});

                          await _authenticationController.verifyPhoneNumber(
                              phoneNumber: _phoneNumber);
                        } else {
                          Get.snackbar(
                              'Warning!', 'Please enter correct phone number!');
                        }

                        log('_code =====>> $_phoneNumber');
                      },
                    ),
                    AppConstantWidgets.heightOrWidthWidget(height: 24.0),
                  ],
                ),
              ),
            ),
            Container(
              color: AppColors.mainColor.withOpacity(0.1),
              child: NumericKeyboard(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                onKeyboardTap: _onKeyboardTap,
                textColor: AppColors.black,
                rightIcon: Icon(
                  Icons.backspace,
                  color: AppColors.black,
                ),
                rightButtonFn: () {
                  setState(() {
                    if (_usersPhoneNumber.isNotEmpty) {
                      _usersPhoneNumber = _usersPhoneNumber.substring(
                          0, _usersPhoneNumber.length - 1);
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String _setCodeBeforeSending() {
    return _selectedCountry!.phoneCode! + ' ' + _usersPhoneNumber;
  }
}
