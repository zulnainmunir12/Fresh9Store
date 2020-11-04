import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  _CheckOut createState() => _CheckOut();
}

class _CheckOut extends State<CheckOut> {
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
          onPressed: () =>
              _navigationService.navigateTo(NavigationRouter.cartView),
        ),
        title: Text(
          'View Cart',
          style: TextStyle(color: AppColor.darkGrey),
        ),
        actions: [
          Row(
            children: [
              Icon(
                Icons.search,
                color: AppColor.primaryColor,
              ),
              HorizontalSpacing(width: 0.02),
              Icon(
                Icons.add_shopping_cart,
                color: AppColor.primaryColor,
              )
            ],
          )
        ],
      ),
      body: Column(
        children: [
          VerticalSpacing(height: 0.2),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.add_shopping_cart,
                  size: 200,
                  color: AppColor.lightestGrey,
                ),
                Text(
                  'Your cart is empty!',
                  style: TextStyle(
                      color: AppColor.darkGrey, fontSize: FontSize.xxxxxxl),
                ),
                VerticalSpacing(height: 0.3),
                _shoppingButton()
              ],
            ),
          )
        ],
      ),
    );
  }
  _shoppingButton() {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 1.1,
        child: Material(
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
              child: Text(
                'Start Shopping',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () => _navigationService.navigateTo(NavigationRouter.checkOut),
            ),
          ),
        ));
  }
}
