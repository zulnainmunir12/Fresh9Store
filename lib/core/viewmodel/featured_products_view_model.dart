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
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class FeaturedProductsViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Api _api = locator<Api>();
  final AuthService _authService = locator<AuthService>();
  final CartService _cartService = locator<CartService>();
  List banners = [];
  PermissionStatus _permissionGranted;
  final Location _location = Location();
  LocationData _locationData;
  bool serviceEnabled;
  UserInfoModel get userInfoModel => _authService.userInfoModel;
  int get count => _cartService.cartModelDataList.length;

  navigateToLogin() async {
    _navigationService.navigateToAndBack(
      NavigationRouter.enterNumberScreen,
    );
  }

  String _storeId;

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
    bool addProduct = false;

    if (cartModelData.storeId != savedStoreId &&
        _cartService.cartModelDataList.isNotEmpty) {
      Dialog errorDialog = Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Text(
                  'Remove your previous products?',
                  style: TextStyle(
                      fontSize: FontSize.xl, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'You still have products from another shop. Shall we start over with a fresh cart?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                RaisedButton(
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    )),
                RaisedButton(
                    color: AppColor.primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Remove products',
                      style: TextStyle(color: Colors.white),
                    )),
              ])
            ],
          ),
        ),
      );
      await showDialog(
          context: context,
          builder: (BuildContext context) => errorDialog).then((value) async {
        if (value == true) {
          _cartService.clearCart();
          await sharedPreference.setString(
              SharedPreference.storeId, cartModelData.storeId);
          addProduct = true;
        }
      });
    } else {
      addProduct = true;
    }

    if (addProduct) {
      int index =
          _products.indexWhere((element) => element.id == cartModelData.id);
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

  getProducts(String storeId) async {
    setState(ViewState.loading);
    _storeId = storeId;
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
//    _products = await _api.allProducts(token, storeId);
//    _products.forEach((element) {
//      if(element.featuredProduct)
//        _featuredProducts.add(element);
//    });

    BaseModel response = await _api.allProducts(token, storeId);
    if (response.serverError == null) {
      List<Product> temp = response.body;
      _products = [];
      _featuredProducts = [];
      temp.forEach((element) {
        if (_cartService.cartModelDataList.isEmpty) {
          if (element.featuredProduct) _featuredProducts.add(element);
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
          if (element.featuredProduct) _featuredProducts.add(element);
        }
      });
      getCategories();
    }
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
    if (response.serverError == null)
      banners = response.body;
    else
      setState(ViewState.error);
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
      }
    } else
      setState(ViewState.error);
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

  refresh() {
    getProducts(_storeId);
    notifyListeners();
  }
}
