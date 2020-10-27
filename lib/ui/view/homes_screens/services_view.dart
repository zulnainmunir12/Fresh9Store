import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesView extends StatefulWidget {
  _ServicesView createState() => _ServicesView();
}

class _ServicesView extends State<ServicesView> {
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
              VerticalSpacing(height: 0.01),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 18,
                color: AppColor.whiteColor,
                child: Center(
                  child: Text(
                    'We Have Professionals Team',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize.xxl,
                        color: AppColor.blackColor),
                  ),
                ),
              ),
              VerticalSpacing(height: 0.01),
              _photography(),
              VerticalSpacing(height: 0.01),
              _electrician(),
              VerticalSpacing(height: 0.01),
              _plumber(),
              VerticalSpacing(height: 0.01),
              _barber()
            ],
          ),
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

  _photography() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      color: AppColor.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          HorizontalSpacing(width: 0.01),
          Image.asset(
            'assets/image/photographer.png',
            height: 64,
          ),
          HorizontalSpacing(width: 0.01),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Photographer",
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.bold),
              ),
              VerticalSpacing(height: 0.02),
              Text(
                'Events photography, products, and more.. ',
                style:
                    TextStyle(color: AppColor.darkGrey, fontSize: FontSize.m),
              )
            ],
          ),
          new Spacer(), // I just added one line
          IconButton(
            icon: Icon(Icons.navigate_next, color: AppColor.primaryColor),
            onPressed: () {},
          ) // This Icon
        ],
      ),
    );
  }

  _electrician() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      color: AppColor.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          HorizontalSpacing(width: 0.01),
          Image.asset(
            'assets/image/electricion.png',
            height: 120,
          ),
          HorizontalSpacing(width: 0.01),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Electrician",
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.bold),
              ),
              VerticalSpacing(height: 0.02),
              Text(
                'Fridge, Ac service, lights and more.. ',
                style:
                    TextStyle(color: AppColor.darkGrey, fontSize: FontSize.m),
              )
            ],
          ),
          new Spacer(), // I just added one line
          IconButton(
            icon: Icon(Icons.navigate_next, color: AppColor.primaryColor),
            onPressed: () {},
          ) // This Icon
        ],
      ),
    );
  }

  _plumber() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      color: AppColor.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          HorizontalSpacing(width: 0.01),
          Image.asset(
            'assets/image/plumber.png',
            height: 125,
          ),
          HorizontalSpacing(width: 0.01),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Plumber",
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.bold),
              ),
              VerticalSpacing(height: 0.02),
              Text(
                'New fitting, complains and more.. ',
                style:
                    TextStyle(color: AppColor.darkGrey, fontSize: FontSize.m),
              )
            ],
          ),
          new Spacer(), // I just added one line
          IconButton(
            icon: Icon(Icons.navigate_next, color: AppColor.primaryColor),
            onPressed: () {},
          ) // This Icon
        ],
      ),
    );
  }

  _barber() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      color: AppColor.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          HorizontalSpacing(width: 0.01),
          Image.asset(
            'assets/image/barber.png',
            height: 100,
          ),
          HorizontalSpacing(width: 0.01),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Barber",
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.bold),
              ),
              VerticalSpacing(height: 0.02),
              Text(
                'Hair cutting, chilled hair cutting and more.. ',
                style:
                    TextStyle(color: AppColor.darkGrey, fontSize: FontSize.m),
              )
            ],
          ),
          new Spacer(), // I just added one line
          IconButton(
            icon: Icon(Icons.navigate_next, color: AppColor.primaryColor),
            onPressed: () {},
          ) // This Icon
        ],
      ),
    );
  }
}
