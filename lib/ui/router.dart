import 'package:fresh9_rider/core/model/order_model.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/ui/search_view.dart';
import 'package:fresh9_rider/ui/view/address/add_addres_view.dart';
import 'package:fresh9_rider/ui/view/address/address_view.dart';
import 'package:fresh9_rider/ui/view/address/mapPage.dart';
import 'package:fresh9_rider/ui/view/address/your_address_view.dart';
import 'package:fresh9_rider/ui/view/authentication/login_view.dart';
import 'package:fresh9_rider/ui/view/cart/cart_view.dart';
import 'package:fresh9_rider/ui/view/cart/empty_cart_view.dart';
import 'package:fresh9_rider/ui/view/category/categories_detail_view.dart';
import 'package:fresh9_rider/ui/view/category/featured_products_view.dart';
import 'package:fresh9_rider/ui/view/category/item_detail_view.dart';
import 'package:fresh9_rider/ui/view/category/products_view.dart';
import 'package:fresh9_rider/ui/view/category/store_category_view.dart';
import 'package:fresh9_rider/ui/view/category/store_products_view.dart';
import 'package:fresh9_rider/ui/view/order_service_view.dart';
import 'package:fresh9_rider/ui/view/home_screens/resturant_menu_view.dart';
import 'package:fresh9_rider/ui/view/category/categories_view.dart';
import 'package:fresh9_rider/ui/view/notification_view.dart';
import 'package:fresh9_rider/ui/view/order/my_order_view.dart';
import 'package:fresh9_rider/ui/view/order/no_order_view.dart';
import 'package:fresh9_rider/ui/view/order/order_detail_view.dart';
import 'package:fresh9_rider/ui/view/order/place_order_view.dart';
import 'package:fresh9_rider/ui/view/order/order_placed_view.dart';
import 'package:fresh9_rider/ui/view/authentication/enter_number_view.dart';
import 'package:fresh9_rider/ui/view/home_screens/app_services_view.dart';
import 'package:fresh9_rider/ui/view/home_screens/fresh9_home_view.dart';
import 'package:fresh9_rider/ui/view/home_screens/restaurant_home_view.dart';
import 'package:fresh9_rider/ui/view/home_screens/services_view.dart';
import 'package:fresh9_rider/ui/view/home_screens/shops_view.dart';
import 'package:fresh9_rider/ui/view/privacy_policy_view.dart';
import 'package:fresh9_rider/ui/view/profile/edit_profile_view.dart';
import 'package:fresh9_rider/ui/view/profile/profile_view.dart';
import 'package:fresh9_rider/ui/view/terms&conditions.dart';
import 'package:fresh9_rider/ui/view/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:fresh9_rider/ui/view/splash_screen_view.dart';
import 'package:fresh9_rider/ui/view/suggest_view.dart';
import 'package:fresh9_rider/ui/view/authentication/signup_view.dart';
import 'package:fresh9_rider/ui/view/authentication/landing_view.dart';

class NavigationRouter {
  static const String splashScreen = "splashScreen";
  static const String termsScreen = "termsScreen";
  static const String privacyPolicy = "privacyPolicy";
  static const String storeProducts = "storeProducts";
  static const String storeCategories = "storeCategories";
  static const String mapScreen = "mapScreen";
  static const String signUpScreen = "signUpScreen";
  static const String landingScreen = "landingScreen";
  static const String signInScreen = "signInScreen";
  static const String suggestScreen = "suggestScreen";
  static const String enterNumberScreen = "EnterNumberScreen";
  static const String appServices = "AppServices";
  static const String fresh9View = "Fresh9View";
  static const String restaurantView = 'RestaurantView';
  static const String shopsView = 'ShopsView';
  static const String servicesView = 'ServicesView';
  static const String notificationView = 'notificationView';
  static const String myOrderView = 'myOrderView';
  static const String walletView = 'walletView';
  static const String noOrderView = 'noOrderView';
  static const String orderPlacedView = 'orderPlacedView';
  static const String placeOrderView = 'placeOrderView';
  static const String profileView = 'profileView';
  static const String editProfile = 'EditProfile';
  static const String addAddressView = "addAddressView";
  static const String addressView = 'AddressView';
  static const String yourAddressView = 'yourAddressView';
  static const String cartView = 'CartView';
  static const String emptyCartView = 'emptyCartView';
  static const String categoriesView = 'categoriesView';
  static const String productssView = 'productssView';
  static const String featuredProductssView = 'featuredProductssView';
  static const String categoriesDetailView = 'categoriesDetailView';
  static const String serviceDetailView = 'serviceDetailView';
  static const String itemDetailView = 'itemDetailView';
  static const String searchView = 'searchView';
  static const String restaurantMenuView = 'restaurantMenuView';
  static const String orderDetailView = 'orderDetailView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreenView(),
        );
        break;
      case mapScreen:
        return MaterialPageRoute(
          builder: (_) => MapPage(),
        );
        break;
      case searchView:
        Map data = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => SearchView(data['products'], data['type']),
        );
        break;
      case termsScreen:
        return MaterialPageRoute(
          builder: (_) => TermsAndConditions(),
        );
      case privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => PrivacyPolicy(),
        );
        break;
      case itemDetailView:
        var data = settings.arguments as Map;
        print("router data");
        print(data);
        return MaterialPageRoute(
          builder: (_) => ItemDetailView(data['product'], data['products']),
        );
        break;
      case orderDetailView:
        var data = settings.arguments as OrderModel;
        return MaterialPageRoute(
          builder: (_) => OrderDetailPage(data),
        );
        break;
      case storeProducts:
        var data = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => StoreProductsView(data),
        );
        break;
      case storeCategories:
        var data = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => StoreCategoriesView(data),
        );
        break;
      case signUpScreen:
        var data = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => SignUpView(data),
        );
        break;
      case signInScreen:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
        );
        break;
      case landingScreen:
        return MaterialPageRoute(
          builder: (_) => LandingView(),
        );
        break;
      case suggestScreen:
        return MaterialPageRoute(
          builder: (_) => SuggestView(),
        );
        break;
      case enterNumberScreen:
        var data = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => EnterNumber(data: data,),
        );
        break;
      case appServices:
        return MaterialPageRoute(builder: (_) => AppServices());
        break;
      case fresh9View:
        return MaterialPageRoute(builder: (_) => Fresh9HomeView());
        break;
      case restaurantView:
        return MaterialPageRoute(builder: (_) => RestaurantView());
        break;
      case shopsView:
        return MaterialPageRoute(builder: (_) => ShopsView());
        break;
      case servicesView:
        return MaterialPageRoute(builder: (_) => ServicesView());
        break;
      case notificationView:
        return MaterialPageRoute(builder: (_) => NotificationView());
        break;
      case noOrderView:
        return MaterialPageRoute(builder: (_) => NoOrderView());
        break;
      case walletView:
        return MaterialPageRoute(builder: (_) => WalletView());
        break;
      case myOrderView:
        return MaterialPageRoute(builder: (_) => MyOrderView());
        break;
      case placeOrderView:
        String data = settings.arguments;
        return MaterialPageRoute(builder: (_) => PlaceOrder(data));
        break;
      case orderPlacedView:
        String data = settings.arguments;
        return MaterialPageRoute(builder: (_) => OrderPlacedView(data));
        break;
      case profileView:
        return MaterialPageRoute(builder: (_) => ProfileView());
        break;
      case editProfile:
        return MaterialPageRoute(builder: (_) => EditProfileView());
        break;
      case addAddressView:
        List data = settings.arguments;
        return MaterialPageRoute(builder: (_) => AddAddressView(data));
        break;
      case addressView:
        bool data = settings.arguments;
        return MaterialPageRoute(builder: (_) => AddressView(choose: data));
        break;
      case yourAddressView:
        Map data = settings.arguments;
        return MaterialPageRoute(builder: (_) => YourAddressView(data));
        break;
      case cartView:
        return MaterialPageRoute(builder: (_) => CartView());
        break;
      case emptyCartView:
        return MaterialPageRoute(builder: (_) => EmptyCartView());
        break;
      case categoriesView:
        List<Product> data = settings.arguments;

        return MaterialPageRoute(builder: (_) => CategoriesView(data));
        break;
      case productssView:
        String data = settings.arguments;
        return MaterialPageRoute(builder: (_) => ProductsView(data));
        break;
      case featuredProductssView:
        String data = settings.arguments;
        return MaterialPageRoute(builder: (_) => FeaturedProductsView(data));
        break;
      case categoriesDetailView:
        Map data = settings.arguments;
        print(categoriesDetailView);
        print(data);
        return MaterialPageRoute(builder: (_) => CategoriesDetailView(data));
        break;
      case serviceDetailView:
        String title = settings.arguments;
        return MaterialPageRoute(builder: (_) => OrderServiceView(title));
        break;
      case restaurantMenuView:
        return MaterialPageRoute(builder: (_) => ResturantMenuView());
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
        break;
    }
  }
}
