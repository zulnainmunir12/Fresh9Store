import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppServices extends StatefulWidget {
  _AppServices createState() => _AppServices();
}

class _AppServices extends State<AppServices> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          children: [VerticalSpacing(height: 0.03), _screenContainer()],
        ),
      ]),
    );
  }

  _screenContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _itemCard(
                title: 'Fresh9store',
                description:
                    'Fresh fruits,fresh vegetables, fresh meat fresh dairy, grocery',
                image: 'assets/image/fresh9_store.png',
                buttonText: 'Shop now',
                route: NavigationRouter.fresh9View),
            _itemCard(
                title: 'Other shops',
                description:
                    'Grocery, medicine, panshop and more\n',
                image: 'assets/image/other_shops.png',
                buttonText: 'Shop now',
                route: NavigationRouter.shopsView),
          ],
        ),
        VerticalSpacing(height: 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _itemCard(
                title: 'Restaurants',
                description:
                'Pizza, burgers, karahi naan and more\n',
                image: 'assets/image/restarunt.png',
                buttonText: 'Order now',
                route: NavigationRouter.restaurantView),
            _itemCard(
                title: 'Services',
                description:
                'Delivery boy, electrician Plumber and more\n',
                image: 'assets/image/services.png',
                buttonText: 'Contact Us',
                route: NavigationRouter.servicesView),

          ],
        ),
      ],
    );
  }

  _itemCard(
      {String image,
      String title,
      String description,
      String route,
      String buttonText}) {
    return Material(
      elevation: 7,
      color: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Container(
        width: MediaQuery.of(context).size.shortestSide * 0.45,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(top:10.0,left: 15,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(image),
              Container(
                margin: EdgeInsets.only(top: 10.0, ),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: FontSize.xxxl,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0, ),
                child: Text(
                  description,
                  style:
                      TextStyle(fontSize: FontSize.m, color: AppColor.darkGrey),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: _navigationButton(buttonText, route)),

            ],
          ),
        ),
      ),
    );
  }

  _navigationButton(String text, String route) {
    return InkWell(
      onTap: () => _navigationService.navigateToAndBack(route),
      child: Text(
        text,
        style: TextStyle(
            color: AppColor.primaryColor,
            fontSize: FontSize.xl,
            fontWeight: FontWeight.w500),
      ),
    );
  }

}
