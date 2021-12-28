import 'dart:async';
import 'package:observable_ish/observable_ish.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:stacked/stacked.dart';

class CartService with ReactiveServiceMixin {
  // ignore: close_sinks
  StreamController<List<Product>> _cartController =
      StreamController<List<Product>>();

  Stream<List<Product>> get cartController => _cartController.stream;

  RxList<Product> _cartModelDataList = RxList<Product>();

  CartService() {
    listenToReactiveValues([_cartModelDataList]);
  }

  List<Product> get cartModelDataList => _cartModelDataList;

  Future<int> addCartToStream(Product cartModelData) async {
    _cartModelDataList.add(cartModelData);
    _cartController.sink.add(_cartModelDataList);
    print("added index ${_cartModelDataList.length - 1}");
    notifyListeners();
    return cartModelDataList.length - 1;
  }

  updateCartOfStream(Product cartModelData, int index) async {
    _cartModelDataList.removeAt(index);
    _cartModelDataList.insert(index, cartModelData);
    _cartController.sink.add(_cartModelDataList);
    print("updated index $index");
    notifyListeners();
  }

  Future<int> addCartQuantity(int index) async {
    print(_cartModelDataList.length);
    _cartModelDataList[index].quantity++;
    _cartModelDataList[index].inventory--;
    _cartController.sink.add(_cartModelDataList);
    notifyListeners();
    return _cartModelDataList[index].quantity;
  }

  Future<int> decrementCartQuantity(int index) async {
    _cartModelDataList[index].quantity--;
    _cartModelDataList[index].inventory++;
    _cartController.sink.add(_cartModelDataList);
    notifyListeners();
    return _cartModelDataList[index].quantity;
  }

  removeCartOfStream(int index) async {
    _cartModelDataList.removeAt(index);
    print("removed index $index");
    _cartController.sink.add(_cartModelDataList);
    print(_cartModelDataList.length);
    notifyListeners();
  }

  clearCart() {
    _cartModelDataList.clear();
    notifyListeners();
  }
}
