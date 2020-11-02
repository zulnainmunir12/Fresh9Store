import 'package:Product/ui/notification/notification.dart';
import 'package:Product/ui/order/order_arrive.dart';
import 'package:Product/ui/order/my_order.dart';
import 'package:Product/ui/order/place_order.dart';
import 'package:Product/ui/order/recieved_order.dart';
import 'package:Product/ui/view/authentication/enter_number_view.dart';
import 'package:Product/ui/view/homes_screens/app_services_view.dart';
import 'package:Product/ui/view/homes_screens/fresh9_home_view.dart';
import 'package:Product/ui/view/homes_screens/restaurant_home_view.dart';
import 'package:Product/ui/view/homes_screens/services_view.dart';
import 'package:Product/ui/view/homes_screens/shops_view.dart';
import 'package:Product/ui/wallet/wallet_page.dart';
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
  static const String notificationScreen = 'NotificationScreen';
  static const String myOrder = 'MyOrder';
  static const String walletPage = 'WalletPage';
  static const String arrivedOrder = 'ArrivedOrder';
  static const String placeOrder ='PlaceOrder';
  static const String receivedOrder = 'ReceivedOrder';

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
      case notificationScreen:
        return MaterialPageRoute(builder: (_)=>NotificationScreen());
      case myOrder:
        return MaterialPageRoute(builder: (_)=>MyOrder());
      case walletPage:
        return MaterialPageRoute(builder: (_)=>WalletPage());
      case arrivedOrder:
        return MaterialPageRoute(builder: (_)=>ArrivedOrder());
      case placeOrder:
        return MaterialPageRoute(builder: (_)=>PlaceOrder());
      case receivedOrder:
        return MaterialPageRoute(builder: (_)=>ReceivedOrder());
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
