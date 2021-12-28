import 'dart:math';

import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/base_model.dart';
import 'package:fresh9_rider/core/model/login_model.dart';
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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrderViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Api _api = locator<Api>();
  final AuthService _authService = locator<AuthService>();
  final CartService _cartService = locator<CartService>();
  UserInfoModel userInfoModel;
  StoreModel _orderStore;
  StoreModel get orderStore => _orderStore;
  List<String> _timings = [];
  List<String> _todayTimings = [];
  List<String> tomorrowTimings = [];
  String selectedTime;
  List<String> get timings => _timings;
  String currentlySelected = "Today";
  int _deliveryAddressIndex = 0;
  int get deliveryAddressIndex => _deliveryAddressIndex;
  bool loader = false;

  PlaceOrderViewModel() {
    setState(ViewState.loading);
//    userInfoModel = _authService.userInfoModel;
    getUser();
  }

  updateDay(String day) {
    print("in update day");
    if (day == "Today") {
      _timings = _todayTimings;
      selectedTime = _timings.isEmpty ? null : _timings.first;
    } else {
      _timings = tomorrowTimings;
      selectedTime = tomorrowTimings.isEmpty ? null : tomorrowTimings.first;
    }
    notifyListeners();
  }

  updateDeliveryAddressIndex(int index) {
    _deliveryAddressIndex = index;
    print(_deliveryAddressIndex);
    getUser();
    notifyListeners();
  }

  getUser() async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = await sharedPreference.get(SharedPreference.token);
    userInfoModel = _authService.userInfoModel;
    LoginModel response = await _api.getProfile(userInfoModel.id, token);
    userInfoModel = response.userInfo;
    getStore();
  }

  getStore() async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String savedStoreId = sharedPreference.get(SharedPreference.storeId);
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
    _orderStore = await _api.getSingleStore(token, savedStoreId);
    if (_orderStore.serverError == null) {
      print(_orderStore.timing);
      TimeOfDay _startTime = TimeOfDay(
          hour: int.parse(_orderStore.timing['open'] == ""
              ? "09"
              : _orderStore.timing['open'].split(":")[0]),
          minute: int.parse(_orderStore.timing['open'] == ""
              ? "00"
              : _orderStore.timing['open'].split(":")[1]));
      TimeOfDay _endTime = TimeOfDay(
          hour: int.parse(_orderStore.timing['close'] == ""
              ? "21"
              : _orderStore.timing['close'].split(":")[0]),
          minute: int.parse(_orderStore.timing['close'] == ""
              ? "00"
              : _orderStore.timing['close'].split(":")[1]));

      print(_startTime.hour);
      print(_endTime.hour);

      tomorrowTimings = [];
      _timings = [];

      for (int temp = _startTime.hour; temp < _endTime.hour; temp++) {
//        print(_startTime.hour.toString());
//        print(temp.toString());
        DateTime currentTime = DateTime.now();
        print("temp");
        print(temp);
        print(currentTime.hour);
        if (temp >= currentTime.hour) {
          _timings.add(temp.toString() +
              ":" +
              _startTime.minute.toString() +
              "0" +
              " to " +
              (temp + 1).toString() +
              ":" +
              _startTime.minute.toString() +
              "0");
        }
        tomorrowTimings.add(temp.toString() +
            ":" +
            _startTime.minute.toString() +
            "0" +
            " to " +
            (temp + 1).toString() +
            ":" +
            _startTime.minute.toString() +
            "0");
      }

      print("_timings");
      print(_timings);
      if (_timings.length < 2) {
        currentlySelected = "Tomorrow";
        _timings = tomorrowTimings;
        selectedTime = tomorrowTimings.first;
      } else {
        _todayTimings = _timings;
        selectedTime = _timings[1];
      }

      print(_timings);
      setState(ViewState.idle);
    } else
      setState(ViewState.error);
  }

  double distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    var earthRadius = 6378137.0;
    var dLat = _toRadians(endLatitude - startLatitude);
    var dLon = _toRadians(endLongitude - startLongitude);

    var a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) *
            cos(_toRadians(startLatitude)) *
            cos(_toRadians(endLatitude));
    var c = 2 * asin(sqrt(a));

    return earthRadius * c;
  }

  static _toRadians(double degree) {
    return degree * pi / 180;
  }

  submitOrder(String total, BuildContext context, String day,
      String instructions) async {
    print(_orderStore.location);
    print(userInfoModel.addressesList[0].location);

    //distance issue

    var _distanceInMeters = distanceBetween(
      double.tryParse(_orderStore.location['latitude']),
      double.tryParse(_orderStore.location['longitude']),
      userInfoModel.addressesList[_deliveryAddressIndex].location[0],
      userInfoModel.addressesList[_deliveryAddressIndex].location[1],
    );

    print(_orderStore.deliveryRange);
    print(_distanceInMeters);
    if (_distanceInMeters > (_orderStore.deliveryRange * 1000)) {
      print("not in range");
      Dialog errorDialog = Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Text(
                  'This store doesn\'t deliver to this address',
                  style: TextStyle(
                      fontSize: FontSize.xl, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Kindly change your delivery information',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RaisedButton(
                    color: AppColor.primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Okay!',
                      style: TextStyle(color: Colors.white),
                    )),
              ])
            ],
          ),
        ),
      );
      await showDialog(
          context: context, builder: (BuildContext context) => errorDialog);
      return;
    } else {
      SharedPreferences sharedPreference =
          await SharedPreferences.getInstance();
      if (userInfoModel.addressesList.isEmpty) {
        Fluttertoast.showToast(
            msg: "No address added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
      if (selectedTime == "" || selectedTime == null) {
        Fluttertoast.showToast(
            msg: "Kindly choose delivery time",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }

      Dialog errorDialog = Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Text(
                  'Your delivery slot:',
                  style: TextStyle(
                      fontSize: FontSize.xl, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  currentlySelected + " : " + selectedTime,
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                RaisedButton(
                    color: AppColor.primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'Change',
                      style: TextStyle(color: Colors.white),
                    )),
                RaisedButton(
                    color: AppColor.primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Confirm',
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
          String token = sharedPreference.getString(
            SharedPreference.token,
          );

          List _items = [];
          _cartService.cartModelDataList.forEach((element) {
            _items.add({
              "id": element.id,
              "name": element.name,
              "quantity": element.quantity,
              "discountedPrice": element.discountedPrice,
              "retailPrice": element.retailPrice,
              "imageUrl": element.imageUrl,
              "purchasePrice": element.purchasePrice,
              "unit": element.increment.toString() + element.unit
            });
          });

          print(userInfoModel.addressesList[_deliveryAddressIndex].address);
          Map body = {
            "wallet": (int.tryParse(total) -
                        userInfoModel.wallet -
                        userInfoModel.voucher) <
                    0
                ? (int.tryParse(total) - userInfoModel.voucher)
                : userInfoModel.wallet,
            "voucher": userInfoModel.voucher,
            "deliveryAddress":
                userInfoModel.addressesList[_deliveryAddressIndex].address !=
                        null
                    ? userInfoModel.addressesList[_deliveryAddressIndex].address
                    : userInfoModel
                        .addressesList[_deliveryAddressIndex].houseNumber,
            "addressDetail":
                userInfoModel.addressesList[_deliveryAddressIndex].houseNumber,
            "addressInstructions":
                userInfoModel.addressesList[_deliveryAddressIndex].instructions,
            "addressType":
                userInfoModel.addressesList[_deliveryAddressIndex].type,
            "pickupAddress": _orderStore.address,
            "customerName": userInfoModel.fullname,
            "customerMobile": userInfoModel.cell,
            "storeNumber": _orderStore.cell == null || _orderStore.cell == ""
                ? "0000"
                : _orderStore.cell,
            "store": _orderStore.id,
            "total": (int.tryParse(total) -
                        userInfoModel.wallet -
                        userInfoModel.voucher) <
                    0
                ? 0
                : (int.tryParse(total) -
                    userInfoModel.wallet -
                    userInfoModel.voucher),
            "products": _items,
            "storeName": _orderStore.storeName,
            "storeLocation": _orderStore.location,
            "userLocation":
                userInfoModel.addressesList[_deliveryAddressIndex].location,
            "userId": userInfoModel.id,
            "selectedTime": selectedTime,
            "day": currentlySelected,
            "instructions": instructions
          };

          print(body);
          print(token);
          loader = true;
          notifyListeners();
          BaseModel apiResponse = await _api.order(body, token);
          loader = false;
          notifyListeners();
          if (apiResponse.serverError == null) {
            Map response = apiResponse.body;
            BaseModel sendNotification =
                await _api.sendNotification(token, _orderStore.id);
            print(response['success']);
            if (response['success']) {
              print(response['message']['order']['_id']);
              _cartService.clearCart();

              _navigationService.navigateToAndClearAll(
                  NavigationRouter.orderPlacedView,
                  arguments: response['message']['order']['_id']);
            } else
              Fluttertoast.showToast(
                  msg: "Unable to place order kindly try again",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
          } else
            setState(ViewState.error);
        }
      });
    }
  }
}
