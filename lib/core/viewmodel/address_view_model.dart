import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/custom_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/base.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:geocoder/geocoder.dart' as geoCoder;

class AddressViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  RxValue<UserInfoModel> _userInfoModel = RxValue<UserInfoModel>();
  bool loader = false;
  Geocoding geocoding = Geocoder.local;

//  GeoCode geoCode = GeoCode(apiKey: "AIzaSyCT4helbtUvku9_Iqr5j7gnIWLgSQlQonM");
  UserInfoModel _userInfo;
  UserInfoModel get userInfoModel => _userInfo;
  final Api _api = locator<Api>();


  int chosenAddress = 0;

  AddressViewModel() {
    getAddresses();
  }

  updateChosen(int index){
    chosenAddress = index;
    _navigationService
        .goBackWithData(chosenAddress);
    notifyListeners();
  }

  updateAddresses(int index) async {
    setState(ViewState.loading);
    _userInfo.addresses.removeAt(index);
    print(_userInfo.addresses.length);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = await sharedPreference.get(SharedPreference.token);
    LoginModel response = await _api
        .updateProfile({'addresses': _userInfo.addresses}, _userInfo.id, token);
    setState(ViewState.idle);
  }

  decodeAddress(List location) async {}

  update(String name, String email) async {
    if (email.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email))
      Fluttertoast.showToast(
          msg: "Kindly enter valid email address.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    else {
      print(_userInfo.id);
      loader = true;
      notifyListeners();
      SharedPreferences sharedPreference =
          await SharedPreferences.getInstance();
      String token = await sharedPreference.get(SharedPreference.token);
      LoginModel response = await _api.updateProfile(
          {"fullname": name, "email": email}, _userInfo.id, token);
      _userInfo = response.userInfo;

      loader = false;
      notifyListeners();
    }
  }

  getAddresses() async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = await sharedPreference.get(SharedPreference.token);
    _userInfo = _authService.userInfoModel;
    LoginModel response = await _api.getProfile(_userInfo.id, token);
    _userInfo = response.userInfo;

    if (_userInfo.addresses.isNotEmpty) {
      _userInfo.addresses.forEach((element) async {
        final coordinates =
            new geoCoder.Coordinates(element['loc'][0], element['loc'][1]);
        List<geoCoder.Address> addresses = await geoCoder.Geocoder.google(

            "AIzaSyBbl3ihjNj49FUqm2xRbl82EOmi8kHU99c"
                )
            .findAddressesFromCoordinates(coordinates);
        geoCoder.Address first = addresses.first;
        int index =  _userInfo.addresses.indexWhere((address) => address==element);
        _userInfo.addresses[index]['address'] = first.addressLine;
      });
    }
//      print(element['loc']);
//      Address address = await geoCode.reverseGeocoding(
//        latitude: _userInfo.addresses[0]['loc'][0],
//        longitude: _userInfo.addresses[0]['loc'][1],
//      );
//      var results = await geocoding.findAddressesFromCoordinates(
//          new Coordinates(
//            _userInfo.addresses[0]['loc'][0],
//            _userInfo.addresses[0]['loc'][1],
//          ));
//
//      print(results[0].addressLine);
//      //      print(address.city);
////      int index = _userInfo.addresses
////          .indexWhere((entry) => entry['loc'] == element['loc']);
//      _userInfo.addresses[0]['address'] = results[0].addressLine;
////        results.[0]streetAddress + ", " + results.city;
////    });
//    }
    setState(ViewState.idle);
  }
}
