import 'dart:math';

import 'package:flutter/services.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/base_model.dart';
import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:fresh9_rider/core/model/store_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/custom_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderServicesViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Api _api = locator<Api>();
  final AuthService _authService = locator<AuthService>();
  List<StoreModel> _list;
  List banners = [];
  List<String> _todayTimings = [];
  List<String> get todayTimings => _todayTimings;
  int _deliveryAddressIndex = 0;
  int get deliveryAddressIndex => _deliveryAddressIndex;
  List<String> _tomorrowTimings = [
    '09:00 to 12:00',
    '12:00 to 15:00',
    '15:00 to 18:00',
    '18:00 to 21:00'
  ];
  List<String> get tomorrowTimings => _tomorrowTimings;
  String _selectedDay = "Today";
  String get selectedDay => _selectedDay;
  String _selectedTime;
  String get selectedTime => _selectedTime;
  PermissionStatus _permissionGranted;
  final Location _location = Location();
  LocationData _locationData;
  bool serviceEnabled;
  List<String> timingList = [];
  List get storeList => _list;
  bool loader = false;

  UserInfoModel userInfoModel;

  navigateToLogin() async {
    _navigationService.navigateToAndBack(
      NavigationRouter.enterNumberScreen,
    );
  }

  OrderServicesViewModel() {
    userInfoModel = _authService.userInfoModel;
    setUpDefault();
  }

  updateSelectedDay(String newDay) {
    _selectedDay = newDay;
    if (newDay == "Today")
      timingList = _todayTimings;
    else
      timingList = _tomorrowTimings;
    notifyListeners();
  }

  updateSelectedTime(String newTime) {
    _selectedTime = newTime;
    notifyListeners();
  }

  setUpDefault() async {
    setState(ViewState.loading);
    int currentHour = DateTime.now().hour;
    timingList = [];
    print(currentHour);
    if (currentHour >= 1 && currentHour < 10) {
      _todayTimings = [
        '09:00 to 12:00',
        '12:00 to 15:00',
        '15:00 to 18:00',
        '18:00 to 21:00'
      ];
    } else if (currentHour >= 10 && currentHour < 13) {
      _todayTimings = ['12:00 to 15:00', '15:00 to 18:00', '18:00 to 21:00'];
    } else if (currentHour >= 13 && currentHour < 16) {
      _todayTimings = ['15:00 to 18:00', '18:00 to 21:00'];
    } else if (currentHour >= 16 && currentHour < 19) {
      _todayTimings = ['18:00 to 21:00'];
    } else
      _todayTimings = [];

    if (_todayTimings.isEmpty) {
      _selectedDay = "Tomorrow";
      timingList = _tomorrowTimings;
    } else
      timingList = _todayTimings;

    _selectedTime = timingList.first;
    print(_todayTimings);
    print("final timmings");
    determinePosition();
  }

  Future<LocationData> determinePosition() async {
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
//      setState(ViewState.error);
//    }
  }

  getFresh9Store(LocationData _location) async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
//    Position _location = await _determinePosition();

    //31.4405550, 74.294041
    if (_location.latitude != null) {
//      31.320882039180884
      //74.3848831276723
      BaseModel response = await _api.getFresh9(
          token, {"lat": _location.latitude, "lng": _location.longitude});
      if (response.serverError == null) {
        _list = response.body;

        print("in api");

        print(_location.latitude);
        print(_location.longitude);
//        if (_stores.length != 0) {
//          getAds("fresh9");
//          getProducts(_stores[0].id);
//        } else {
//          await getAds("fresh9");
        setState(ViewState.idle);
//        }
      } else
        setState(ViewState.error);
    } else
      setState(ViewState.error);
  }

  navigateToServiceOrder(String title) async {
    _navigationService.navigateToAndBack(NavigationRouter.serviceDetailView,
        arguments: title);
  }

  updateDeliveryAddressIndex(int index, BuildContext context, String title,
      String instructions, String orderType) async {
    _deliveryAddressIndex = index;
    print(_deliveryAddressIndex);
    await getUser(context, title, instructions, orderType);
    notifyListeners();
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

  getUser(BuildContext context, String title, String instructions,
      String orderType) async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = await sharedPreference.get(SharedPreference.token);
    userInfoModel = _authService.userInfoModel;
    LoginModel response = await _api.getProfile(userInfoModel.id, token);
    userInfoModel = response.userInfo;
    setState(ViewState.idle);
    placeOrder(context, title, instructions, orderType);
  }

  placeOrder(BuildContext context, String title, String instructions,
      String orderType) async {
    if (_list.isEmpty) {
      Fluttertoast.showToast(
          msg: "Service is not available at the moment",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
// distance issue
    var _distanceInMeters =

  distanceBetween(
      double.tryParse(_list.first.location['latitude']),
      double.tryParse(_list.first.location['longitude']),
      userInfoModel.addressesList[_deliveryAddressIndex].location[0],
      userInfoModel.addressesList[_deliveryAddressIndex].location[1],
    );

    print(_list.first.deliveryRange);
    print(_distanceInMeters);
    if (title == null || title.isEmpty) {
      Fluttertoast.showToast(
          msg: "Task Title required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
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
    } else if (_distanceInMeters > (_list.first.deliveryRange * 1000)) {
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
                      _navigationService
                          .navigateToAndBack(NavigationRouter.addressView,
                              arguments: true)
                          .then((value) {
                        updateDeliveryAddressIndex(
                            value, context, title, instructions, orderType);
                      });
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
                'Your selected slot & address:',
                style: TextStyle(
                    fontSize: FontSize.xl, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                selectedDay + " : " + selectedTime,
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                "Address : " +
                    (userInfoModel
                                .addressesList[_deliveryAddressIndex].address !=
                            null
                        ? userInfoModel
                            .addressesList[_deliveryAddressIndex].address
                        : userInfoModel
                            .addressesList[_deliveryAddressIndex].houseNumber),
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
//            Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              RaisedButton(
                  color: AppColor.primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    _navigationService
                        .navigateToAndBack(NavigationRouter.addressView,
                            arguments: true)
                        .then((value) {
                      updateDeliveryAddressIndex(
                          value, context, title, instructions, orderType);
                    });
                  },
                  child: Text(
                    'Change Address',
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

        print(userInfoModel.addressesList[_deliveryAddressIndex].address);
        Map body = {
          "deliveryAddress":
              userInfoModel.addressesList[_deliveryAddressIndex].address != null
                  ? userInfoModel.addressesList[_deliveryAddressIndex].address
                  : userInfoModel
                      .addressesList[_deliveryAddressIndex].houseNumber,
          "pickupAddress": _list.first.address,
          "customerName": userInfoModel.fullname,
          "customerMobile": userInfoModel.cell,
          "storeNumber": _list.first.cell,
          "store": _list.first.id,
          "total": 0,
          "products": _items,
          "storeName": _list.first.storeName,
          "storeLocation": _list.first.location,
          "userLocation":
              userInfoModel.addressesList[_deliveryAddressIndex].location,
          "addressDetail":
              userInfoModel.addressesList[_deliveryAddressIndex].houseNumber,
          "addressInstructions":
              userInfoModel.addressesList[_deliveryAddressIndex].instructions,
          "addressType":
              userInfoModel.addressesList[_deliveryAddressIndex].type,
          "userId": userInfoModel.id,
          "selectedTime": selectedTime,
          "day": selectedDay,
          "instructions": instructions,
          "title": title,
          "orderType": "Service - " + orderType
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

          print(response['success']);
          if (response['success']) {
            print(response['message']['order']['_id']);

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
