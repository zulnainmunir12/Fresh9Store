import 'package:flutter/services.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart' as geoCoder;
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

const kGoogleApiKey = "AIzaSyBbl3ihjNj49FUqm2xRbl82EOmi8kHU99c";

final _searchScaffoldKey = GlobalKey<ScaffoldState>();

//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class _SplashScreenPageState extends State<MapPage> {
  String mapAddress;
  String message;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PermissionStatus _permissionGranted;
  final Location _location = Location();
  LocationData _locationData;
  List currentPosition = [];
  double long = 37.4219983, lat = -122.084;
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final _homeScaffoldKey = GlobalKey<ScaffoldState>();
  MarkerId selectedMarker;
//  NetworkUtil network = new NetworkUtil();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

//  Future getTeachers() async {
//    var list = await Firestore.instance
//        .collection('Users')
//        .where("type", isEqualTo: "2")
//        .getDocuments();
//    print(list.documents.length);
//    list.documents.forEach((item) {
//      print(item['status'] is bool);
//      if (item['status'] && item['lat'] != null && item['lon'] != null) {
//        markers[MarkerId(item['f_name'])] = Marker(
//          markerId: MarkerId(item['f_name']),
//          draggable: false,
//          position: LatLng(item['lat'], item['lon']),
//          icon: BitmapDescriptor.defaultMarkerWithHue(
//            BitmapDescriptor.hueAzure,
//          ),
//          infoWindow: InfoWindow(
//              title: Global().capitaliseInitial(item['f_name']),
//              snippet: Global().capitaliseInitial(item['t_subject']) +
//                  ' (PKR ' +
//                  item['price'].toString() +
//                  '/hr)',
//              onTap: ()=>  Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => TutorProfileForPublic(
//                        profileData:
//                        item.data,
//                        docId: item.documentID,
//                      )))
//          ),
//          onTap: () => {},
//        );
//      }
//    });
//    return true;
//  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
//    setState(() {
//
//
//          mapController.moveCamera(
//        CameraUpdate.newLatLng(
//          LatLng(lat,long),
//        ),
//      );});

    _determinePosition();
  }

  Future<void> _determinePosition() async {
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
          getUserLocation(
            _locationData,
          );
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
//        print(result.locations);
//
//        print("got location");
////        _api.addLocation({
////          'pushToken': _token,
////          'loc': [result.location.latitude, result.location.longitude]
////        });
//        getUserLocation(result.location);
//      });
//    } catch (e) {
//      print(e);
//      _scaffoldKey.currentState.showSnackBar(new SnackBar(
//          backgroundColor: AppColor.primaryColor, content: Text(e.toString())));
//    }
  }

  void getUserLocation(LocationData myLocation) async {
    //call this async method from whereever you need

    LocationData currentLocation;
//    var myLocation;
//    String error;
//    loc.Location location = new loc.Location();
//    try {
//      myLocation = await location.getLocation();
//    } on PlatformException catch (e) {
//      if (e.code == 'PERMISSION_DENIED') {
//        error = 'please grant permission';
//        print(error);
//      }
//      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
//        error = 'permission denied- please enable it from app settings';
//        print(error);
//      }
//      myLocation = null;
//    }
    try {
      currentLocation = myLocation;
      print(currentLocation.latitude);
      print(currentLocation.longitude);

//      final coordinates = new geoCoder.Coordinates(
//          currentLocation.latitude, currentLocation.longitude);
//      var addresses = await geoCoder.Geocoder.google(
//              "AIzaSyB81xMeMewP3-P3KyUloVMJnvVEhgfHgrI")
//          .findAddressesFromCoordinates(coordinates);
//      var first = addresses.first;
      print("raxi");
      setState(() {
//        mapAddress = first.addressLine;
        lat = currentLocation.latitude;
        long = currentLocation.longitude;
        currentPosition = [lat, long];
        mapController.moveCamera(
          CameraUpdate.newLatLng(
            LatLng(currentLocation.latitude, currentLocation.longitude),
          ),
        );
        markers[MarkerId("123")] = Marker(
            onTap: () {
              print('Tapped');
            },
            draggable: true,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            markerId: MarkerId('123'),
            infoWindow: InfoWindow(title: "Your Location", snippet: '*'),
            position:
                LatLng(currentLocation.latitude, currentLocation.longitude),
            onDragEnd: ((newPosition) {
              print(newPosition.latitude);
              print(newPosition.longitude);
            }));
      });

      await getAddress(currentLocation.latitude, currentLocation.longitude);
    } catch (e) {
      print(e);
    }
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  Future<String> getAddress(latitude, longitude) async {
    final coordinates = new geoCoder.Coordinates(latitude, longitude);
    var addresses = await geoCoder.Geocoder.google(
            "AIzaSyBbl3ihjNj49FUqm2xRbl82EOmi8kHU99c")
        .findAddressesFromCoordinates(coordinates);

    print(addresses);
    String temp = "";
    if (addresses.isNotEmpty) {
      temp = addresses.first.addressLine;
      print("raxi");
      print(temp);
      print(lat);
      print(long);
    }
//    return first.addressLine;
    setState(() {
      mapAddress = temp;
//      lat = latitude;
//      long = longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _homeScaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Find Your Location",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
//        title: TextField(decoration: InputDecoration(hintText: "Search"),),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                Navigator.pop(context, currentPosition);
//                // show input autocomplete with selected mode
//                // then get the Prediction selected
//                Prediction p = await PlacesAutocomplete.show(
//                    logo: Container(
//                      height: 1,
//                    ),
//                    context: context,
//                    apiKey: kGoogleApiKey,
//                    hint: "Search..",
//                    onError: (res) {
//                      _homeScaffoldKey.currentState.showSnackBar(
//                          SnackBar(content: Text(res.errorMessage)));
//                    },
//                    mode: Mode.overlay,
//                    language: "en",
//                    radius: 15000,
//                    location: Location(lat, long));
//
//                displayPrediction(p, _homeScaffoldKey.currentState, context)
//                    .then((v) {
//                  if (v != null) {
//                    print(v["address"]);
//                    getAddress(v["latitude"], v["longitude"]);
//
//                    setState(() {
//                      mapController.moveCamera(
//                        CameraUpdate.newLatLng(
//                          LatLng(v["latitude"], v["longitude"]),
//                        ),
//                      );
////                      markers[MarkerId("123")] = Marker(
////                        markerId: MarkerId("123"),
////                        draggable: true,
////                        position: LatLng(v["latitude"], v["longitude"]),
////                        icon: BitmapDescriptor.defaultMarkerWithHue(
////                          BitmapDescriptor.hueGreen,
////                        ),
////                        infoWindow:
////                            InfoWindow(title: "Destination", snippet: '*'),
////                        onTap: () => _onMarkerTapped(
////                          MarkerId("123"),
////                        ),
////                      );
//                    });
//                  }
//                });
              },
              icon: Icon(Icons.check),
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GoogleMap(
            markers: Set<Marker>.of(markers.values),
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, long),
              zoom: 12.0,
            ),
            myLocationEnabled: true,
            onCameraMove: (CameraPosition position) {
              if (markers.length > 0) {
//                print(markers[MarkerId('123')]);
                MarkerId markerId = MarkerId('123');
                Marker marker = markers[markerId];
//                print(marker);
                Marker updatedMarker = marker.copyWith(
                  positionParam: position.target,
                );
//                print(position.target.latitude);
//                print(position.target.longitude);
                setState(() {
                  currentPosition = [
                    position.target.latitude,
                    position.target.longitude
                  ];
                  markers[markerId] = updatedMarker;
                });
              }
            },
          ),
        )
//        Container(
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height,
//                child: GoogleMap(
//
//                  myLocationEnabled: false,
//                  markers: Set<Marker>.of(markers.values),
//                  initialCameraPosition: CameraPosition(
//                    target: LatLng(lat, long),
//                    zoom: 15,
//                  ),
//                  myLocationButtonEnabled: true,
//                  onMapCreated: _onMapCreated,
//                ),
//              )
        );
  }
}

//Future displayPrediction(
//    Prediction p, ScaffoldState scaffold, BuildContext context) async {
//  if (p != null) {
//    // get detail (lat/lng)
//    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
//    final lat = detail.result.geometry.location.lat;
//    final lng = detail.result.geometry.location.lng;
//    final address = detail.result.formattedAddress;
//    print(address);
//
//    return {"latitude": lat, "longitude": lng, "address": address};
//  }
//}
//
//// custom scaffold that handle search
//// basically your widget need to extends [GooglePlacesAutocompleteWidget]
//// and your state [GooglePlacesAutocompleteState]
//class CustomSearchScaffold extends PlacesAutocompleteWidget {
//  CustomSearchScaffold()
//      : super(
//          apiKey: kGoogleApiKey,
//          language: "en",
//        );
//
//  @override
//  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
//}
//
//class _CustomSearchScaffoldState extends PlacesAutocompleteState {
//  @override
//  Widget build(BuildContext context) {
//    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
//    final body = PlacesAutocompleteResult(onTap: (p) {
//      displayPrediction(p, _searchScaffoldKey.currentState, context);
//    });
//    return Scaffold(key: _searchScaffoldKey, appBar: appBar, body: body);
//  }
//}
