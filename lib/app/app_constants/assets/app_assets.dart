import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  static const String _illustrations = 'assets/vectors/illustrations';
  static const String _icons = 'assets/vectors/icons';

  static final Map<String, String> _paths = {
    /// Illustrations
    'walkthrough': '$_illustrations/walkthrough.svg',

    /// Icons
    'chat_icon': '$_icons/chat_icon.svg',
  };

  static SvgPicture walkthrough({required double? height}) =>
      SvgPicture.asset(_paths['walkthrough']!, height: height);

  // SvgPicture.asset('assets/vectors/illustrations/walkthrough.svg');
}
