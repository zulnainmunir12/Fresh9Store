import 'dart:math';

import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class SuggestView extends StatefulWidget {
  _SuggestViewState createState() => _SuggestViewState();
}

class _SuggestViewState extends State<SuggestView> {

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.primaryColor),
          onPressed: () => _navigationService.goBack(),
        ),
        title: Text(
          'Suggestion',
          style: TextStyle(color: Colors.black54, ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Center(
              child: Text(
                "What's Your Suggestion",
                style: TextStyle(color: Colors.black,fontSize: FontSize.xxl,),
              ),
            ),
            Padding(padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Material(
                  elevation: 7.0,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(vertical:18.0),
                      fillColor: Colors.white,
                      hintText: 'Suggest City ?',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: FontSize.l),
                      prefixIcon: Transform.rotate(angle: 180 * pi / 180,
                      child: Icon(
                        Icons.wb_incandescent_outlined,
                        color: AppColor.primaryColor,size: 28,
                      ),),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                              width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                            width: 1, color: Colors.white),
                      ),
                    ),
                    cursorColor: AppColor.blackColor,
                  ),
                ),
                SizedBox(height: 25,),
                Material(
                  elevation: 7.0,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(vertical:18.0),
                      fillColor: Colors.white,
                      hintText: 'Suggest Area ?',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: FontSize.l),
                      prefixIcon: Transform.rotate(angle: 180 * pi / 180,
                        child: Icon(
                          Icons.wb_incandescent_outlined,
                          color: AppColor.primaryColor,size: 28,
                        ),),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.5),
                            width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                             color: Colors.white),
                      ),
                    ),
                    cursorColor: AppColor.blackColor,
                  ),
                ),
                SizedBox(height: 25,),
                Material(
                  elevation: 7.0,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(vertical:18.0),
                      fillColor: Colors.white,
                      hintText: 'Suggest Restaurant and Product ?',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: FontSize.l),
                      prefixIcon: Transform.rotate(angle: 180 * pi / 180,
                        child: Icon(
                          Icons.wb_incandescent_outlined,
                          color: AppColor.primaryColor,size: 28,
                        ),),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                              width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                            color: Colors.white),
                      ),
                    ),
                    cursorColor: AppColor.blackColor,
                  ),
                ),
                SizedBox(height: 25,),
                Material(
                  elevation: 7.0,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(vertical:18.0),
                      fillColor: Colors.white,
                      hintText: 'Suggest Any More ?',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: FontSize.l),
                      prefixIcon: Transform.rotate(angle: 180 * pi / 180,
                        child: Icon(
                          Icons.wb_incandescent_outlined,
                          color: AppColor.primaryColor,size: 28,
                        ),),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                              width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                            color: Colors.white),
                      ),
                    ),
                    cursorColor: AppColor.blackColor,
                  ),
                ),
              ],
            ),),
            Expanded(
              child: Align(alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Material(
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Colors.black,
                      child: MaterialButton(
                        onPressed: (){},
                        color: AppColor.primaryColor,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Text('Submit',style: TextStyle(color: Colors.white,
                            fontSize: 18),),
                      ),
                    ),
                  ),
                ),
              ),),
          ],
        ),
      ),
    );
  }
}
