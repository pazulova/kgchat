import 'package:easy_mask/easy_mask.dart';

class MaskingStringUtil {
  static final MaskingStringUtil _singleton = MaskingStringUtil._internal();

  factory MaskingStringUtil() {
    return _singleton;
  }

  MaskingStringUtil._internal();

  static String maskingPhoneNumber(String _phone) {
    MagicMask mask = MagicMask.buildMask('\\+999 (999) 99-99-99');
    return mask.getMaskedString(_phone);
  }
}
