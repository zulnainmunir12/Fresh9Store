import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/widget/horizontal_spacing.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResturantMenuView extends StatefulWidget {
  _KarachiBiryani createState() => _KarachiBiryani();
}

class _KarachiBiryani extends State<ResturantMenuView> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              _navigationService.navigateTo(NavigationRouter.restaurantView),
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
          ),
        ),
        title: Text(
          'Karachi Biryani',
          style: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: _itemCard(),
          ),
          VerticalSpacing(height: 0.001),
          Center(
            child: Text(
              'Menu',
              style: TextStyle(
                  color: AppColor.darkGrey,
                  fontSize: FontSize.xxxxl,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HorizontalSpacing(width: 0.001),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Best Deals',
                    style: TextStyle(
                        color: AppColor.primaryColor, fontSize: FontSize.xl),
                  ),
                  Text(
                    'Deal 1',
                    style: TextStyle(
                        color: AppColor.blackColor, fontSize: FontSize.l),
                  ),
                  Text(
                    'Half chicken biryani 1 chicken\npiece, salad , cold drink',
                    style: TextStyle(
                        color: AppColor.lightestGrey, fontSize: FontSize.m),
                  ),
                  Row(
                    children: [
                      Text(
                        'Rs 230',
                        style: TextStyle(fontSize: FontSize.l),
                      ),
                      HorizontalSpacing(width: 0.01),
                      _cartButton()
                    ],
                  ),
                  VerticalSpacing(height: 0.01),
                  Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.4,
                    height: MediaQuery.of(context).size.shortestSide / 200,
                    color: AppColor.lightGrey,
                  ),
                  VerticalSpacing(height: 0.01),
                  Text(
                    'Haleem',
                    style: TextStyle(
                        color: AppColor.primaryColor, fontSize: FontSize.xl),
                  ),
                  Text(
                    'Full Haleem',
                    style: TextStyle(
                        color: AppColor.blackColor, fontSize: FontSize.l),
                  ),
                  Text(
                    'with two chicken piece',
                    style: TextStyle(
                        color: AppColor.lightestGrey, fontSize: FontSize.m),
                  ),
                  Row(
                    children: [
                      Text(
                        'Rs 230',
                        style: TextStyle(fontSize: FontSize.l),
                      ),
                      HorizontalSpacing(width: 0.01),
                      _cartButton()
                    ],
                  ),
                  VerticalSpacing(height: 0.01),
                  Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.4,
                    height: MediaQuery.of(context).size.shortestSide / 200,
                    color: AppColor.lightGrey,
                  ),
                ],
              ),
              HorizontalSpacing(width: 0.001),
              Column(
                children: [
                  VerticalSpacing(height: 0.02),
                  Container(
                    width: MediaQuery.of(context).size.width / 200,
                    height: MediaQuery.of(context).size.height / 2.4,
                    color: AppColor.lightestGrey,
                  ),
                ],
              ),
              HorizontalSpacing(width: 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Biryani',
                    style: TextStyle(
                        color: AppColor.primaryColor, fontSize: FontSize.xl),
                  ),
                  Text(
                    'Half Plate',
                    style: TextStyle(
                        color: AppColor.blackColor, fontSize: FontSize.l),
                  ),
                  Text(
                    '1 chicken piece',
                    style: TextStyle(
                        color: AppColor.lightestGrey, fontSize: FontSize.m),
                  ),
                  Row(
                    children: [
                      Text(
                        'Rs 230',
                        style: TextStyle(fontSize: FontSize.l),
                      ),
                      HorizontalSpacing(width: 0.01),
                      _cartButton()
                    ],
                  ),
                  VerticalSpacing(height: 0.01),
                  Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.4,
                    height: MediaQuery.of(context).size.shortestSide / 200,
                    color: AppColor.lightGrey,
                  ),
                  VerticalSpacing(height: 0.01),
                  Text(
                    'Haleem',
                    style: TextStyle(
                        color: AppColor.primaryColor, fontSize: FontSize.xl),
                  ),
                  Text(
                    'Full Haleem',
                    style: TextStyle(
                        color: AppColor.blackColor, fontSize: FontSize.l),
                  ),
                  Text(
                    'with two chicken piece',
                    style: TextStyle(
                        color: AppColor.lightestGrey, fontSize: FontSize.m),
                  ),
                  Row(
                    children: [
                      Text(
                        'Rs 230',
                        style: TextStyle(fontSize: FontSize.l),
                      ),
                      HorizontalSpacing(width: 0.01),
                      _cartButton()
                    ],
                  ),
                  VerticalSpacing(height: 0.01),
                  Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.4,
                    height: MediaQuery.of(context).size.shortestSide / 200,
                    color: AppColor.lightGrey,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _itemCard() {
    return Container(
      child: Column(
        children: [
          VerticalSpacing(height: 0.01),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 60.0),
                height: 150,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              Positioned(
                  top: 120,
                  left: 15,
                  right: 15,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
//                      height: 80,
                      padding: EdgeInsets.only(left: 10,bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
//                        border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VerticalSpacing(height: 0.005),
                          Text(
                            'Karachi biryani - Central Park',
                            style: TextStyle(
                                color: AppColor.darkGrey,
                                fontSize: FontSize.xxl),
                          ),
                          VerticalSpacing(height: 0.005),
                          Text(
                            "Biryani, Berger, shawarma, naan",
                            style: TextStyle(
                                color: AppColor.darkGrey, fontSize: FontSize.m),
                          ),
                          VerticalSpacing(height: 0.005),
                          RichText(
                            text: TextSpan(
                                text: 'Rs 200',
                                style: TextStyle(
                                    color: AppColor.darkGrey,
                                    fontSize: FontSize.s),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Minimum',
                                      style: TextStyle(
                                          color: AppColor.darkGrey
                                              .withOpacity(0.4),
                                          fontSize: FontSize.s)),
                                  TextSpan(
                                      text: ' | Rs 30',
                                      style: TextStyle(
                                          color: AppColor.darkGrey,
                                          fontSize: FontSize.s)),
                                  TextSpan(
                                      text: ' Delivery',
                                      style: TextStyle(
                                          color: AppColor.darkGrey
                                              .withOpacity(0.4),
                                          fontSize: FontSize.s)),
                                  TextSpan(
                                      text: ' | Restaurant Own delivery',
                                      style: TextStyle(
                                          color: AppColor.darkGrey,
                                          fontSize: FontSize.s)),
                                ]),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ],
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
              'Add to cart',
              style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: FontSize.m,
                  fontWeight: FontWeight.w500),
            ),
          ));
    }
  }
}
