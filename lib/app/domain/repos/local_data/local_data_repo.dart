import 'package:flutter/material.dart';
import 'package:kgchat/app/data/local_data/countries_with_flags_data.dart';
import 'package:kgchat/app/data/models/global_models/country_with_flags.dart';

class LocalDataRepo {
  static List<DropdownMenuItem<CountryWithFlags>> buildDropDownMenuItems() {
    return CountriesWithFlagsLocalData.buildDropDownMenuItems();
  }
}

final LocalDataRepo localDataRepo = LocalDataRepo();
