import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  _Notification createState() => _Notification();
}

class _Notification extends State<NotificationScreen> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
          ),
          onPressed: ()=>_navigationService.navigateTo(NavigationRouter.shopsView),
        ),
        title: Text(
          'Notification',
          style: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      body: Column(
        children: [
          VerticalSpacing(height: 0.04),
          Center(
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              elevation: 7.0,
              color: AppColor.blackColor,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 7,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  children: [
                    VerticalSpacing(height: 0.04),
                    Row(
                      children: [
                        HorizontalSpacing(width: 0.03),
                        Column(
                          children: [Text('08',style: TextStyle(
                            color: AppColor.darkGrey,fontSize: FontSize.xxl,fontWeight: FontWeight.w500
                          ),),
                            Text('Aug',style: TextStyle(
                                color: AppColor.darkGrey,fontSize: FontSize.xxl,fontWeight: FontWeight.w500
                            ),)],
                        ),
                        HorizontalSpacing(width: 0.01),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text('Special discount for this weekend',style: TextStyle(
                              color: AppColor.darkGrey,fontSize: FontSize.xl,fontWeight: FontWeight.w500
                          ),),
                          Text('we are excited to deliver your first order',style: TextStyle(
                              color: AppColor.darkGrey,fontSize: FontSize.m,
                          ),),
                            Text('checkout our app for best experience',style: TextStyle(
                              color: AppColor.darkGrey,fontSize: FontSize.m,
                            ),),
                        ],)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          VerticalSpacing(height: 0.04),
          Center(
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              elevation: 7.0,
              color: AppColor.blackColor,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 7,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  children: [
                    VerticalSpacing(height: 0.04),
                    Row(
                      children: [
                        HorizontalSpacing(width: 0.03),
                        Column(
                          children: [Text('05',style: TextStyle(
                              color: AppColor.darkGrey,fontSize: FontSize.xxl,fontWeight: FontWeight.w500
                          ),),
                            Text('Aug',style: TextStyle(
                                color: AppColor.darkGrey,fontSize: FontSize.xxl,fontWeight: FontWeight.w500
                            ),)],
                        ),
                        HorizontalSpacing(width: 0.01),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hey Usman welcome to the store app',style: TextStyle(
                                color: AppColor.darkGrey,fontSize: FontSize.xl,fontWeight: FontWeight.w500
                            ),),
                            Text('we are excited to deliver your first order',style: TextStyle(
                              color: AppColor.darkGrey,fontSize: FontSize.m,
                            ),),
                            Text('checkout our app for best experience',style: TextStyle(
                              color: AppColor.darkGrey,fontSize: FontSize.m,
                            ),),
                          ],)
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
