import 'package:flutter/material.dart';
import 'package:kgchat/app/app_constants/text_styles/app_text_styles.dart';
import 'package:kgchat/app/data/models/global_models/country_with_flags.dart';

class CountriesWithFlagsLocalData {
  static final List<CountryWithFlags> _countriesList = <CountryWithFlags>[
    CountryWithFlags(
      flag: Container(
        height: 35,
        width: 35,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(30),
            child: Image.asset(
              'icons/flags/png/kg.png',
              package: 'country_icons',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      phoneCode: '+996',
    ),
    CountryWithFlags(
      flag: Container(
        height: 35,
        width: 35,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(30),
            child: Image.asset(
              'icons/flags/png/ru.png',
              package: 'country_icons',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      phoneCode: '+7',
    ),
    CountryWithFlags(
      flag: Container(
        height: 35,
        width: 35,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(30),
            child: Image.asset(
              'icons/flags/png/tr.png',
              package: 'country_icons',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      phoneCode: '+90',
    ),
  ];

  static List<DropdownMenuItem<CountryWithFlags>> buildDropDownMenuItems() {
    final _items = <DropdownMenuItem<CountryWithFlags>>[];

    for (final _country in _countriesList) {
      final _item = DropdownMenuItem<CountryWithFlags>(
        value: _country,
        child: Row(
          children: [
            _country.flag!,
            Text(
              _country.phoneCode!,
              style: AppTextStyles.mulishBlack14w600,
            ),
          ],
        ),
      );

      _items.add(_item);
    }
    return _items;
  }
}
