import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/viewmodel/authentication/login_view_model.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/button.dart';
import 'package:fresh9_rider/ui/widget/my_text.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh9_rider/ui/widget/horizontal_spacing.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  onModelReady(LoginViewModel model) {}

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onModelReady: (model) => onModelReady(model),
        builder: (context, LoginViewModel model, child) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: new GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: model.state == ViewState.loading
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
                                  fit: BoxFit.fitHeight,
                                  height: 120,
                                )),
                                VerticalSpacing(
                                  height: 0.03,
                                ),
                                _socialMediaButtons(model),
                                VerticalSpacing(
                                  height: 0.03,
                                ),
                                Center(
                                  child: Text(
                                    'Or',
                                    style: TextStyle(
                                        fontSize: 25,
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
                                      Material(
                                        elevation: 7.0,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 18.0),
                                            fillColor: Colors.white,
                                            hintText: 'Email',
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
                                              color: AppColor.primaryColor,
                                              size: 28,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          cursorColor: AppColor.blackColor,
                                        ),
                                      ),
                                      VerticalSpacing(
                                        height: 0.03,
                                      ),
                                      Material(
                                        elevation: 7.0,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: TextField(
                                          obscureText: true,
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 18.0),
                                            fillColor: Colors.white,
                                            hintText: 'Password',
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: AppColor.primaryColor,
                                              size: 28,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          cursorColor: AppColor.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: FlatButton(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                // spreadRadius: 5,
                                                blurRadius: 4,
                                                offset: Offset(0, 0),
                                                spreadRadius: 2)
                                          ]),
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      model.login(_emailController.text, {},
                                          _scaffoldKey);
//                      _navigationService.navigateToAndClearAll(NavigationRouter.landingScreen);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
          );
        });
  }

  _dropDown(List<String> items, String hint, IconData icon) {
    String _currentItemSelected;
    return Material(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 0.5, style: BorderStyle.solid, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        elevation: 7.0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
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

  _socialMediaButtons(LoginViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SocialMediaButton(
          onPressed: () => model.onTapLogin(),
          text: "Google",
          image: 'assets/image/google_logo.png',
          width: MediaQuery.of(context).size.shortestSide * 0.33,
        ),
        SocialMediaButton(
          onPressed: () => model.onTapLogin(),
          text: "Facebook",
          image: 'assets/image/fb_logo.png',
          width: MediaQuery.of(context).size.shortestSide * 0.33,
        ),
      ],
    );
  }
}
// String selectCity ='';
