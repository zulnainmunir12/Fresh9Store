import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:Product/ui/widget/button.dart';
import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';

class LandingView extends StatefulWidget {
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {


  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(
              height: 0.08,
            ),
            _logo(),
            VerticalSpacing(
              height: 0.03,
            ),
            Text(
              'Sign up with',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            VerticalSpacing(
              height: 0.03,
            ),
            _socialMediaButtons(),
            VerticalSpacing(
              height: 0.02,
            ),
            Center(
              child: Text(
                'or',
                style: TextStyle(color: Colors.grey, fontSize: FontSize.xxl),
              ),
            ),
            VerticalSpacing(
              height: 0.02,
            ),
            _signUp(),
            VerticalSpacing(
              height: 0.04,
            ),
            _skipButton(),
            VerticalSpacing(
              height: 0.02,
            ),
            _image()
          ],
        ),
      ),
    );
  }

  _image() {
    return Center(
      child: Image.asset(
        'assets/image/store.png',
        height: 160,
      ),
    );
  }

  _logo() {
    return Image.asset(
      'assets/image/logo.png',
      height: 140,
    );
  }

  _signUp() {
    return MyButton(
      text: 'SignUp',
      width: MediaQuery.of(context).size.width * 0.8,
      onPressed: () =>_navigationService.navigateTo(NavigationRouter.signUpScreen),
    );
  }

  _skipButton() {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.shortestSide * 0.33,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () {
          },
          child: Text(
            'Skip',
            style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: FontSize.xl,
                fontWeight: FontWeight.w400),
          ),
        ));
  }

  _socialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SocialMediaButton(
          onPressed: () {},
          text: "Google",
          image: 'assets/image/google_logo.png',
          width: MediaQuery.of(context).size.shortestSide * 0.33,
        ),
        SocialMediaButton(
          onPressed: () {},
          text: "Facebook",
          image: 'assets/image/fb_logo.png',
          width: MediaQuery.of(context).size.shortestSide * 0.33,
        ),
      ],
    );
  }
}
