import 'package:Product/ui/view/notification_view.dart';
import 'package:Product/ui/view/order/my_order_view.dart';
import 'package:Product/ui/view/order/no_order_view.dart';
import 'package:Product/ui/view/order/place_order.dart';
import 'package:Product/ui/view/order/order_placed_view.dart';
import 'package:Product/ui/view/authentication/enter_number_view.dart';
import 'package:Product/ui/view/home_screens/app_services_view.dart';
import 'package:Product/ui/view/home_screens/fresh9_home_view.dart';
import 'package:Product/ui/view/home_screens/restaurant_home_view.dart';
import 'package:Product/ui/view/home_screens/services_view.dart';
import 'package:Product/ui/view/home_screens/shops_view.dart';
import 'package:Product/ui/view/wallet_view.dart';
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
  static const String restaurantView ='RestaurantView';
  static const String shopsView = 'ShopsView';
  static const String servicesView = 'ServicesView';
  static const String notificationView = 'notificationView';
  static const String myOrderView = 'myOrderView';
  static const String walletView = 'walletView';
  static const String noOrderView = 'noOrderView';
  static const String orderPlacedView ='orderPlacedView';
  static const String placeOrderView = 'placeOrderView';

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
      case restaurantView:
        return MaterialPageRoute(builder: (_)=>RestaurantView());
      case shopsView:
        return MaterialPageRoute(builder: (_)=>ShopsView());
      case servicesView:
        return MaterialPageRoute(builder: (_)=>ServicesView());
      case notificationView:
        return MaterialPageRoute(builder: (_)=>NotificationView());
      case noOrderView:
        return MaterialPageRoute(builder: (_)=>NoOrderView());
      case walletView:
        return MaterialPageRoute(builder: (_)=>WalletView());
      case myOrderView:
        return MaterialPageRoute(builder: (_)=>MyOrderView());
      case placeOrderView:
        return MaterialPageRoute(builder: (_)=>PlaceOrder());
      case orderPlacedView:
        return MaterialPageRoute(builder: (_)=>OrderPlacedView());
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
