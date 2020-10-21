import 'dart:math';

import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnterNumber extends StatefulWidget{
  _EnterNumber createState()=> _EnterNumber();
}
class _EnterNumber extends State<EnterNumber>{
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [VerticalSpacing(height: 0.03),
          _logo(),
            VerticalSpacing(height: 0.1),
          Center(child: Text('Enter Your Mobile Number',style: TextStyle(
            color: AppColor.darkGrey,fontSize: FontSize.xl,
            fontWeight: FontWeight.bold
          ),),),
          VerticalSpacing(height: 0.03),
          Padding(padding: EdgeInsets.only(top: 20,right: 60,left: 60),
          child: Material(
            elevation: 7.0,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(40.0))),
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 18.0),
                fillColor: Colors.white,
                hintText: '+92 3017316943',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.blackColor),
                suffixIcon: Transform.rotate(angle: 180 * pi/-8,
                    child: IconButton(icon: Icon(Icons.arrow_circle_down_outlined,
                    color: AppColor.primaryColor,),)),
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
          ),),
          VerticalSpacing(height: 0.1),
          Center(child: Text('We will Verify your Mobile number using SMS',style: TextStyle(
            color: AppColor.darkGrey,fontSize: FontSize.l,
            fontWeight: FontWeight.bold
          ),),),
          VerticalSpacing(height: 0.1),
          _image(),
        ],),
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