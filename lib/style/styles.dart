import 'package:google_fonts/google_fonts.dart';

import '../common_libraries.dart';
import 'colors.dart';
import 'constants.dart';


AppStyle $styles = AppStyle();

@immutable
class AppStyle {
  AppStyle({Size? appSize}) {
    if (appSize == null) {
      scale = 1;
      return;
    }
    final screenSize = (appSize.width + appSize.height) / 2;
    if (screenSize > 1600) {
      scale = 1.25;
    } else if (screenSize > 1400) {
      scale = 1.15;
    } else if (screenSize > 1000) {
      scale = 1.1;
    } else if (screenSize > 800) {
      scale = 1;
    } else {
      scale = .9;
    }
    debugPrint('screenSize=$screenSize, scale=$scale');
  }

  late final double scale;

  /// The current theme colors for the app
  final AppColors colors = AppColors();

  final AppConstants appConstants = AppConstants();

  /// Rounded edge corner radii
  late final _Corners corners = _Corners();

  late final _Shadows shadows = _Shadows();

  /// Padding and margin values
  late final _Insets insets = _Insets(scale);

  /// Text styles
  late final _Text text = _Text(scale);

  /// Animation Durations
  final _Times times = _Times();

  /// Shared sizes
  late final _Sizes sizes = _Sizes();
}

@immutable
class _Text {
  _Text(this._scale);
  final double _scale;


  late final TextStyle dropCase = _createFont(GoogleFonts.cinzel(), sizePx: 56, heightPx: 20);

  late final TextStyle wonderTitle = _createFont(GoogleFonts.tenorSans(), sizePx: 64, heightPx: 56);

  late final TextStyle h1 = _createFont(GoogleFonts.tenorSans(), sizePx: 64, heightPx: 62);
  late final TextStyle h2 = _createFont(GoogleFonts.b612Mono(), sizePx: 32, heightPx: 46);
  late final TextStyle homeIntroLineOne = _createFont(GoogleFonts.tenorSans(), sizePx: 24, heightPx: 36, weight: FontWeight.w600);
  late final TextStyle homeIntroLineTwo = _createFont(GoogleFonts.raleway(), sizePx: 16, heightPx: 16,color: $styles.colors.greyStrong);
  late final TextStyle h4 = _createFont(GoogleFonts.raleway(), sizePx: 14, heightPx: 23, spacingPc: 5, weight: FontWeight.w600);

  late final TextStyle title = _createFont(GoogleFonts.rajdhani(), sizePx: 16,weight: FontWeight.w700);
  late final TextStyle title1 = _createFont(GoogleFonts.b612Mono(), sizePx: 16, heightPx: 26, spacingPc: 5);
  late final TextStyle title2 = _createFont(GoogleFonts.b612Mono(), sizePx: 14, heightPx: 16.38);

  late final TextStyle body = _createFont(GoogleFonts.raleway(), sizePx: 16, heightPx: 27);
  late final TextStyle blackBody = _createFont(GoogleFonts.raleway(), sizePx: 16, heightPx: 17,color: $styles.colors.black);
  late final TextStyle bodyBold = _createFont(GoogleFonts.raleway(), sizePx: 16, heightPx: 26, weight: FontWeight.w600);
  late final TextStyle blackBodyBold = _createFont(GoogleFonts.raleway(), sizePx: 13, heightPx: 16, weight: FontWeight.w600,color: $styles.colors.black);
  late final TextStyle whiteBodyBold = _createFont(GoogleFonts.raleway(), sizePx: 13, heightPx: 16, weight: FontWeight.w600,color: $styles.colors.white);
  late final TextStyle bodySmall = _createFont(GoogleFonts.raleway(), sizePx: 14, heightPx: 23);
  late final TextStyle bodySmallBold = _createFont(GoogleFonts.raleway(), sizePx: 14, heightPx: 23, weight: FontWeight.w600);

  late final TextStyle quote1 =
  _createFont(GoogleFonts.cinzel(), sizePx: 32, heightPx: 40, weight: FontWeight.w600, spacingPc: -3);
  late final TextStyle quote2 = _createFont(GoogleFonts.cinzel(), sizePx: 21, heightPx: 32, weight: FontWeight.w400);
  late final TextStyle quote2Sub = _createFont(body, sizePx: 16, heightPx: 40, weight: FontWeight.w400);

  late final TextStyle caption =
  _createFont(GoogleFonts.raleway(), sizePx: 12, heightPx: 18, weight: FontWeight.w500).copyWith(fontStyle: FontStyle.italic);

  late final TextStyle callout =
  _createFont(GoogleFonts.raleway(), sizePx: 16, heightPx: 26, weight: FontWeight.w600).copyWith(fontStyle: FontStyle.italic);
  late final TextStyle btn = _createFont(GoogleFonts.raleway(), sizePx: 12, weight: FontWeight.w600, heightPx: 14);

  TextStyle _createFont(TextStyle style,
      {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight,Color? color}) {
    sizePx *= _scale;
    if (heightPx != null) {
      heightPx *= _scale;
    }
    return style.copyWith(
        fontSize: sizePx,
        height: heightPx != null ? (heightPx / sizePx) : style.height,
        letterSpacing: spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
        fontWeight: weight,color: color);
  }
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
}

// TODO: add, @immutable when design is solidified
class _Sizes {
  double get maxContentWidth1 => 800;
  double get maxContentWidth2 => 600;
  double get maxContentWidth3 => 500;
  final Size minAppSize = const Size(380, 675);
}

@immutable
class _Insets {
  _Insets(this._scale);
  final double _scale;

  late final double xxs = 4 * _scale;
  late final double xs = 8 * _scale;
  late final double sm = 16 * _scale;
  late final double md = 24 * _scale;
  late final double lg = 32 * _scale;
  late final double xl = 48 * _scale;
  late final double xxl = 56 * _scale;
  late final double offset = 80 * _scale;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(color: Colors.black.withOpacity(.25), offset: const Offset(0, 2), blurRadius: 4),
  ];
  final text = [
    Shadow(color: Colors.black.withOpacity(.6), offset: const Offset(0, 2), blurRadius: 2),
  ];
  final textStrong = [
    Shadow(color: Colors.black.withOpacity(.6), offset: const Offset(0, 4), blurRadius: 6),
  ];
}