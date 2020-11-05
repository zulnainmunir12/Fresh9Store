import 'dart:math';

import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  _Categories createState() => _Categories();
}

class _Categories extends State<Categories> {
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
              _navigationService.navigateTo(NavigationRouter.fresh9View),
        ),
        title: Text(
          'Categories',
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
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 0.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColor.whiteColor,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return _categoryCard();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _categoryCard() {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/image/fresh9_home_view.png',
              height: 120,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vegetables & Fruits',
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: FontSize.xxxl,
                      fontWeight: FontWeight.w500),
                ),
                VerticalSpacing(height: 0.01),
                Text(
                  'vegetables & fruits & dry fruits',
                  style:
                      TextStyle(color: AppColor.darkGrey, fontSize: FontSize.l),
                ),
              ],
            ),
            Transform.rotate(
              angle: 180 * pi / 120,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.primaryColor,
                  ),
                  onPressed: () => _navigationService
                      .navigateTo(NavigationRouter.vegetablesFruits)),
            )
          ],
        ),
        VerticalSpacing(height: 0.01),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.shortestSide / 150,
          color: AppColor.lightestGrey,
        )
      ],
    ));
  }
}
