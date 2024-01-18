import 'package:flutter/material.dart';

import 'notosansthai.dart';

class Palette {
  static const mainGreen = Color(0xff3599AA);
  static const mainYellow = Color(0xffEF9725);
  static const black = Color(0xff001F23);
  static const white = Color(0xffFFFFFF);
  static const grey1 = Color(0xff758486);
  static const whiteBg = Color(0xffFEFEFE);
  static const whiteBg2 = Color(0xffFCFCFC);
  static const whiteBg3 = Color(0xffF7F7F7);
  static const red = Color(0xffEA5455);
  static const lightGrey = Color(0xffA5A2AD);
  static const black2 = Color(0xff2F484B);
  static const storke = Color(0xffDBDADE);
  static const greyIcon = Color(0xffA5A2AD);
  static const blueIcon = Color(0xFF60D1E5);

  static const skeleton = Color(0xffEFF1F1);
  static const chatBox = Color(0xffF1F1F1);

  //coin
  static const coinlight = Color(0xffFEDA2C);
  static const coindark = Color(0xffFCAA17);

  //shadow
  static BoxShadow shadowGreen = BoxShadow(
    color: const Color(0xff3599AA).withOpacity(0.6),
    blurRadius: 22,
    offset: const Offset(0, 9),
  );
  static BoxShadow shadowDefault = BoxShadow(
    color: const Color(0xffA5A3AE).withOpacity(0.07),
    blurRadius: 12,
    offset: const Offset(0, 4),
  );
  static BoxShadow shadowCard = BoxShadow(
    color: const Color(0xff4B465C).withOpacity(0.125),
    blurRadius: 18,
    offset: const Offset(0, 4),
  );
  static BoxShadow shadowButtonX = BoxShadow(
    color: Palette.black.withOpacity(0.1),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );

  static const int _primaryGreenMaterial = 0xff3599AA;
  // static const int _secondaryYellowMaterial = 0xffEF9725;

  static const MaterialColor primaryGreen = MaterialColor(
    _primaryGreenMaterial,
    <int, Color>{
      50: Color(0xFFE2F7FB),
      100: Color(0xFFB6EBF5),
      200: Color(0xFF89DFEE),
      300: Color(0xFF60D1E5),
      400: Color(0xFF48C7DE),
      500: Color(0xFF40BED7),
      600: Color(0xFF3BAEC4),
      700: Color(_primaryGreenMaterial),
      800: Color(0xFF308492),
      900: Color(0xFF276167),
    },
  );

  //themeData
  static final themeData = ThemeData(
    fontFamily: 'NotoSansThai',
    primarySwatch: primaryGreen,
    unselectedWidgetColor: storke,
    appBarTheme: AppBarTheme(
      backgroundColor: whiteBg,
      toolbarHeight: 56,
      elevation: 0,
      titleSpacing: 0,
      titleTextStyle: NotoSansThai.h3.copyWith(color: black),
      iconTheme: const IconThemeData(
        color: black,
        size: 24,
      ),
    ),
    //NOTE ถ้า bottomNavigationBar ทำในนี้ได้ก็แก้เอาเลย
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: mainGreen,
    ),
    scaffoldBackgroundColor: whiteBg,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: white,
      iconColor: greyIcon,
      hintStyle: NotoSansThai.textInput.copyWith(color: greyIcon),
      counterStyle: NotoSansThai.textInput.copyWith(color: black),
      contentPadding: const EdgeInsets.all(12),
      border: customBorder(),
      enabledBorder: customBorder(),
      focusedBorder: customBorder(color: mainGreen),
      errorBorder: customBorder(color: red),
      disabledBorder: customBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainGreen,
        disabledBackgroundColor: Palette.storke.withOpacity(0.6),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        shadowColor: const Color.fromRGBO(165, 163, 174, 0.3),
        elevation: 2,
        fixedSize: const Size.fromHeight(45),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        textStyle: NotoSansThai.h3.copyWith(color: white),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: white,
        side: const BorderSide(
          color: mainGreen,
          width: 1,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        shadowColor: const Color.fromRGBO(165, 163, 174, 0.3),
        elevation: 2,
        fixedSize: const Size.fromHeight(45),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        textStyle: NotoSansThai.h3.copyWith(color: mainGreen),
      ),
    ),
    dividerTheme: const DividerThemeData(color: storke, thickness: 1),
    sliderTheme:
        const SliderThemeData(showValueIndicator: ShowValueIndicator.always),
  );
}

InputBorder customBorder({Color color = Palette.storke}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      width: 1,
      color: color,
    ),
  );
}
