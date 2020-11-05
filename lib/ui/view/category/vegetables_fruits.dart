import 'dart:math';
import 'dart:core';
import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VegetablesFruits extends StatefulWidget {
  _VegetablesFruits createState() => _VegetablesFruits();
}

class _VegetablesFruits extends State<VegetablesFruits> {
  final NavigationService _navigationService = locator<NavigationService>();
  int i = 0;
  TabController _tabController;

  @override
  void initState() {
    // _tabController = new TabController(length: 3, vsync: this);
    _tabController = new TabController(length: 3, vsync: null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColor.whiteColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.primaryColor,
              ),
              onPressed: () =>
                  _navigationService.navigateTo(NavigationRouter.categories),
            ),
            title: Text(
              'Vegetables & Fruits',
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
            bottom: TabBar(
              unselectedLabelColor: AppColor.lightGrey,
              labelColor: AppColor.primaryColor,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: AppColor.primaryColor,
              tabs: [
                Tab(
                    child: Column(
                  children: [
                    Text(
                      'Vegetables',
                      style: TextStyle(fontSize: FontSize.xxl),
                    ),
                  ],
                )),
                Tab(
                    child: Column(
                  children: [
                    Text(
                      'Fruits',
                      style: TextStyle(fontSize: FontSize.xxl),
                    ),
                  ],
                )),
                Tab(
                    child: Column(
                  children: [
                    Text(
                      'Dry Fruits',
                      style: TextStyle(fontSize: FontSize.xxl),
                    ),
                  ],
                )),
              ],
              controller: _tabController,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
             Container(
               child: ListView(
                 children: [
                   _categoryCard()
                 ],
               ),
             )
            ],
          ),
        ),
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
                  'assets/image/luttuce.png',
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
                      // onPressed: () => _navigationService
                      //     .navigateTo(NavigationRouter.vegetablesFruits)
                  ),
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
