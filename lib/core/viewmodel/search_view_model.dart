import 'package:flutter/services.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/base_model.dart';
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

class SearchViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  UserInfoModel get userInfoModel => _authService.userInfoModel;
  final AuthService _authService = locator<AuthService>();

  int get count => _cartService.cartModelDataList.length;

  final CartService _cartService = locator<CartService>();
  final Api _api = locator<Api>();

  PermissionStatus _permissionGranted;
  final Location _location = Location();
  LocationData _locationData;
  TextEditingController searchText = new TextEditingController();

  List<StoreModel> _stores = [];

  List<StoreModel> get stores => _stores;

  List<Product> _products = [];

  String _storeId;

  List<Product> get products => _products;

  List<Product> _productsList = [];

  int _savedIndex;

  get savedIndex => _savedIndex;

  Product _savedCartModel;

  Product get savedCartModel => _savedCartModel;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_cartService, _authService];

  getProducts(List<Product> productsList) {
    print(productsList.length);
    if (productsList == null || productsList.isEmpty)
      _determinePosition();
    else
      _productsList = productsList;
    notifyListeners();
  }

  navigateToLogin() async {
    _navigationService.navigateToAndBack(
      NavigationRouter.enterNumberScreen,
    );
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
      await sharedPreference.setString(
          SharedPreference.storeId, cartModelData.storeId);
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

  searchProductsAndShops(String val, String type) async {
    print("type");
    print(type);
    List<StoreModel> allStores = [];

    if (_productsList.isNotEmpty) {
      _products = [];
      _productsList.forEach((element) {
        if (element.name.toLowerCase().contains(val.toLowerCase())){
          _products.add(element);}
        print(element.keyWords);
        element.keyWords.forEach((item) {
          if (item.toLowerCase().contains(val.toLowerCase())) {
            print("keyword");
            print(item);
            print(_products.length);
            print(_products.contains(element));
            if (!_products.contains(element)) _products.add(element);
          }
        });
      });
//      _products = _productsList
//          .where((element) =>
//              element.name.toLowerCase().contains(val.toLowerCase()))
//          .toList();

      notifyListeners();
    } else {
      BaseModel apiResponse =
          await _api.searchItems(val, _locationData.latitude, _locationData.longitude);
      if (apiResponse.serverError == null) {
        Map response = apiResponse.body;

        _stores = [];
        _products = [];
        if (response["stores"] != null) {
          response["stores"].forEach((value) {
            StoreModel temp = StoreModel.fromJson(value);
            allStores.add(temp);
            if (type != null &&
                temp.businessType != "fresh9" &&
                temp.storeName.toLowerCase().contains(val)) {
              if (type == temp.businessType) _stores.add(temp);
            } else if (temp.storeName.toLowerCase().contains(val) &&
                temp.businessType != "fresh9") _stores.add(temp);
          });
//        _stores = List<StoreModel>.from(response["stores"].map(
//          (x) => StoreModel.fromJson(x),
//        ));
//        print(_stores.length);

          print("black");
          print(response["products"]);
          response["products"].forEach((value) {
            Product temp = Product.fromJson(value);
            allStores.forEach((element) {
              if (element.id == temp.storeId) _products.add(temp);
            });
          });

          print(_products.length);
        }
        notifyListeners();
      } else
        setState(ViewState.error);
    }
//    }
  }

  Future<void> _determinePosition() async {
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
//          getFresh9Store(_locationData,context);
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

    // Test if location services are enabled.
//    try {
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
//        _location = result.location;
////        getFresh9Store(_location);
//      });
//    } catch (e) {
//      print(e);
//      setState(ViewState.idle);
//    }
//    setState(ViewState.idle);
  }

  navigateToStore(StoreModel store) {
    if (store.businessType == "fresh9")
      _navigationService.navigateToAndBack(NavigationRouter.fresh9View);
    else
      _navigationService.navigateToAndBack(NavigationRouter.storeCategories,
          arguments: store.id);
  }

  navigateToProductDetail(Product product) {
    return _navigationService.navigateToAndBack(NavigationRouter.itemDetailView,
        arguments: {'product': product, 'products': products});
  }

  refresh() {
//    getProducts(_storeId);
    notifyListeners();
  }
}
