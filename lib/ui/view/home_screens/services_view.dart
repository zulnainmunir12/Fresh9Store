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

class ServicesView extends StatefulWidget {
  _ServicesView createState() => _ServicesView();
}

class _ServicesView extends State<ServicesView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final List<String> _dropDownValues = [
    'Services',
    'Fresh9',
    'Restaurant',
    'OtherShops'
  ];
  String _currentlySelected = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
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
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.shortestSide * 0.43,
            color: AppColor.lightestGrey.withOpacity(0.5),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'We Have Professionals Team',
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: FontSize.xxl,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                return _itemCard(
                  image: _items[index]['image'],
                  description: _items[index]['description'],
                  title: _items[index]['title']
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List _items = [
    {
      "image": 'assets/image/photographer.png',
      "title": "Photographer",
      "description": "Events photography, products, and more.. "
    },{
      "image": 'assets/image/electricion.png',
      "title": "Electrician",
      "description": "Fridge, Ac service, lights and more.."
    },{
      "image": 'assets/image/plumber.png',
      "title": "Plumber",
      "description": "New fitting, complains and more.."
    },{
      "image": 'assets/image/barber.png',
      "title": "Barber",
      "description": "Hair cutting, chilled hair cutting and more.."
    },
  ];


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
            'Restaurant',
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

  _itemCard({String image, String title, String description}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      color: AppColor.backgroundColor,
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          HorizontalSpacing(width: 0.01),
          Image.asset(
            image,
            height: 64,
          ),
          HorizontalSpacing(width: 0.01),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.bold),
              ),
              VerticalSpacing(height: 0.02),
              Text(
                description,
                style:
                    TextStyle(color: AppColor.darkGrey, fontSize: FontSize.m),
              )
            ],
          ),
          new Spacer(), // I just added one line
          IconButton(
            icon: Icon(Icons.navigate_next, color: AppColor.primaryColor),
            onPressed: () =>_navigationService.navigateTo(NavigationRouter.electrician),
          ) // This Icon
        ],
      ),
    );
  }
}
