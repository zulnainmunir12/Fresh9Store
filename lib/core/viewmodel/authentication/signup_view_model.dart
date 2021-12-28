import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/custom_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';

import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  PermissionStatus _permissionGranted;
  bool _currentPasswordVisibility = false;
  final Location _location = Location();
  LocationData _locationData;

  bool get currentPasswordVisibility => _currentPasswordVisibility;

  changeCurrentPasswordVisibility() {
    _currentPasswordVisibility = !_currentPasswordVisibility;
    notifyListeners();
  }

  SignupViewModel() {
    determinePosition();
  }

  Future<void> determinePosition() async {
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
//          getFresh9Store(_locationData);
        } on PlatformException catch (err) {
          setState(ViewState.error);
        }
      } else {
        setState(ViewState.error);
      }
    } catch (e) {
      setState(ViewState.error);
    }
    //////*********************

    // Test if location services are enabled.
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
//        _location = result.location;
////        getFresh9Store(_location);
//      });
//      setState(ViewState.idle);
//    } catch (e) {
//      print(e);
//      setState(ViewState.idle);
//    }
  }

  bool _enableFingerPrint = false;

  get enableFingerPrint => _enableFingerPrint;

  setFingerPrint(bool value) {
    _enableFingerPrint = value;
    notifyListeners();
  }

  signup(
      String name,
      String cell,
      String email,
      String houseNumber,
      String instructions,
      String type,
      String address,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    Map<String, dynamic> data = {
      "cell": cell,
      'fullname': name,
      'email': email,
      'role': 'user',
      'password': DateTime.now().microsecondsSinceEpoch.toString(),
      'addresses': [
        {
          "type": type,
          "houseNumber": houseNumber,
          "instructions": instructions,
          "address": address,
          "loc":
              _location == null ? [] : [_locationData.latitude, _locationData.longitude]
        }
      ]
    };
    setState(ViewState.loading);
    print("before sign uo");
    var loginModelData = await _authService.signUp(data);
    if (loginModelData.serverError == null) {
      if (loginModelData.success) {
        print("Successfully Logged In");
        await saveToken(loginModelData.token);
//        landingScreen
        _navigationService.navigateToAndClearAll(NavigationRouter.appServices);
      } else {
        setState(ViewState.idle);
//        _navigationService.navigateTo(NavigationRouter.signUpScreen,arguments: phone);
        final snackBar = SnackBar(
            content: Text("Unable to signup at the moment. Try Again"));
        scaffoldKey.currentState.showSnackBar(snackBar);
      }
    } else {
      final snackBar =
          SnackBar(content: Text("Unable to signup at the moment. Try Again"));
      scaffoldKey.currentState.showSnackBar(snackBar);
      setServerError(loginModelData.serverError);
      setState(ViewState.error);
    }
  }

  saveToken(String token) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.remove(SharedPreference.token);
    await sharedPreference.setString(
      SharedPreference.token,
      token,
    );
    print("Saved token - $token");
  }

  onTapLogin() {
    _navigationService.navigateTo(NavigationRouter.enterNumberScreen);
  }

  onTapForgotPassword() {
//    _navigationService.navigateToAndBack(NavigationRouter.);
  }
}
