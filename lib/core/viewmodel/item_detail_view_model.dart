import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/reactive_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class ProductDetailViewModel extends ReactiveBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final CartService _cartService = locator<CartService>();
  final AuthService _authService = locator<AuthService>();

  int _savedIndex;

  get savedIndex => _savedIndex;

  Product _savedCartModel;

  Product get savedCartModel => _savedCartModel;

  Product get currentProduct => _product;

  Product _product;

  List<Product> get products => _products;

  List<Product> _products = [];

  List<Product> _myProducts = [];

  UserInfoModel get userInfoModel => _authService.userInfoModel;

  navigateToLogin() async {
    _navigationService.navigateToAndBack(
      NavigationRouter.enterNumberScreen,
    );
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_cartService, _authService];

//  onTapAddItem(Product cartModelData, BuildContext context,) async {
//    List<Product> _cartModelList =
//    Provider.of<List<Product>>(context, listen: false);
//    bool itemFound = false;
//    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
//    String savedStoreId = sharedPreference.get(SharedPreference.storeId);
//
//
//    if(cartModelData.storeId!=savedStoreId) {
//      await sharedPreference.setString(SharedPreference.storeId,cartModelData.storeId);
//      _cartService.clearCart();
//    }
//
//    for (int index = 0; index < _cartModelList.length; index++)
//      if (cartModelData.id == _cartModelList[index].id) {
//        itemFound = true;
//        _savedIndex = index;
//        _cartService.addCartQuantity(index);
//        _savedCartModel = _cartModelList[index];
//      }
//    if (!itemFound) {
//      _savedIndex = await _cartService.addCartToStream(cartModelData);
//      _savedCartModel = cartModelData;
//    }
//    await _navigationService.navigateToAndBack(NavigationRouter.cartView);
//    notifyListeners();
//  }

  setProduct(Product product) {
    setState(ViewState.loading);
    _product = product;

    int index = _cartService.cartModelDataList
        .indexWhere((cartItem) => _product.id == cartItem.id);
    if (index != -1) {
      print("matched");
      _product.orderQuantity = _cartService.cartModelDataList[index].quantity;
    }
    notifyListeners();

    setState(ViewState.idle);
  }

  setProducts(
    List<Product> recievedProducts,
  ) {
    setState(ViewState.loading);
    _products = [];
    List<Product> _temp = [];
    if (recievedProducts != null) {
      recievedProducts.forEach((element) {
        if (element.subCategory == _product.subCategory &&
            element.id != _product.id) _temp.add(element);
      });
      _temp.forEach((element) {
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
      _myProducts = _products;
      _myProducts.add(_product);

      print("product length");
      print(_products.length);
    }
    setState(ViewState.idle);
  }

  onRemoveItem(Product cartModelData, BuildContext context) async {
    List<Product> _cartModelList =
        Provider.of<List<Product>>(context, listen: false);
    bool itemFound = false;
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String savedStoreId = sharedPreference.get(SharedPreference.storeId);

    int index =
        _products.indexWhere((element) => element.id == cartModelData.id);
//    print(products[index].orderQuantity);
//    print(cartModelData.id == _products[index].id);
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

    if (cartModelData.storeId != savedStoreId) {
      await sharedPreference.setString(
          SharedPreference.storeId, cartModelData.storeId);
      _cartService.clearCart();
    }

    if (cartModelData.id == _product.id)
      ++_product.orderQuantity;
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

  refresh() {

    setProduct(_product);
    setProducts(products);
//    getProducts(_storeId);
    notifyListeners();
  }
}
