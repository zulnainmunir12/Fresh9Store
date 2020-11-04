import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/my_text.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget{
  _Add createState()=> _Add();
}
class _Add extends State<AddAddress>{
  final NavigationService _navigationService = locator<NavigationService>();
  var cities = ['Lahore', 'Faisalabad', 'Sahiwal'];
  var area = ['Behria', 'Johar Town', 'Faroz Pur Road'];
  var location = ['Abc', 'Def', 'Hij'];
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
          ),
          onPressed: () => _navigationService.navigateTo(NavigationRouter.appServices)),
      title: Text(
        'Add new Addresses',
        style: TextStyle(color: AppColor.darkGrey),
      ),
    ),
    body: Column(
      children: [
        VerticalSpacing(
          height: 0.02,
        ),
        Center(
          child: Text(
            'Add Your Address',
            style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
        VerticalSpacing(
          height: 0.03,
        ),
        _dropDown(cities, 'Choose your City', Icons.apartment,),
        //
        VerticalSpacing(
          height: 0.03,
        ),
        _dropDown(area, 'Choose your Area', Icons.home),
        VerticalSpacing(height: 0.03),
        _dropDown(location, 'Location', Icons.location_on_outlined,),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Material(
                color: AppColor.whiteColor,
                elevation: 7.0,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(40.0)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 18.0),
                    fillColor: Colors.white,
                    hintText: 'House # 528 Block A st 2',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.5)),
                    prefixIcon: Icon(
                      Icons.home,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.5),
                            width: 1),
                        borderRadius: BorderRadius.circular(25)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(25)),
                      borderSide:
                      BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                  cursorColor: AppColor.blackColor,
                ),
              ),
              VerticalSpacing(height: 0.03),
              Material(
                color: AppColor.whiteColor,
                elevation: 7.0,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(40.0))),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 18.0),
                    fillColor: Colors.white,
                    hintText: 'Add Instruction > Upper portion etc',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.5)),
                    prefixIcon: Icon(
                      Icons.all_inbox_rounded,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.5),
                            width: 1),
                        borderRadius: BorderRadius.circular(25)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(25)),
                      borderSide:
                      BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                  cursorColor: AppColor.blackColor,
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing(height: 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              onPressed: () {},
              child: Container(
                width: MediaQuery.of(context).size.width*0.2,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: AppColor.whiteColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          // spreadRadius: 5,
                          blurRadius: 3,
                          offset: Offset(0, 4))
                    ]),
                child: Center(
                  child: Text(
                    'Home',
                    style: TextStyle(
                        fontSize: FontSize.xl,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Container(
                width: MediaQuery.of(context).size.width*0.2,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: AppColor.whiteColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          // spreadRadius: 5,
                          blurRadius: 3,
                          offset: Offset(0, 4))
                    ]),
                child: Center(
                  child: Text(
                    'Work',
                    style: TextStyle(
                        fontSize: FontSize.xl,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Container(
                width: MediaQuery.of(context).size.width*0.2,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: AppColor.whiteColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          // spreadRadius: 5,
                          blurRadius: 3,
                          offset: Offset(0, 4))
                    ]),
                child: Center(
                  child: Text(
                    'Other',
                    style: TextStyle(
                        fontSize: FontSize.xl,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(height: 0.05),
        _saveButton()
      ],
    ),
  );
  }
  _dropDown(List<String> items, String hint, IconData icon) {
    String _currentItemSelected;
    return Material(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 0.5, style: BorderStyle.solid, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        elevation: 7.0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 0.5, style: BorderStyle.solid, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            color: AppColor.whiteColor
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                buttonColor: AppColor.primaryColor,
                alignedDropdown: true,
                child: new DropdownButton<String>(
                  items: items.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new MyText(value)
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      _currentItemSelected = newValueSelected;
                    });
                  },
                  value: _currentItemSelected,
                  hint: Row(
                    children: [
                      Icon(
                        icon,
                        color: AppColor.primaryColor,
                      ),
                      HorizontalSpacing(width: 0.01),
                      Text(hint)
                    ],
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColor.primaryColor,
                  ),
                )),
          ),
        ));
  }
  _saveButton(){
   return Padding(
      padding: EdgeInsets.all(25),
      child: FlatButton(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    // spreadRadius: 5,
                    blurRadius: 4,
                    offset: Offset(0, 0),
                    spreadRadius: 2)
              ]),
          child: Center(
            child: Text(
              'SAVE',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        onPressed: () {
          _navigationService.navigateToAndClearAll(NavigationRouter.addressView);
        },
      ),
    );
  }
}