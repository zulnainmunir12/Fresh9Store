import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Product/ui/shared/app_colors.dart';

class AppConfig extends ChangeNotifier {
  final ThemeData themeData = ThemeData(
    primaryColor: AppColor.primaryColor,
    appBarTheme: AppBarTheme(
      color: AppColor.whiteColor,
      iconTheme: IconThemeData(
        color: AppColor.primaryColor,
      ),
    ),
    fontFamily: 'Segoe',
    scaffoldBackgroundColor: AppColor.backgroundColor,
    cursorColor: AppColor.darkGrey,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: AppColor.blackColor,
      ),
    ),
  );

  String _appLanguageCode;

  String get appLanguageCode => _appLanguageCode;


}
