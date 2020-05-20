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
  Color get transparent => Color(0x00FFFFFF);
  Color get scaffoldBgColor => Color(0xFFFFFFFF);
  Color get whiteColor => Color(0XFFFFFFFF);
  Color get blueMainColor => Color(0xFF2E5BF5);
  Color get grayTextColor => Color(0xFF656565);

  TextStyle get bodyTextStyle => TextStyle(fontSize: 14.0, color: Colors.white);
}
