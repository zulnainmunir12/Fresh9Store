import 'dart:math';

import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/shared/ui_helper.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnterNumber extends StatefulWidget {
  _EnterNumber createState() => _EnterNumber();
}

class _EnterNumber extends State<EnterNumber> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(height: 0.03),
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
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.shortestSide*UIHelper.screenPadding,),
              child: Material(
                elevation: 7.0,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: TextField(
                  decoration: InputDecoration(
//                    contentPadding:
//                        const EdgeInsets.symmetric(horizontal: 18.0),
                    fillColor: Colors.white,
                    hintText: '+92 3017316943',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize.xxl,
                        color: AppColor.normalGrey),
//                    suffix: Icon(
//                      Icons.arrow_circle_down_outlined,
//                      color: AppColor.primaryColor,
//                    ),

                    suffixIcon: Transform.rotate(
                        angle: 180 * pi / -8,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_circle_down_outlined,
                            color: AppColor.primaryColor,
                            size: 30,
                          ),
                          onPressed: ()=>_navigationService.navigateTo(NavigationRouter.signUpScreen),
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.5), width: 1),
                        borderRadius: BorderRadius.circular(40)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(width: 1, color: Colors.transparent),
                    ),
                  ),
                  cursorColor: AppColor.blackColor,
                ),
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
      ),
    );
  }

  _logo() {
    return Image.asset(
      'assets/image/logo.png',
      height: 140,
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
}
