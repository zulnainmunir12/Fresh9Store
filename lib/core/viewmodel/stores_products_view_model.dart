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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class StoreProductsViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Api _api = locator<Api>();
  final AuthService _authService = locator<AuthService>();
  final CartService _cartService = locator<CartService>();
  List banners = [];


  StoreProductsViewModel() {
    getSubCategories();
  }

  List<Category> _subCategories = [];

  List<Category> get subCategories => _subCategories;
  bool serviceEnabled;
  UserInfoModel get userInfoModel => _authService.userInfoModel;

  navigateToLogin() async {
    _navigationService.navigateToAndBack(
      NavigationRouter.enterNumberScreen,
    );
  }

  List<Category> _categories = [];

  String _storeId;

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

  enableSubCategory(String id) {
    int index = _categories.indexWhere((element) => element.id == id);
    _categories[index].showSubCategory = !_categories[index].showSubCategory;
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
      sharedPreference.setString(
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

  getSpecificSubCategories(String category) {
    List<Category> temp = [];
    products.forEach((element) {
      subCategories.forEach((subCategory) {
        print(subCategory.id);
        print(category);
        if (element.subCategory == subCategory.id &&
            subCategory.category == category &&
            !temp.contains(subCategory)) temp.add(subCategory);
      });
    });
    return temp;
  }

  getSubCategories() async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
    _subCategories = [];
    BaseModel response = await _api.getSubCategories(token);
    if (response.serverError == null) {
      _subCategories = response.body;
      print(_subCategories);
    } else
      setState(ViewState.error);
  }

  getProducts(String storeId) async {
    setState(ViewState.loading);
    _storeId = storeId;
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
//    _products = await _api.allProducts(token, storeId);
//    _products.forEach((element) {
//      if (element.featuredProduct) _featuredProducts.add(element);
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
