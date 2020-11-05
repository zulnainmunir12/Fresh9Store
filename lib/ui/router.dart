import 'package:Product/ui/view/address/add_addres.dart';
import 'package:Product/ui/view/address/address_view.dart';
import 'package:Product/ui/view/address/your_address.dart';
import 'package:Product/ui/view/cart/cart_view.dart';
import 'package:Product/ui/view/cart/checkout.dart';
import 'package:Product/ui/view/category/vegetables_fruits.dart';
import 'package:Product/ui/view/electrician_view.dart';
import 'package:Product/ui/view/home_screens/karachi_biryani.dart';
import 'file:///C:/Users/Zuni/IdeaProjects/Product/lib/ui/view/category/gategories.dart';
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
import 'package:Product/ui/view/profile/edit_profile.dart';
import 'package:Product/ui/view/profile/profile.dart';
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
  static const String profile = 'Profile';
  static const String editProfile = 'EditProfile';
  static const String addAddress = "AddAddress";
  static const String addressView = 'AddressView';
  static const String yourAddress ='YourAddress';
  static const String cartView = 'CartView';
  static const String checkOut = 'CheckOut';
  static const String categories = 'Categories';
  static const String vegetablesFruits = 'VegetablesFruits';
  static const String electrician = 'Electrician';
  static const String karachiBiryani = 'KarachiBiryani';

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
      case profile:
        return MaterialPageRoute(builder: (_)=>Profile());
      case editProfile:
        return MaterialPageRoute(builder: (_)=>EditProfile());
      case addAddress:
        return MaterialPageRoute(builder: (_)=>AddAddress());
      case addressView:
        return MaterialPageRoute(builder: (_)=>AddressView());
      case yourAddress:
        return MaterialPageRoute(builder: (_)=>YourAddress());
      case cartView:
        return MaterialPageRoute(builder: (_)=>CartView());
      case checkOut:
        return MaterialPageRoute(builder: (_)=>CheckOut());
      case categories:
        return MaterialPageRoute(builder: (_)=>Categories());
      case vegetablesFruits:
        return MaterialPageRoute(builder: (_)=>VegetablesFruits());
      case electrician:
        return MaterialPageRoute(builder: (_)=>Electrician());
      case karachiBiryani:
        return MaterialPageRoute(builder: (_)=>KarachiBiryani());
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
