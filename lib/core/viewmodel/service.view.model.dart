import 'package:flutter/services.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/base_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/custom_base_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesViewModel extends CustomBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Api _api = locator<Api>();
  final AuthService _authService = locator<AuthService>();
  List _services;
  List banners = [];

  PermissionStatus _permissionGranted;
  final Location _location = Location();
  LocationData _locationData;
  bool serviceEnabled;

  List get services => _services;

  UserInfoModel get userInfoModel => _authService.userInfoModel;

  navigateToLogin() async {
    _navigationService.navigateToAndBack(
      NavigationRouter.enterNumberScreen,
    );
  }

  ServicesViewModel() {
    determinePosition();
  }

  Future<void> determinePosition() async {
    setState(ViewState.loading);
    // Test if location services are enabled.



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
          getServices(_locationData,);
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
//        getServices(_location);
//      });
//    } catch (e) {
//      print(e);
//      setState(ViewState.idle);
//    }
  }

//  Future<Position> _determinePosition() async {
//    // Test if location services are enabled.
//    serviceEnabled = await Geolocator.isLocationServiceEnabled();
//    if (!serviceEnabled) {
//      // Location services are not enabled don't continue
//      // accessing the position and request users of the
//      // App to enable the location services.
//
//      return Future.error('Location services are disabled.');
//    }
//
//    permission = await Geolocator.checkPermission();
//    if (permission == LocationPermission.denied) {
//      permission = await Geolocator.requestPermission();
//      if (permission == LocationPermission.denied) {
//        // Permissions are denied, next time you could try
//        // requesting permissions again (this is also where
//        // Android's shouldShowRequestPermissionRationale
//        // returned true. According to Android guidelines
//        // your App should show an explanatory UI now.
//
//        return Future.error('Location permissions are denied');
//      }
//    }
//
//    if (permission == LocationPermission.deniedForever) {
//      // Permissions are denied forever, handle appropriately.
//      return Future.error(
//          'Location permissions are permanently denied, we cannot request permissions.');
//    }
//
//    // When we reach here, permissions are granted and we can
//    // continue accessing the position of the device.
//    return await Geolocator.getLastKnownPosition();
//  }

  getServices(LocationData _location) async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
//    Position _location = await _determinePosition();

    //      31.320882039180884
    //74.3848831276723
    if (_location.latitude != null) {
      BaseModel response = await _api.getServices(
          token, {"lat": _location.latitude, "lng": _location.longitude});
      if (response.serverError == null) {
        _services = response.body;
        print("in api");

        print(_location.latitude);
        print(_location.longitude);
        if (_services.length != 0) {
          await getAds("services",_location.latitude,_location.longitude);
//        getProducts(_stores[0].id);
        } else {
          await getAds("services",_location.latitude,_location.longitude);
          setState(ViewState.idle);
        }
      } else
        setState(ViewState.error);
    }
//    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
//    String token = sharedPreference.getString(
//      SharedPreference.token,
//    );
//    _stores = await _api.getRestuarants(token);
//    setState(ViewState.idle);
  }
//  getServices() async {
//    setState(ViewState.loading);
//    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
//    String token = sharedPreference.getString(
//      SharedPreference.token,
//    );
//    _services = await _api.getServices(token);
//    setState(ViewState.idle);
//  }

  getAds(String type,double lat, double lng) async {
    setState(ViewState.loading);
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = sharedPreference.getString(
      SharedPreference.token,
    );
    banners = [];
    BaseModel response = await _api.getBanners(token, type,lat,lng);
    if (response.serverError == null) {
      banners = response.body;
      print(banners);
      setState(ViewState.idle);
    } else
      setState(ViewState.error);
  }

  navigateToServiceOrder(String title) async {
    _navigationService.navigateToAndBack(NavigationRouter.serviceDetailView,
        arguments: title);
  }
}
