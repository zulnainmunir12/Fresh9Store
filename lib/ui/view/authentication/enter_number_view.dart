import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/authentication/login_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class EnterNumber extends StatefulWidget {
  Map data;
  EnterNumber({this.data});
  _EnterNumber createState() => _EnterNumber();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _EnterNumber extends State<EnterNumber> {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  bool focus = false;
  bool _loader = false;
  final TextEditingController _phoneNumberController =
      TextEditingController(text: "+92 3");
  final TextEditingController _smsController = TextEditingController();

  String _message = '';
  String _verificationId;

  // Example code of how to verify phone number
  Future<void> _verifyPhoneNumber(LoginViewModel model) async {
    setState(() {
      _message = '';
      _loader = true;
    });

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
//      await _auth.signInWithCredential(phoneAuthCredential);
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content: Text(
//            'Phone number automatically verified and user signed in: $phoneAuthCredential'),
//      ));

      Fluttertoast.showToast(
          msg:
              'Phone number automatically verified and user signed in: $phoneAuthCredential',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      _navigationService.navigateTo(NavigationRouter.appServices);
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print('Please check your phone for the verification code.');

//      Scaffold.of(context).showSnackBar(const SnackBar(
//        content: Text('Please check your phone for the verification code.'),
//      ));

      Fluttertoast.showToast(
          msg: "Please check your phone for the verification code.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0)), //this right here
                child: Container(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
//                                            mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'ENTER PIN',
                          style: TextStyle(fontSize: FontSize.xl),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15.0),
                          child: TextField(
                            controller: _smsController,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(),
                          )),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: FlatButton(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
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
                            //3017316943
                            child: Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ).then((value) {
        print("in then");
        _signInWithPhoneNumber(model);
      });

//      setState(() {
//        _loader = false;
//      });

      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    print(_phoneNumberController.text.replaceAll(" ", ""));
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      print(e);
    }
  }

  // Example code of how to sign in with phone.
  Future<void> _signInWithPhoneNumber(LoginViewModel model) async {
    if (_smsController.text.isEmpty || _smsController.text.length < 6) {
      Fluttertoast.showToast(
          msg: 'Invalid PIN',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );
      final User user = (await _auth.signInWithCredential(credential)).user;

      print("Success");
      model.login(_phoneNumberController.text.replaceAll(" ", ""), widget.data,
          _scaffold);
      setState(() {
        _loader = false;
      });
//      Fluttertoast.showToast(
//          msg: 'Successfully signed in UID: ${user.uid}',
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIosWeb: 1,
//          backgroundColor: Colors.red,
//          textColor: Colors.white,
//          fontSize: 16.0);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'Failed to sign in',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
//      Scaffold.of(context).showSnackBar(
//        const SnackBar(
//          content: Text('Failed to sign in'),
//        ),
//      );
    }
  }

  onModelReady(LoginViewModel model) {
    print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onModelReady: (model) => onModelReady(model),
        builder: (context, LoginViewModel model, child) {
          return Scaffold(
            key: _scaffold,
            backgroundColor: Colors.white,
            body: new GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      VerticalSpacing(height: 0.09),
                      _logo(),
                      VerticalSpacing(height: 0.1),
                      Center(
                        child: Text(
                          'Enter Your Mobile Number',
                          style: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.xl,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      VerticalSpacing(height: 0.03),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
//                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300].withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ]),
                        child: Stack(
                          children: [
                            Positioned(
                              child: TextFormField(
                                onTap: () {
                                  if (!focus)
                                    setState(() {
                                      focus = true;
                                    });
                                },
                                controller: _phoneNumberController,
                                style: TextStyle(fontSize: 18),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.only(top: 15, left: 9),
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
//                  hintText: '+92 3111771118',
                                  suffixIcon: InkWell(
                                      child: _loader
                                          ? Container(
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : Container(
                                              child: Image.asset(
                                                  "assets/image/number_icon.png"),
                                              margin: EdgeInsets.all(3),
                                            ),
                                      onTap: () {
//                                    model.login(_phoneNumberController.text.replaceAll(" ", ""), _scaffold);
                                        _verifyPhoneNumber(model);
//                              _navigationService
//                                  .navigateTo(NavigationRouter.signInScreen);
                                      }),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.5),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(40)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    print(focus);
                                    if (!focus) focus = true;
                                  });
                                },
                                child: focus
                                    ? Container()
                                    : RichText(
                                        text: TextSpan(
//                    text: 'Can you ',
//                    style: TextStyle(color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '+92 3.',
                                              style: TextStyle(
                                                  color: Colors.transparent,
                                                  fontSize: 18),
//                        recognizer: _longPressRecognizer,
                                            ),
                                            TextSpan(
                                              text: '111771118',
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              left: 10,
                              top: 12,
                            )
                          ],
                        ),
                      ),
                      VerticalSpacing(height: 0.05),
                      Center(
                        child: Text(
                          'We will Verify your Mobile number using SMS',
                          style: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.l,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      VerticalSpacing(height: 0.1),
                      _image(),
                    ],
                  ),
                )),
          );
        });
  }

  _logo() {
    return Image.asset(
      'assets/image/logo.png',
      height: 100,
    );
  }

  _image() {
    return Center(
      child: Image.asset(
        'assets/image/store.png',
        height: 200,
      ),
    );
  }
}
