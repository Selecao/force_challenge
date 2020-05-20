import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;

class AppTheme extends InheritedWidget {
  const AppTheme({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(child != null),
        assert(data != null),
        super(key: key, child: child);

  final AppThemeData data;

  @override
  bool updateShouldNotify(AppTheme oldWidget) => data != oldWidget.data;

  static AppThemeData of(BuildContext context) {
    final AppTheme theme = context.dependOnInheritedWidgetOfExactType();
    return theme?.data ?? AppThemeData();
  }
}

class AppThemeData {
  Color get whiteColor => Color(0XFFFFFFFF);
  Color get blueMainColor => Color(0xFF2E5BF5);
  Color get grayLightColor => Color(0xFFEDF4F8);
  Color get graySeparatorColor => Color.fromRGBO(135, 152, 173, 0.3);

  TextStyle get bodyLightTextStyle => TextStyle(
        fontSize: 12.0,
        color: Colors.white,
      );

  TextStyle get bodyDarkTextStyle =>
      bodyLightTextStyle.copyWith(color: Colors.black);

  String get defaultFontFamily => 'Helvetica';

  String get greetingFontFamily => 'Roboto';

  TextStyle get greetingTextStyle => TextStyle(
        fontFamily: greetingFontFamily,
        fontSize: 14.0,
      );

  TextStyle get greetingBoldTextStyle => TextStyle(
        fontFamily: greetingFontFamily,
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
      );

  TextStyle get notificationTitleTextStyle => TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      );

  BorderRadius get framesRadius => BorderRadius.circular(12.0);

  BoxShadow get boxShadow => BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        blurRadius: 2.0, // has the effect of softening the shadow
        spreadRadius: 0.0, // has the effect of extending the shadow
        offset: Offset(
          2.0, // horizontal, move right
          4.0, // vertical, move down
        ),
      );
}
