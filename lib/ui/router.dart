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
