import 'package:flutter/services.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
//import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AppServices extends StatefulWidget {
  _AppServices createState() => _AppServices();
}

class _AppServices extends State<AppServices> {
  final Api _api = locator<Api>();
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PermissionStatus _permissionGranted;
  final Location _location = Location();
  LocationData _locationData;
//  bool serviceEnabled;
  String message = '';
  bool _loader = true;
  bool _locationIssue = false;
  String _token;

  void setToken(String token) {
    print('FCM Token: $token');
    setState(() {
      _token = token;
    });
  }

  startUpProcess() {
    FirebaseMessaging.instance.getToken().then((token) {
      setToken(token);
      _determinePosition();
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
//        Navigator.pushNamed(context, '/message',
//            arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  @override
  void initState() {
    super.initState();
    startUpProcess();
//
  }

  Future<LocationData> _determinePosition() async {
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
//          setState(ViewState.idle);
          print(_locationResult);

          print("got location");

//          var connectivityResult = await (Connectivity().checkConnectivity());
          if (_locationResult != null) {
            print("test");

            try {
              _api.addLocation({
                'pushToken': _token,
                'loc': [_locationResult.latitude, _locationResult.longitude]
              });

              setState(() {
                _loader = false;
              });
//          } else {
            } catch (e) {
              setState(() {
                _loader = false;
              });
            }
          } else
            setState(() {
              _loader = false;
              _locationIssue = true;
            });

          return _locationResult != null ? _locationResult : null;
        } on PlatformException catch (err) {
//          setState(ViewState.error);
          _scaffoldKey.currentState.showSnackBar(new SnackBar(
              backgroundColor: AppColor.primaryColor,
              content: Text(err.toString())));
        }
      } else {
//        setState(ViewState.error);
        //      _scaffoldKey.currentState.showSnackBar(new SnackBar(
//          backgroundColor: AppColor.primaryColor, content: Text(e.toString())));
      }
    } catch (e) {
//      setState(ViewState.error);

      setState(() {
        _loader = false;
      });
      print(e);
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          backgroundColor: AppColor.primaryColor, content: Text(e.toString())));
    }
    ///////////**************

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
//          setState(() {
//            message = 'Location permission is required';
//          });
//          return Future.error('Location permissions are denied');
//        }
//      }
//      print("check permission before denied forever");
//      if (permission == LocationPermission.deniedForever) {
//        // Permissions are denied forever, handle appropriately.
//        setState(() {
//          _loader = false;
//          message = 'Location permissions are permanently denied, '
//              'we cannot request permissions. Kindly go to settings and '
//              'enable location permission';
//        });
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
////        geo.Geolocation.enableLocationServices().then((result) {
////          // Request location
////        }).catchError((e) {
////          _loader=false;
////          // Location Services Enablind Cancelled
////        });
//
//        Stream<geo.LocationResult> stream = geo.Geolocation.currentLocation(
//            accuracy: geo.LocationAccuracy.best);
//        stream.listen((result) async {
//          print(result.locations);
//
//          print("got location");
//
////          var connectivityResult = await (Connectivity().checkConnectivity());
//          if (result.locations != null) {
//            print("test");
//            print(result);
//            try {
//              _api.addLocation({
//                'pushToken': _token,
//                'loc': [result.location.latitude, result.location.longitude]
//              });
//
//              setState(() {
//                _loader = false;
//              });
////          } else {
//            } catch (e) {
//              setState(() {
//                _loader = false;
//              });
//            }
//          } else
//            setState(() {
//              _loader = false;
//              _locationIssue = true;
//            });
//
//          return result.locations != null ? result.location : null;
//        });
//      }
//    } catch (e) {
//      setState(() {
//        _loader = false;
//      });
//      print(e);
//      _scaffoldKey.currentState.showSnackBar(new SnackBar(
//          backgroundColor: AppColor.primaryColor, content: Text(e.toString())));
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _loader
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : _locationIssue
              ? Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColor.secondaryColor,
                          size: 100,
                        ),
                        RaisedButton(
                          color: AppColor.primaryColor,
                          child: Text(
                            "Enable Location",
                            style: TextStyle(
                                color: Colors.white, fontSize: FontSize.xl),
                          ),
                          onPressed: () async {
                            final PermissionStatus permissionGrantedResult =
                                await _location.hasPermission();

                            _permissionGranted = permissionGrantedResult;

                            if (_permissionGranted !=
                                PermissionStatus.granted) {
                              final PermissionStatus permissionRequestedResult =
                                  await _location.requestPermission();

                              _permissionGranted = permissionRequestedResult;
                            }

                            if (_permissionGranted ==
                                PermissionStatus.granted) {
                              setState(() {
                                _loader = true;
                                _locationIssue = false;
                              });

                              startUpProcess();
                            }

//                            geo.Geolocation.enableLocationServices()
//                                .then((result) {
//                              // Request location
//
//
//                              startUpProcess();
//                            }).catchError((e) {
//                              // Location Services Enablind Cancelled
//                            });
                          },
                        )
                      ],
                    ),
                  ),
                )
              : ListView(children: [
                  Column(
                    children: [
                      VerticalSpacing(height: 0.03),
                      _screenContainer()
                    ],
                  ),
                ]),
    );
  }

  _screenContainer() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _itemCard(
                  title: 'Fresh9store',
                  description:
                      'Fresh fruits,fresh vegetables, fresh meat fresh dairy, grocery',
                  image: 'assets/image/fresh9_store.png',
                  buttonText: 'Shop now',
                  route: NavigationRouter.fresh9View),
              _itemCard(
                  title: 'Other shops',
                  description: 'Grocery, medicine, panshop and more\n',
                  image: 'assets/image/other_shops.png',
                  buttonText: 'Shop now',
                  route: NavigationRouter.shopsView),
            ],
          ),
          VerticalSpacing(height: 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _itemCard(
                  title: 'Restaurants',
                  description: 'Pizza, burgers, karahi naan and more\n',
                  image: 'assets/image/restarunt.png',
                  buttonText: 'Order now',
                  route: NavigationRouter.restaurantView),
              _itemCard(
                  title: 'Services',
                  description: 'Delivery boy, electrician Plumber and more\n',
                  image: 'assets/image/services.png',
                  buttonText: 'Contact Us',
                  route: NavigationRouter.servicesView),
            ],
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  _itemCard(
      {String image,
      String title,
      String description,
      String route,
      String buttonText}) {
    return Material(
        elevation: 3,
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Container(
          width: MediaQuery.of(context).size.shortestSide * 0.42,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: FlatButton(
            splashColor: Colors.red.shade50,
            highlightColor: Colors.red.shade50,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            onPressed: () {
              if (_permissionGranted == PermissionStatus.granted) {
                _navigationService.navigateToAndBack(route);
              } else {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    backgroundColor: AppColor.primaryColor,
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
//                           width:MediaQuery.of(context).size.width*0.6,
                            child: Text(message)),
//                        !serviceEnabled ?Container(height: 0,):
                        ElevatedButton(
                            onPressed: () {
                              _determinePosition().then((value) {

                                if (_permissionGranted ==
                                    PermissionStatus.granted) {
                                  _navigationService.navigateToAndBack(route);
                                }
                              });
                            },
                            child: const Text("Allow"))
                      ],
                    )));
              }
            },
            child: Container(
//              padding: const EdgeInsets.only(top: 0.0, left: 0, right: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(image),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: FontSize.xxxl,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontSize: FontSize.m, color: AppColor.darkGrey),
                    ),
                  ),
                  Flexible(child: Container()),
                  Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: _navigationButton(buttonText, route)),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  _navigationButton(String text, String route) {
    return Text(
      text,
      style: TextStyle(
          color: AppColor.primaryColor,
          fontSize: FontSize.xl,
          fontWeight: FontWeight.w500),
    );
  }
}
