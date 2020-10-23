import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantView extends StatefulWidget {
  _RestaurantView createState() => _RestaurantView();
}

class _RestaurantView extends State<RestaurantView> {
  final List<String> _dropDownValues = [
    'Restaurant',
    'Fresh9',
    'OtherShops',
    'Services'
  ];
  String _currentlySelected = '';

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
      body:
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
              VerticalSpacing(height: 0.03),
              Center(child: Text('All Restaurant',style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: FontSize.xxl,color: AppColor.blackColor
              ),),),
              VerticalSpacing(height: 0.02),
              Container(height: MediaQuery.of(context).size.height/1.7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/restaurant_background.jpg'),fit: BoxFit.cover
                    )
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [_container()],
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
  _container() {
  }

}
