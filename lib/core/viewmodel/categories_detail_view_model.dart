import 'package:flutter/services.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/base_model.dart';
import 'package:fresh9_rider/core/model/category_model.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/model/store_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/custom_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';



class CategoriesDetailViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Api _api = locator<Api>();
  final AuthService _authService = locator<AuthService>();
  final CartService _cartService = locator<CartService>();
  CartService get cartService => _cartService;
  List banners = [];
  PermissionStatus _permissionGranted;
  final Location _location = Location();
  LocationData _locationData;
  bool serviceEnabled;
  UserInfoModel get userInfoModel => _authService.userInfoModel;

  navigateToLogin() async {
    _navigationService.navigateToAndBack(
      NavigationRouter.enterNumberScreen,
    );
  }

  List<Category> _categories = [];

  List<Category> get categories => _categories;

  List<StoreModel> _stores = [];

  List<StoreModel> get stores => _stores;

  int _savedIndex;

  get savedIndex => _savedIndex;

  Product _savedCartModel;

  Product get savedCartModel => _savedCartModel;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_cartService, _authService];

  onTapAddItem(Product cartModelData, BuildContext context) async {
    List<Product> _cartModelList =
        Provider.of<List<Product>>(context, listen: false);
    bool itemFound = false;
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String savedStoreId = sharedPreference.get(SharedPreference.storeId);

    if (cartModelData.storeId != savedStoreId) {
      await sharedPreference.setString(
          SharedPreference.storeId, cartModelData.storeId);
      _cartService.clearCart();
    }
    int index =
        _products.indexWhere((element) => element.id == cartModelData.id);
    --_products[index].inventory;
    if (cartModelData.id == _products[index].id)
      ++_products[index].orderQuantity;
    else {
      int itemIndex =
          products.indexWhere((element) => element.id == cartModelData.id);
      ++_products[itemIndex].orderQuantity;
    }

    for (int index = 0; index < _cartModelList.length; index++)
      if (cartModelData.id == _cartModelList[index].id) {
        itemFound = true;
        _savedIndex = index;
        _cartService.addCartQuantity(index);
        _savedCartModel = _cartModelList[index];
      }
    if (!itemFound) {
      _savedIndex = await _cartService.addCartToStream(cartModelData);
      _savedCartModel = cartModelData;
    }

//    await _navigationService.navigateToAndBack(NavigationRouter.cartView);
    notifyListeners();
  }

  onRemoveItem(Product cartModelData, BuildContext context) async {
    List<Product> _cartModelList =
        Provider.of<List<Product>>(context, listen: false);
    bool itemFound = false;
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String savedStoreId = sharedPreference.get(SharedPreference.storeId);

    int index =
        _products.indexWhere((element) => element.id == cartModelData.id);
    ++_products[index].inventory;
    print(products[index].orderQuantity);
    print(cartModelData.id == _products[index].id);
    if (cartModelData.id == _products[index].id)
      --_products[index].orderQuantity;
    else {
      int itemIndex =
          products.indexWhere((element) => element.id == cartModelData.id);
      --_products[itemIndex].orderQuantity;
    }
    if (cartModelData.storeId != savedStoreId) {
      await sharedPreference.setString(
          SharedPreference.storeId, cartModelData.storeId);
      _cartService.clearCart();
    }

    for (int index = 0; index < _cartModelList.length; index++)
      if (cartModelData.id == _cartModelList[index].id) {
        print("item found");
        print(cartModelData.orderQuantity);
        itemFound = true;
        _savedIndex = index;
        _savedCartModel = _cartModelList[index];
        if (cartModelData.orderQuantity == 0)
          _cartService.removeCartOfStream(index);
        else
          _cartService.decrementCartQuantity(index);
      }
//    if (!itemFound) {
//      _savedIndex = await _cartService.addCartToStream(cartModelData);
//      _savedCartModel = cartModelData;
//    }

//    await _navigationService.navigateToAndBack(NavigationRouter.cartView);
    notifyListeners();
  }

  onDeleteItem(Product cartModelData, BuildContext context) async {
    List<Product> _cartModelList =
        Provider.of<List<Product>>(context, listen: false);
    bool itemFound = false;
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String savedStoreId = sharedPreference.get(SharedPreference.storeId);

    int itemIndex =
        products.indexWhere((element) => element.id == cartModelData.id);
    --products[itemIndex].orderQuantity;
    if (cartModelData.storeId != savedStoreId) {
      await sharedPreference.setString(
          SharedPreference.storeId, cartModelData.storeId);
      _cartService.clearCart();
    }

    for (int index = 0; index < _cartModelList.length; index++)
      if (cartModelData.id == _cartModelList[index].id) {
        itemFound = true;
        _savedIndex = index;
        _cartService.removeCartOfStream(index);
        _savedCartModel = _cartModelList[index];
      }
    if (!itemFound) {
      _savedIndex = await _cartService.addCartToStream(cartModelData);
      _savedCartModel = cartModelData;
    }

//    await _navigationService.navigateToAndBack(NavigationRouter.cartView);
    notifyListeners();
  }

  List<Product> _products = [];

  List<Product> get products => _products;

  List<Product> _featuredProducts = [];

  List<Product> get featuredProducts => _featuredProducts;

  Category _category;
  Category get category => _category;
  List<Category> _subCategories;
  List<Category> get subCategories => _subCategories;

  int get itemCount => _cartService.cartModelDataList.length;

  CategoriesDetailViewModel(
      {Category cat, List<Category> sub, List<Product> prod}) {
    _category = cat;
    _subCategories = subCategories;
    _products = prod;
    notifyListeners();
  }
//
//  setProducts(List<Product> newProducts){
//    _products = newProducts;
//    notifyListeners();
//
//  }

  getProducts(String storeId) async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );

    BaseModel response = await _api.allProducts(token, storeId);
    if (response.serverError == null) {
      _products = response.body;
      _products.forEach((element) {
        if (element.featuredProduct) _featuredProducts.add(element);
      });
      getCategories();
    } else
      setState(ViewState.error);
  }

  getAds(String type,double lat,double lng) async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
    banners = [];
    BaseModel response = await _api.getBanners(token, type,lat,lng);
    if (response.serverError == null) {
      banners = response.body;
    } else {
      setState(ViewState.error);
    }
  }

  Future<LocationData> _determinePosition() async {
    setState(ViewState.loading);



    //////*********************
    try {
      final PermissionStatus permissionGrantedResult =
      await _location.hasPermission();

      _permissionGranted = permissionGrantedResult;

      if (_permissionGranted != PermissionStatus.granted) {
        final PermissionStatus permissionRequestedResult =
        await _location.requestPermission();

        _permissionGranted = permissionRequestedResult;
      }

      if (_permissionGranted == PermissionStatus.granted) {
        try {
          final LocationData _locationResult = await _location.getLocation();

          _locationData = _locationResult;
          setState(ViewState.idle);
          getFresh9Store(_locationData);
        } on PlatformException catch (err) {
          setState(ViewState.error);
        }
      } else {
        setState(ViewState.error);
      }
    } catch (e) {
      setState(ViewState.error);
    }
    ///////////**************





//    // Test if location services are enabled.
//    try {
////      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
////      if (!serviceEnabled) {
////        // Location services are not enabled don't continue
////        // accessing the position and request users of the
////        // App to enable the location services.
////        setState(() {
////          message = 'Location services are disabled. Kindly enable it';
////        });
////      }
//      print("in location");
//
//      permission = await Geolocator.checkPermission();
//      print("check permission");
//      if (permission == LocationPermission.denied) {
//        permission = await Geolocator.requestPermission();
//        if (permission == LocationPermission.denied) {
//          // Permissions are denied, next time you could try
//          // requesting permissions again (this is also where
//          // Android's shouldShowRequestPermissionRationale
//          // returned true. According to Android guidelines
//          // your App should show an explanatory UI now.
////          setState(() {
////            message = 'Location permission is required';
////          });
//          return Future.error('Location permissions are denied');
//        }
//      }
//      print("check permission before denied forever");
//      if (permission == LocationPermission.deniedForever) {
//        // Permissions are denied forever, handle appropriately.
////        setState(() {
////          message = 'Location permissions are permanently denied, '
////              'we cannot request permissions. Kindly go to settings and '
////              'enable location permission';
////        });
//        return Future.error(
//            'Location permissions are permanently denied, we cannot request permissions.');
//      }
//
//      // When we reach here, permissions are granted and we can
//      // continue accessing the position of the device.
//      print("check location");
//
//      if (permission == LocationPermission.whileInUse ||
//          permission == LocationPermission.always) {
//        geo.Geolocation.enableLocationServices().then((result) {
//          // Request location
//        }).catchError((e) {
//          // Location Services Enablind Cancelled
//        });
//      }
//
//      Stream<geo.LocationResult> stream =
//          geo.Geolocation.currentLocation(accuracy: geo.LocationAccuracy.best);
//      stream.listen((result) {
//        print(result.location);
//        print("got location");
//        geo.Location _location = result.location;
//        getFresh9Store(_location);
//      });
//    } catch (e) {
//      print(e);
//      setState(ViewState.idle);
//    }
  }

  getFresh9Store(LocationData _location) async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
//    Position _location = await _determinePosition();
    if (_location.latitude != null) {
      BaseModel response = await _api.getFresh9(
          token, {"lat": _location.latitude, "lng": _location.longitude});
      if (response.serverError == null) {
        _stores = response.body;
        print("in api");

        print(_location.latitude);
        print(_location.longitude);
        if (_stores.length != 0) {
          getAds("fresh9",_location.latitude,_location.longitude);
          getProducts(_stores[0].id);
        } else {
          await getAds("fresh9",_location.latitude,_location.longitude);
          setState(ViewState.idle);
        }
      } else
        setState(ViewState.error);
    }
  }

  getCategories() async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
    _categories = [];
    BaseModel response = await _api.getCategories(token);
    if (response.serverError == null) {
      List<Category> temp = response.body;
      _products.forEach((element) {
        if (_categories
                .indexWhere((category) => category.id == element.category) ==
            -1)
          _categories.add(temp[
              temp.indexWhere((category) => category.id == element.category)]);
      });

      setState(ViewState.idle);
    } else
      setState(ViewState.error);
  }

  navigateToStore(String storeId) async {
    _navigationService.navigateTo(NavigationRouter.categoriesView,
        arguments: storeId);
  }

  setProducts(
    List<Product> recievedProducts,
  ) {
    setState(ViewState.loading);
    _products = [];
    if (recievedProducts != null) {
      recievedProducts.forEach((element) {
        if (_cartService.cartModelDataList.isEmpty) {
          _products.add(element);
        } else {
          int index = _cartService.cartModelDataList
              .indexWhere((cartItem) => element.id == cartItem.id);
          if (index != -1) {
            print("matched");
            element.orderQuantity = element.quantity =
                _cartService.cartModelDataList[index].quantity;
          }
          _products.add(element);
        }
      });

      print("product length");
      print(_products.length);
    }
    notifyListeners();
    setState(ViewState.idle);
  }

  refresh() {
    setProducts(products);
    notifyListeners();
  }
}
