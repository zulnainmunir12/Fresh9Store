import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
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
        drawer: Drawer(),
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
                  Icons.add_shopping_cart,
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
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [_Container(), _Container(), _Container()],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.shortestSide * 0.13,
                  color: AppColor.lightestGrey.withOpacity(0.1),
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
                Container(
                  height: MediaQuery.of(context).size.shortestSide * 0.53,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _servicesContainer(),
                      HorizontalSpacing(width: 0.01),
                      _servicesContainer(),
                      HorizontalSpacing(width: 0.01),
                      _servicesContainer(),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Deal',
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: FontSize.xxl,
                                fontWeight: FontWeight.w500),
                          ),
                          _viewAllButton()
                        ])),
                VerticalSpacing(height: 0.01),
                Container(
                  height: MediaQuery.of(context).size.shortestSide * 0.73,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _cartContainer(),
                      HorizontalSpacing(width: 0.01),
                      _cartContainer(),
                      HorizontalSpacing(width: 0.01),
                      _cartContainer(),
                    ],
                  ),
                ),
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

  _Container() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.shortestSide * 0.93,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColor.primaryColor),
        child: Center(
          child: Text(
            'Ads',
            style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: FontSize.xxxxxxl,
                fontWeight: FontWeight.bold),
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
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
        side: BorderSide(
            width: 0.5, style: BorderStyle.solid, color: AppColor.whiteColor),
      ),
      elevation: 7,
      child: Container(
        height: MediaQuery.of(context).size.shortestSide / 1.3,
        width: MediaQuery.of(context).size.shortestSide / 2.5,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100))),
        child: Column(
          children: [
            // VerticalSpacing(height: 0.01),
            Center(
              child: Image.asset(
                'assets/image/fresh9_home_view.png',
                height: 110,
              ),
            ),
            VerticalSpacing(height: 0.01),
            Center(
              child: Text(
                'Vegetables and Fruits',
                style: TextStyle(
                    color: AppColor.primaryColor, fontSize: FontSize.m),
              ),
            ),
            VerticalSpacing(height: 000.01),
            ShapeOfView(
              shape: TriangleShape(
                percentBottom: 0.5,
                percentLeft: 0.1,
                percentRight: 0.1,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        35,
                      ),
                      topLeft: Radius.circular(35),
                    ),
                    color: AppColor.primaryColor),
                child: Center(
                  child: Column(
                    children: [
                      VerticalSpacing(height: 0.02),
                      Text(
                        'Best',
                        style: TextStyle(color: AppColor.whiteColor),
                      ),
                      Text(
                        'Price',
                        style: TextStyle(color: AppColor.whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // SvgPicture.asset('assets/image/polygon.svg',height: 50,width: 50,),
          ],
        ),
      ),
    );
  }

  _cartContainer() {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        side: BorderSide(style: BorderStyle.solid, color: AppColor.whiteColor),
      ),
      elevation: 7,
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width / 2.2,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset(
                'assets/image/fresh9_home_view2.png',
                height: 160,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'COCONUT & CLAY PEEL..',
                    style:
                        TextStyle(fontSize: FontSize.m, color: AppColor.darkGrey),
                  ),
                  VerticalSpacing(height: 0.01),
                  Text(
                    'RS 165',
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColor.darkGrey,
                        color: AppColor.darkGrey,fontSize: FontSize.xxl),
                  ),
                  VerticalSpacing(height: 0.01),
                  Text(
                    'RS 140/1Unit',
                    style: TextStyle(
                        color: AppColor.primaryColor,fontSize: FontSize.xxl,fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Center(child: _cartButton(),)
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
            side: BorderSide(color: AppColor.greenColor),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {},
          child: Text(
            'Add to cart',
            style: TextStyle(
                color: AppColor.greenColor,
                fontSize: FontSize.xl,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
