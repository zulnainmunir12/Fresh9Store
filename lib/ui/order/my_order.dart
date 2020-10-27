import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {
  _MyOrder createState() => _MyOrder();
}

class _MyOrder extends State<MyOrder> {
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
          'My Orders',
          style: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      body: Column(
        children: [
          VerticalSpacing(height: 0.2),
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/image/order_emoji.png',
                  height: 200,
                ),
                VerticalSpacing(height: 0.02),
                Text(
                  'No orders yet',
                  style: TextStyle(
                      color: AppColor.darkGrey, fontSize: FontSize.xxxxxxl),
                )
              ],
            ),
          ),
          VerticalSpacing(height: 0.3),
          _shoppingButton()
        ],
      ),
    );
  }

  _shoppingButton() {
    return ButtonTheme(
       minWidth: MediaQuery.of(context).size.width/1.1,
        child:
        Material(
          elevation: 7.0,
          borderRadius: BorderRadius.circular(10.0),
          color: AppColor.blackColor,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: FlatButton(
              color: AppColor.primaryColor,
              onPressed: ()=>_navigationService.navigateTo(NavigationRouter.arrivedOrder),
              child: Text(
                'START SHOPPING',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        )
        );
  }
}
