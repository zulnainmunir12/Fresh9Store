import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/main_drawer.dart';
import 'package:Product/ui/widget/adverisement_card.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';

class Fresh9HomeView extends StatefulWidget {
  _Fresh9View createState() => _Fresh9View();
}

class _Fresh9View extends State<Fresh9HomeView> {
  final List<String> _dropDownValues = [
    'Fresh9',
    'Restaurant',
    'OtherShops',
    'Services'
  ];
  String _currentlySelected = '';
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Center(
            child: _dropDrownWidget(),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {})
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.shortestSide * 0.43,
                  color: AppColor.lightestGrey.withOpacity(0.5),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index){
                      return AdvertisementCard();
                    },
                  ),
                ),
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
                            'Categories',
                            style: TextStyle(
                                color: AppColor.blackColor,
                                fontSize: FontSize.xxl,
                                fontWeight: FontWeight.w500),
                          ),
                          _viewAllButton()
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 235,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return _servicesContainer();
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Deals',
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: FontSize.xxl,
                                fontWeight: FontWeight.w500),
                          ),
                          _viewAllButton()
                        ])),
                VerticalSpacing(height: 0.01),
                Container(
                  height: 316,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      padding: EdgeInsets.only(left: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return _cartContainer();
                      }),
                ),
                VerticalSpacing(height: 0.01),
              ],
            ),
          ],
        ));
  }

  _dropDrownWidget() {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        buttonColor: AppColor.primaryColor,
        alignedDropdown: true,
        child: DropdownButton(
          items: _dropDownValues
              .map((value) => DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  ))
              .toList(),
          onChanged: (String value) {
            setState(() {
              _currentlySelected = value;
            });
          },
          isExpanded: false,
          value: _dropDownValues.first,
          hint: Text(
            'Fresh9',
            style:
                TextStyle(color: AppColor.blackColor, fontSize: FontSize.xxxl),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }

  _viewAllButton() {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.shortestSide * 0.23,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(
            side: BorderSide(color: AppColor.lightestGrey),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {},
          child: Text(
            'View all',
            style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: FontSize.xl,
                fontWeight: FontWeight.w400),
          ),
        ));
  }

  _servicesContainer() {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(100),
          ),
        ),
        child: Container(
          height: 100,
          width: 140,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(100),
              )),
          child: Column(
            children: [
              // VerticalSpacing(height: 0.01),
              Center(
                child: Image.asset(
                  'assets/image/fresh9_home_view.png',
//                height: 110,
                ),
              ),
//            VerticalSpacing(height: 0.01),
              Center(
                child: Text(
                  'Vegetables & Fruits',
                  style: TextStyle(
                      color: AppColor.primaryColor, fontSize: FontSize.m),
                ),
              ),
              VerticalSpacing(height: 0.005),

              ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  height: 60,
                  width: 80,
                  decoration: BoxDecoration(color: AppColor.primaryColor),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Best',
                          style: TextStyle(
                              color: AppColor.whiteColor, fontSize: FontSize.s),
                        ),
                        Text(
                          'Price',
                          style: TextStyle(color: AppColor.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _cartContainer() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Container(
        height: 110,
        width: 160,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                'assets/image/fresh9_home_view2.png',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'COCONUT & CLAY PEEL..',
                    style: TextStyle(
                        fontSize: FontSize.m, color: AppColor.darkGrey),
                  ),
                  VerticalSpacing(height: 0.01),
                  Text(
                    'RS 165',
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColor.darkGrey,
                        color: AppColor.darkGrey,
                        fontSize: FontSize.xl),
                  ),
                  // VerticalSpacing(height: 0.01),
                  Text(
                    'RS 140/1Unit',
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: FontSize.xl,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Center(
                child: _cartButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  _cartButton() {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.shortestSide * 0.27,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(
            side: BorderSide(color: AppColor.primaryColor),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () => _navigationService.navigateTo(NavigationRouter.cartView),
          child: Text(
            'Add to cart',
            style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: FontSize.l,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
