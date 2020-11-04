import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  _CartView createState() => _CartView();
}

class _CartView extends State<CartView> {
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
          onPressed: () => _navigationService.navigateTo(NavigationRouter.fresh9View),),
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
          VerticalSpacing(height: 0.01),
          Center(
            child: _cartInfo(),
          ),
          VerticalSpacing(height: 0.01),
          Card(
            elevation: 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              color: AppColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SubTotal',
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: FontSize.xxl,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Rs 66',
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: FontSize.xxl,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          VerticalSpacing(height: 0.01),
          Card(
            elevation: 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              color: AppColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: FontSize.xxl,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Rs .0',
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: FontSize.xxl,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          VerticalSpacing(height: 0.01),
          Card(
            elevation: 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              color: AppColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Free',
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: FontSize.xxl,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Rs 50',
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: FontSize.xxl,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          VerticalSpacing(height: 0.01),
          Card(
            elevation: 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              color: AppColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grand Total',
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: FontSize.xxl,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Rs 116',
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: FontSize.xxl,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          VerticalSpacing(height: 0.2),
          _checkOutButton()
        ],
      ),
    );
  }

  _cartInfo() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(14.0),
          bottomLeft: Radius.circular(14.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.shortestSide / 2.4,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14.0),
                bottomRight: Radius.circular(14.0))),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('lettuce.png'),
                HorizontalSpacing(width: 0.2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(height: 0.04),
                    Text(
                      'Lettuce',
                      style: TextStyle(
                          color: AppColor.blackColor, fontSize: FontSize.xl),
                    ),
                    VerticalSpacing(height: 0.1),
                    Text(
                      'Rs 33/pc',
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: FontSize.xxxl,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                HorizontalSpacing(width: 0.05),
                Column(
                  children: [VerticalSpacing(height: 0.1), _cartButton()],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _cartButton() {
    {
      return ButtonTheme(
          minWidth: MediaQuery.of(context).size.shortestSide * 0.20,
          child: OutlineButton(
            shape: new RoundedRectangleBorder(
              side: BorderSide(color: AppColor.secondaryColor),
              borderRadius: new BorderRadius.circular(20.0),
            ),
            onPressed: () {},
            child: Text(
              '1',
              style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: FontSize.l,
                  fontWeight: FontWeight.w500),
            ),
          ));
    }
  }
  _checkOutButton() {
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
                'CheckOut',
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
