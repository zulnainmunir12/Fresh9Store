import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPlacedView extends StatefulWidget {
  String orderId;
  OrderPlacedView(this.orderId);
  _ReceivedOrder createState() => _ReceivedOrder();
}

class _ReceivedOrder extends State<OrderPlacedView> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VerticalSpacing(height: 0.1),
          Center(
            child: Text(
              'Your',
              style: TextStyle(
                  color: AppColor.redColor,
                  fontSize: FontSize.xxxl,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Center(
            child: Text(
              'Order has been',
              style: TextStyle(
                  color: AppColor.redColor,
                  fontSize: FontSize.xxxl,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Center(
            child: Text(
              'placed',
              style: TextStyle(
                  color: AppColor.redColor,
                  fontSize: FontSize.xxxl,
                  fontWeight: FontWeight.w400),
            ),
          ),
          VerticalSpacing(height: 0.02),
          Center(
            child: Image.asset(
              'assets/image/smile_emoji.png',
              height: 300,
            ),
          ),
          Center(
            child: Text(
              'Your order no is.',
              style: TextStyle(
                  color: AppColor.redColor,
                  fontSize: FontSize.xxxl,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Center(
            child: Text(
              widget.orderId.substring(0,8),
              style: TextStyle(
                  color: AppColor.redColor,
                  fontSize: FontSize.xxxl,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(child: Container()),
          _okButton(),
          VerticalSpacing(height: 0.05),
        ],
      ),
    );
  }

  _okButton() {
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
              onPressed: () {
                _navigationService
                    .navigateToAndClearAll(NavigationRouter.appServices);
              },
              color: AppColor.primaryColor,
              child: Text(
                'OKAY',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ));
  }
}
