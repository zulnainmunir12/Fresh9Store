import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Product/ui/widget/my_text.dart';

class Fresh9HomeView extends StatefulWidget{
  _Fresh9View createState()=> _Fresh9View();
}
 class _Fresh9View extends State<Fresh9HomeView>{
  String title = 'DropdownMenu';
  List _currentItemSelected = [
    'Fresh9Store','Restaurant','OtherShops','Services'
  ];
   final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    drawer: Drawer(),
    appBar: AppBar(
      title:
         Center(child: _dropDownButton(_currentItemSelected),)
      ),

  );
  }
  _dropDownButton(List<String> items,){
    String  _currentItemSelected;
    DropdownButtonHideUnderline(
      child: ButtonTheme(
          buttonColor: AppColor.primaryColor,
          alignedDropdown: true,
          child: new DropdownButton<String>(
            items: items.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new MyText(
                  value,
                ),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                _currentItemSelected = newValueSelected;
              });
            },
            value: _currentItemSelected,
            hint:
            Text('Fresh9'),
            icon: Icon(Icons.arrow_drop_down),
          )),
    );
    // DropdownButton(
    //   hint: Text('Frsh9',style: TextStyle(
    //     color: AppColor.blackColor
    //   ),),
    //   dropdownColor: AppColor.primaryColor,
    //   icon: Icon(Icons.arrow_drop_down,color: AppColor.primaryColor,),
    //   value: _storeVal,
    //   onChanged: (value){
    //     setState(() {
    //       _storeVal = value;
    //     });
    //   },
    //   items: _storeServices.map((value){
    //     return DropdownMenuItem(
    //       value: value,
    //       child: Text(value),
    //     );
    //   }).toList(),
    // );
  }
 }