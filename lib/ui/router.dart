import 'package:Product/ui/view/authentication/enter_number_view.dart';
import 'package:Product/ui/view/homes_screens/app_services_view.dart';
import 'package:Product/ui/view/homes_screens/fresh9_home_view.dart';
import 'package:flutter/material.dart';
import 'package:Product/ui/view/splash_screen_view.dart';
import 'package:Product/ui/view/suggest_view.dart';
import 'package:Product/ui/view/authentication/signup_view.dart';
import 'package:Product/ui/view/authentication/landing_view.dart';

class NavigationRouter {
  static const String splashScreen = "splashScreen";
  static const String signUpScreen = "signUpScreen";
  static const String landingScreen = "landingScreen";
  static const String signInScreen = "signInScreen";
  static const String suggestScreen = "suggestScreen";
  static const String enterNumberScreen = "EnterNumberScreen";
  static const String appServices = "AppServices";
  static const String fresh9View = "Fresh9View";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreenView(),
        );
      case signUpScreen:
        return MaterialPageRoute(
          builder: (_) => SignUpView(),
        );
      case landingScreen:
        return MaterialPageRoute(
          builder: (_) => LandingView(),
        );
      case suggestScreen:
        return MaterialPageRoute(
          builder: (_) => SuggestView(),
        );
      case enterNumberScreen:
        return MaterialPageRoute(
          builder: (_) => EnterNumber(),
        );
      case appServices:
        return MaterialPageRoute(builder: (_)=>AppServices());
      case fresh9View:
        return MaterialPageRoute(builder: (_)=>Fresh9HomeView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
