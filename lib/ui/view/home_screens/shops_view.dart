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

class ShopsView extends StatefulWidget {
  _ShopsView createState() => _ShopsView();
}

class _ShopsView extends State<ShopsView> {
  final List<String> _dropDownValues = [
    'Shops',
    'Fresh9',
    'Restaurant',
    'Services'
  ];
  String _currentlySelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:MainDrawer(),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'All Shops',
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
              itemCount: 10,
              itemBuilder: (BuildContext context, int index){
                return _itemCard();
              },
            ),
          )
        ],
      ),
    );
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


  _itemCard() {
    return Container(
      child: Column(
        children: [
          VerticalSpacing(height: 0.01),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom:60.0),
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
                  child: Card(child: Container(
                    height: 80,
                    padding: EdgeInsets.only(left:10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColor.whiteColor,
//                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerticalSpacing(height: 0.005),
                        Text(
                          'Ali Super Store Central Park',
                          style: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.xxl),
                        ),
                        VerticalSpacing(height: 0.005),
                        Text(
                          "Grocery, Meat, Home holed, Vegi... ",
                          style: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.m),
                        ),
                        VerticalSpacing(height: 0.005),
                        RichText(
                          text: TextSpan(
                              text: 'Rs 300',
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
                                    text: ' | Rs 50',
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
                                    text: ' | store Own delivery',
                                    style: TextStyle(
                                        color: AppColor.darkGrey,
                                        fontSize: FontSize.s)),
                              ]),
                        )
                      ],
                    ),
                  ),)),
            ],
          ),
        ],
      ),
    );
  }

}
