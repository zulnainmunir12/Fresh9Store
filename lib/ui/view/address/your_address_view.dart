import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:fresh9_rider/ui/widget/horizontal_spacing.dart';
import 'package:fresh9_rider/ui/widget/my_text.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoCoder;
import 'package:shared_preferences/shared_preferences.dart';

class YourAddressView extends StatefulWidget {
  Map data;
  YourAddressView(this.data);
  _YourAddress createState() => _YourAddress();
}

class _YourAddress extends State<YourAddressView> {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _houseNumberController = new TextEditingController();
  TextEditingController _instructionsController = new TextEditingController();
  bool updateButton = false;
  bool _loader = false;
  List loc = [];
  int _selected = 0;
  final AuthService _authService = locator<AuthService>();
  UserInfoModel _userInfo;
  final Api _api = locator<Api>();
  bool initialFetch = true;
  int addressIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.data);
    getUser();
    _addressController.text = widget.data['address'];
    _instructionsController.text = widget.data['instructions'];
    _houseNumberController.text = widget.data['houseNumber'];
    loc = widget.data['loc'];
    if (widget.data['type'] == "Home")
      _selected = 0;
    else if (widget.data['type'] == "Work")
      _selected = 1;
    else
      _selected = 2;
  }

  getUser() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String token = await sharedPreference.get(SharedPreference.token);
    _userInfo = _authService.userInfoModel;
    LoginModel response = await _api.getProfile(_userInfo.id, token);
    _userInfo = response.userInfo;

    setState(() {
      addressIndex = _userInfo.addresses.indexWhere(
          (element) => element['address'] == widget.data['address']);
      if (addressIndex != -1) initialFetch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.primaryColor,
            ),
            onPressed: () => _navigationService.goBack()),
        title: Text(
          'Addresses',
          style: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      body: initialFetch
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              children: [
                VerticalSpacing(
                  height: 0.02,
                ),
                Center(
                  child: Text(
                    'Your Address',
                    style: TextStyle(
                        fontSize: FontSize.xl,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                VerticalSpacing(
                  height: 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
//                _dropDown(
//                  cities,
//                  'Choose your City',
//                  Icons.apartment,
//                ),
//                //
//                VerticalSpacing(
//                  height: 0.02,
//                ),
//                _dropDown(area, 'Choose your Area', Icons.home),
//                VerticalSpacing(height: 0.02),
                      Material(
                        color: AppColor.whiteColor,
                        elevation: 3.0,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                updateButton = true;
                              });
                              _navigationService
                                  .navigateToAndBack(NavigationRouter.mapScreen)
                                  .then((value) async {
                                print(value);

                                if (value is List) {
                                  setState(() {
                                    loc = value;
                                  });

                                  final coordinates = new geoCoder.Coordinates(
                                      value[0], value[1]);
                                  List<geoCoder.Address> addresses =
                                      await geoCoder.Geocoder.google(
                                              "AIzaSyB81xMeMewP3-P3KyUloVMJnvVEhgfHgrI")
                                          .findAddressesFromCoordinates(
                                              coordinates);
                                  geoCoder.Address first = addresses.first;
                                  setState(() {
                                    _addressController.text = first.addressLine;
                                    print(_addressController.text);
                                  });
                                }
                              });
                            },
                            child: TextFormField(
                              enabled: false,
                              controller: _addressController,
//                        initialValue: widget.data['address'],
                              maxLines: 2,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 18.0),
                                fillColor: Colors.white,
                                hintText: 'Location',
                                prefixIcon: Icon(
                                  Icons.location_on_outlined,
                                  color: AppColor.primaryColor,
                                  size: 28,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(25)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                ),
                              ),
                              cursorColor: AppColor.blackColor,
                            )),
                      ),
                      VerticalSpacing(height: 0.02),
                      Material(
                        color: AppColor.whiteColor,
                        elevation: 3.0,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: TextFormField(
//                    initialValue: widget.data['houseNumber'],
                          controller: _houseNumberController,
//                    maxLines: 2,
                          onChanged: (value) {
                            setState(() {
                              updateButton = true;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 18.0),
                            fillColor: Colors.white,
                            hintText: 'Address',
                            prefixIcon: Icon(
                              Icons.home,
                              color: AppColor.primaryColor,
                              size: 28,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 1),
                                borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                          ),
                          cursorColor: AppColor.blackColor,
                        ),
                      ),
                      VerticalSpacing(height: 0.02),
                      Material(
                        color: AppColor.whiteColor,
                        elevation: 3.0,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: TextFormField(
                          controller: _instructionsController,
//                    initialValue: widget.data['instructions'],
                          onChanged: (value) {
                            setState(() {
                              updateButton = true;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 18.0),
                            fillColor: Colors.white,
                            hintText: 'Add Instruction > Upper portion etc',
                            prefixIcon: Icon(
                              Icons.all_inbox_rounded,
                              color: AppColor.primaryColor,
                              size: 28,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 1),
                                borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                          ),
                          cursorColor: AppColor.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalSpacing(height: 0.15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300].withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                                  Offset(0, -2), // changes position of shadow
                            ),
                          ]),

                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        splashColor: Colors.red.shade50,
                        highlightColor: Colors.red.shade50,
                        child: Text(
                          'Home',
                          style: TextStyle(
                            color: _selected == 0
                                ? AppColor.primaryColor
                                : AppColor.blackColor,
                            fontSize: FontSize.xl,
//                            fontWeight: FontWeight.w600,
                          ),
                        ),
//        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                        color: AppColor.whiteColor,

                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          setState(() {
                            _selected = 0;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300].withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                                  Offset(0, -2), // changes position of shadow
                            ),
                          ]),

                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        splashColor: Colors.red.shade50,
                        highlightColor: Colors.red.shade50,
                        child: Text(
                          'Work',
                          style: TextStyle(
                            color: _selected == 1
                                ? AppColor.primaryColor
                                : AppColor.blackColor,
//                            color: AppColor.primaryColor,
                            fontSize: FontSize.xl,
//                            fontWeight: FontWeight.w600,
                          ),
                        ),
//        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                        color: AppColor.whiteColor,

                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          setState(() {
                            _selected = 1;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300].withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                                  Offset(0, -2), // changes position of shadow
                            ),
                          ]),

                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        splashColor: Colors.red.shade50,
                        highlightColor: Colors.red.shade50,
                        child: Text(
                          'Other',
                          style: TextStyle(
                            color: _selected == 2
                                ? AppColor.primaryColor
                                : AppColor.blackColor,
//                            color: AppColor.primaryColor,
                            fontSize: FontSize.xl,
//                            fontWeight: FontWeight.w600,
                          ),
                        ),
//        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                        color: AppColor.whiteColor,

                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          setState(() {
                            _selected = 2;
                          });
                        },
                      ),
                    )
                  ],
                ),
                VerticalSpacing(height: 0.15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [updateButton ? _continueButton() : Container()])
              ],
            ),
    );
  }

  _dropDown(List<String> items, String hint, IconData icon) {
    String _currentItemSelected;
    return Material(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 0.5, style: BorderStyle.solid, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        elevation: 3.0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 0.5, style: BorderStyle.solid, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              color: AppColor.whiteColor),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                buttonColor: AppColor.primaryColor,
                alignedDropdown: true,
                child: new DropdownButton<String>(
                  items: items.map((String value) {
                    return new DropdownMenuItem<String>(
                        value: value, child: new MyText(value));
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      _currentItemSelected = newValueSelected;
                    });
                  },
                  value: _currentItemSelected,
                  hint: Row(
                    children: [
                      Icon(
                        icon,
                        color: AppColor.primaryColor,
                      ),
                      HorizontalSpacing(width: 0.01),
                      Text(hint)
                    ],
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColor.primaryColor,
                  ),
                )),
          ),
        ));
  }

  _continueButton() {
    return _loader
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : FlatButton(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
//        padding: EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        // spreadRadius: 5,
                        blurRadius: 4,
                        offset: Offset(0, 0),
                        spreadRadius: 2)
                  ]),
              child: Center(
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            onPressed: () async {
              setState(() {
                _loader = true;
              });
              SharedPreferences sharedPreference =
                  await SharedPreferences.getInstance();
              String token = await sharedPreference.get(SharedPreference.token);
              _userInfo.addresses[addressIndex] = {
                'loc': loc,
                'address': _addressController.text,
                'type': _selected == 0
                    ? "Home"
                    : _selected == 1
                        ? "Work"
                        : "Other",
                'instructions': _instructionsController.text,
                'houseNumber': _houseNumberController.text
              };
              LoginModel response = await _api.updateProfile(
                  {'addresses': _userInfo.addresses}, _userInfo.id, token);
              setState(() {
                _loader = false;
              });
              _navigationService.goBack();
            },
          );
  }

//  _deleteButton() {
//    return FlatButton(
//      child: Container(
//        width: MediaQuery.of(context).size.width / 3.3,
//        height: 50,
//        decoration: BoxDecoration(
//            color: AppColor.whiteColor,
//            borderRadius: BorderRadius.circular(10),
//            boxShadow: [
//              BoxShadow(
//                  color: Colors.black.withOpacity(0.2),
//                  // spreadRadius: 5,
//                  blurRadius: 4,
//                  offset: Offset(0, 0),
//                  spreadRadius: 2)
//            ]),
//        child: Center(
//          child: Text(
//            'Delete',
//            style: TextStyle(color: AppColor.blackColor, fontSize: 18),
//          ),
//        ),
//      ),
//      onPressed: () {
//        _navigationService.navigateToAndClearAll(NavigationRouter.addressView);
//      },
//    );
//  }
}
