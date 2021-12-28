import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/authentication/signup_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/button.dart';
import 'package:fresh9_rider/ui/widget/my_text.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh9_rider/ui/widget/horizontal_spacing.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:geocoder/geocoder.dart' as geoCoder;

class SignUpView extends StatefulWidget {
  Map userData;
  SignUpView(this.userData);
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var cities = ['Lahore', 'Faisalabad', 'Sahiwal'];
  var area = ['Behria', 'Johar Town', 'Faroz Pur Road'];
  var location = ['Abc', 'Def', 'Hij'];
  int _selected = 0;
  bool enableButton = false;
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<Null> handleGoogleSignIn() async {
    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        setState(() {
          _nameController.text = firebaseUser.displayName;
          _emailController.text = firebaseUser.email;
        });
        // Check is already sign up
//        final QuerySnapshot result = await FirebaseFirestore.instance
//            .collection('users')
//            .where('id', isEqualTo: firebaseUser.uid)
//            .get();
//        final List<DocumentSnapshot> documents = result.docs;
//        if (documents.length == 0) {
//          // Update data to server if new user
//          FirebaseFirestore.instance
//              .collection('users')
//              .doc(firebaseUser.uid)
//              .set({
//            'nickname': firebaseUser.displayName,
//            'photoUrl': firebaseUser.photoURL,
//            'id': firebaseUser.uid,
//            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
//            'chattingWith': null
//          });
//
//          // Write data to local
//          currentUser = firebaseUser;
//          await prefs?.setString('id', currentUser.uid);
//          await prefs?.setString('nickname', currentUser.displayName ?? "");
//          await prefs?.setString('photoUrl', currentUser.photoURL ?? "");
//        } else {
//          DocumentSnapshot documentSnapshot = documents[0];
//          UserChat userChat = UserChat.fromDocument(documentSnapshot);
//          // Write data to local
//          await prefs?.setString('id', userChat.id);
//          await prefs?.setString('nickname', userChat.nickname);
//          await prefs?.setString('photoUrl', userChat.photoUrl);
//          await prefs?.setString('aboutMe', userChat.aboutMe);
//        }
//        Fluttertoast.showToast(msg: "Sign in success");
//        this.setState(() {
//          isLoading = false;
//        });
//
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) =>
//                    HomeScreen(currentUserId: firebaseUser.uid)));
      } else {
        Fluttertoast.showToast(msg: "Sign in fail");
        this.setState(() {
          isLoading = false;
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Can not init google sign in");
      this.setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.userData);
    _nameController.text= widget.userData['name'];
    _emailController.text=widget.userData['email'];
  }

  onModelReady(model) {}

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SignupViewModel(),
        onModelReady: (model) => onModelReady(model),
        builder: (context, SignupViewModel model, child) {
          return Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              body: model.state == ViewState.loading
                  ? Loading.normalLoading()
                  : ListView(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              VerticalSpacing(
                                height: 0.03,
                              ),
                              Center(
                                  child: Image.asset(
                                'assets/image/logo.png',
                                height: 90,
                              )),
                              VerticalSpacing(
                                height: 0.03,
                              ),
                              _socialMediaButtons(),
                              VerticalSpacing(
                                height: 0.03,
                              ),
                              Center(
                                child: Text(
                                  'Or',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
//                VerticalSpacing(
//                  height: 0.03,
//                ),
                              Padding(
                                padding: EdgeInsets.all(25),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Material(
                                        elevation: 3.0,
//                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: TextField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
//                              contentPadding:
//                                  const EdgeInsets.symmetric(vertical: 18.0),
                                              fillColor: Colors.white,
                                              hintText: 'Full Name',
                                              prefixIcon: Icon(
                                                Icons.account_circle_outlined,
                                                color: AppColor.primaryColor,
//                                size: 28,
                                              ),
                                              border: InputBorder.none),
//                          cursorColor: AppColor.blackColor,
                                        ),
                                      ),
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                    ),
                                    VerticalSpacing(height: 0.03),
                                    Container(
                                      child: Material(
                                        elevation: 3.0,
//                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              hintText: 'Email',
                                              prefixIcon: Icon(
                                                Icons.email_outlined,
                                                color: AppColor.primaryColor,
//                                size: 28,
                                              ),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                    ),
                                    VerticalSpacing(height: 0.03),
                                    Center(
                                      child: Text(
                                        'Add Your Address',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    VerticalSpacing(
                                      height: 0.03,
                                    ),
                                    Material(
                                      color: AppColor.whiteColor,
                                      elevation: 3.0,
                                      shadowColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                      ),
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              enableButton = true;
                                            });
                                            _navigationService
                                                .navigateToAndBack(
                                                    NavigationRouter.mapScreen)
                                                .then((value) async {
                                              print(value);

                                              if (value is List) {
//                                                setState(() {
//                                                  loc = value;
//                                                });

                                                final coordinates =
                                                    new geoCoder.Coordinates(
                                                        value[0], value[1]);
                                                List<geoCoder.Address>
                                                    addresses =
                                                    await geoCoder.Geocoder.google(
                                                            "AIzaSyBbl3ihjNj49FUqm2xRbl82EOmi8kHU99c")
                                                        .findAddressesFromCoordinates(
                                                            coordinates);
                                                geoCoder.Address first =
                                                    addresses.first;
                                                setState(() {
                                                  _locationController.text =
                                                      first.addressLine;
                                                  print(
                                                      _locationController.text);
                                                });
                                              }
                                            });
                                          },
                                          child: TextFormField(
                                            enabled: false,
                                            controller: _locationController,
//                        initialValue: widget.data['address'],
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18.0),
                                              fillColor: Colors.white,
                                              hintText: 'Location',
                                              prefixIcon: Icon(
                                                Icons.location_on_outlined,
                                                color: AppColor.primaryColor,
                                                size: 28,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            cursorColor: AppColor.blackColor,
                                          )),
                                    ),
                                    VerticalSpacing(
                                      height: 0.03,
                                    ),
                                    Container(
                                      child: Material(
                                        elevation: 3.0,
//                        shadowColor: Colors.black,

                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: TextField(
                                          controller: _addressController,
                                          decoration: InputDecoration(
//                              contentPadding:
//                                  const EdgeInsets.symmetric(vertical: 18.0),
                                              fillColor: Colors.white,
                                              hintText:
                                                  'House # 528 Block A st 2',
                                              prefixIcon: Icon(
                                                Icons.home,
                                                color: AppColor.primaryColor,
//                                size: 28,
                                              ),
                                              border: InputBorder.none),
                                          cursorColor: AppColor.blackColor,
                                        ),
                                      ),
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                    ),
                                    VerticalSpacing(height: 0.03),
                                    Container(
                                      child: Material(
                                        elevation: 3.0,
//                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: TextField(
                                          controller: _instructionsController,
                                          decoration: InputDecoration(
//                              contentPadding:
//                                  const EdgeInsets.symmetric(vertical: 18.0),
                                              fillColor: Colors.white,
                                              hintText:
                                                  'Add Instruction > Upper portion etc',
                                              prefixIcon: Icon(
                                                Icons.all_inbox_rounded,
                                                color: AppColor.primaryColor,
//                                  size: 28,
                                              ),
                                              border: InputBorder.none),
                                          cursorColor: AppColor.blackColor,
                                        ),
                                      ),
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                    ),
                                  ],
                                ),
                              ),
                              VerticalSpacing(height: 0.05),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300]
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                -2), // changes position of shadow
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
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300]
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                -2), // changes position of shadow
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
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300]
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                -2), // changes position of shadow
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
                              VerticalSpacing(height: 0.08),

                              Container(
//                  padding: EdgeInsets.all(25),
                                child: FlatButton(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 45,
//                      height: 36,
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              // spreadRadius: 5,
                                              blurRadius: 4,
                                              offset: Offset(0, 0),
                                              spreadRadius: 2)
                                        ]),
                                    child: Center(
                                      child: Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  onPressed: !enableButton
                                      ? () {
                                          setState(() {
                                            enableButton = true;
                                          });
                                          _navigationService
                                              .navigateToAndBack(
                                                  NavigationRouter.mapScreen)
                                              .then((value) async {
                                            print(value);

                                            if (value is List) {
//                                                setState(() {
//                                                  loc = value;
//                                                });

                                              final coordinates =
                                                  new geoCoder.Coordinates(
                                                      value[0], value[1]);
                                              List<geoCoder.Address> addresses =
                                                  await geoCoder.Geocoder.google(
                                                          "AIzaSyBbl3ihjNj49FUqm2xRbl82EOmi8kHU99c")
                                                      .findAddressesFromCoordinates(
                                                          coordinates);
                                              geoCoder.Address first =
                                                  addresses.first;
                                              setState(() {
                                                _locationController.text =
                                                    first.addressLine;
                                                print(_locationController.text);
                                              });
                                            }
                                          });
                                        }
                                      : () {
                                          if (_nameController.text.isEmpty)
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Kindly enter your name.",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          else if (_emailController
                                                  .text.isEmpty ||
                                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(
                                                      _emailController.text))
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Kindly enter valid email address.",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          else
                                            model.signup(
                                                _nameController.text,
                                                widget.userData['phone'],
                                                _emailController.text.isEmpty
                                                    ? DateTime.now()
                                                        .microsecondsSinceEpoch
                                                        .toString()
                                                    : _emailController.text,
                                                _addressController.text,
                                                _instructionsController.text,
                                                _selected == 0
                                                    ? "Home"
                                                    : _selected == 1
                                                        ? "Work"
                                                        : "Other",
                                                _locationController.text,
                                                _scaffoldKey);
//                                      model.determinePosition();
//                   if(_nameController.)
//                      _navigationService.navigateToAndClearAll(
//                          NavigationRouter.landingScreen);
                                        },
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
        });
  }

  _dropDown(List<String> items, String hint, IconData icon) {
    String _currentItemSelected;
    return Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        elevation: 3.0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.085,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 0.5, style: BorderStyle.solid, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                buttonColor: AppColor.primaryColor,
                alignedDropdown: true,
                child: new DropdownButton<String>(
                  items: items.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new MyText(
                        value,
                      ),
                    );
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
                    Icons.arrow_drop_down,
                    color: AppColor.primaryColor,
                  ),
                )),
          ),
        ));
  }

  _socialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaButton(
          onPressed: () {
            handleGoogleSignIn();
          },
          text: "Google",
          image: 'assets/image/google_logo.png',
          width: MediaQuery.of(context).size.shortestSide * 0.4,
        ),
        SizedBox(
          width: 20,
        ),
        SocialMediaButton(
          onPressed: () {},
          text: "Facebook",
          image: 'assets/image/fb_logo.png',
          width: MediaQuery.of(context).size.shortestSide * 0.4,
        ),
      ],
    );
  }
}
// String selectCity ='';
