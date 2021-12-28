import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyCartView extends StatefulWidget {
  _CheckOut createState() => _CheckOut();
}

class _CheckOut extends State<EmptyCartView> {
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
          onPressed: () => _navigationService.goBack(),
        ),
        title: Text(
          'View Cart',
          style: TextStyle(color: AppColor.darkGrey),
        ),
        actions: [
//          IconButton(
//              icon: Icon(
//                Icons.search,
//                color: AppColor.primaryColor,
//              ),
//              onPressed: null),
//          IconButton(
//              icon: Icon(
//                Icons.shopping_cart,
//                color: AppColor.primaryColor,
//              ),
//              onPressed: null)
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Flexible(child: Container()),
            Image.asset(
              "assets/image/cart.png",
              height: 200,
            ),
            Text(
              'Your cart is empty!',
              style: TextStyle(
                  color: AppColor.darkGrey, fontSize: FontSize.xxxxxxl),
            ),
            Flexible(child: Container()),
            _shoppingButton(),
            VerticalSpacing(height: 0.02),
          ],
        ),
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
              onPressed: () => _navigationService.goBack(),
            ),
          ),
        ));
  }
}
