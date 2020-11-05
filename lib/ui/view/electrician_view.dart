import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Electrician extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  _Electrician createState() => _Electrician();
}

class _Electrician extends State<Electrician> {
  final NavigationService _navigationService = locator<NavigationService>();
  final List<String> _dropDownValues = [
    'Today',
    'Tomorrow',
    'Weekly',
    'Monthly'
  ];
  final List<String> _dropDownSlot = [
    '3:15 PM to 4:45 PM',
    '2:15 PM to 3:45 PM',
    '1:15 PM to 2:45 PM',
    '4:15 PM to 5:45 PM'
  ];
  String _currentlySelected = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> _navigationService.navigateTo(NavigationRouter.servicesView),
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
          ),
        ),
        title: Text(
          'Electrician',
          style: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      body: Column(
        children: [
          VerticalSpacing(height: 0.01),
          Center(
            child: Text(
              'Whats Your Task',
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: FontSize.xxxxl,
                  fontWeight: FontWeight.w400),
            ),
          ),
          VerticalSpacing(height: 0.01),
          _serviceCard(),
          Center(
            child: Text(
              'Add full Details',
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: FontSize.xxxxl,
                  fontWeight: FontWeight.w400),
            ),
          ),
          VerticalSpacing(height: 0.01),
          _detailForm(),
          VerticalSpacing(height: 0.01),
          _taskScheduleCard(),
          VerticalSpacing(height: 0.1),
          _submitButton()
        ],
      ),
    );
  }

  _serviceCard() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Material(
        color: AppColor.whiteColor,
        elevation: 7.0,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
            fillColor: Colors.white,
            hintText: 'Task title: e.g Ac service',
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.withOpacity(0.5)),
            prefixIcon: ImageIcon(
              AssetImage(
                'assets/image/electrian_service.png',
              ),
              size: 30,
              color: AppColor.primaryColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: Colors.white),
            ),
          ),
          cursorColor: AppColor.blackColor,
        ),
      ),
    );
  }

  _detailForm() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Material(
          elevation: 7,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: AppColor.blackColor,
          child: Container(
            width: MediaQuery.of(context).size.shortestSide * 1,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: Column(
              children: [
                Row(
                  children: [
                    FlatButton(
                      onPressed: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  // spreadRadius: 5,
                                  blurRadius: 3,
                                  offset: Offset(0, 4))
                            ]),
                        child: Row(
                          children: [
                            HorizontalSpacing(width: 0.01),
                            Icon(
                              Icons.message_outlined,
                              color: AppColor.whiteColor,
                              size: 20,
                            ),
                            HorizontalSpacing(width: 0.05),
                            Text(
                              'Text',
                              style: TextStyle(
                                  fontSize: FontSize.xl,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  // spreadRadius: 5,
                                  blurRadius: 3,
                                  offset: Offset(0, 4))
                            ]),
                        child: Row(
                          children: [
                            HorizontalSpacing(width: 0.01),
                            Icon(
                              Icons.keyboard_voice_outlined,
                              color: AppColor.darkGrey,
                            ),
                            HorizontalSpacing(width: 0.02),
                            Text(
                              'Voice Note',
                              style: TextStyle(
                                  fontSize: FontSize.xl,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.darkGrey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Describe your task:e.g 2 ac services may be gas\ may b gas filling and fan dimmer',
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: FontSize.l,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ));
  }
  _taskScheduleCard() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 5,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Column(
          children: [
            VerticalSpacing(height: 0.01),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.wysiwyg_sharp,
                    color: AppColor.darkGrey,
                    size: 20,
                  ),
                  HorizontalSpacing(width: 0.02),
                  Text(
                    'Task Day',
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: FontSize.xl,
                        fontWeight: FontWeight.w500),
                  ),
                  HorizontalSpacing(width: 0.04),
                  DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      buttonColor: AppColor.primaryColor,
                      alignedDropdown: true,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 16.5,
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            border: Border.all(
                                width: 1.1, color: AppColor.darkGrey)),
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
                            'Today',
                            style: TextStyle(
                                color: AppColor.blackColor,
                                fontSize: FontSize.xxxl),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpacing(height: 0.01),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: AppColor.darkGrey,
                    size: 20,
                  ),
                  HorizontalSpacing(width: 0.02),
                  Text(
                    'Task Time',
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: FontSize.xl,
                        fontWeight: FontWeight.w500),
                  ),
                  HorizontalSpacing(width: 0.03),
                  DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      buttonColor: AppColor.primaryColor,
                      alignedDropdown: true,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 16.5,
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            border: Border.all(
                                width: 1.1, color: AppColor.darkGrey)),
                        child: DropdownButton(
                          items: _dropDownSlot
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
                          value: _dropDownSlot.first,
                          hint: Text(
                            'Today',
                            style: TextStyle(
                                color: AppColor.blackColor,
                                fontSize: FontSize.xxxl),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  _submitButton() {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.width/1.1,
        child:
        Material(
          elevation: 7.0,
          borderRadius: BorderRadius.circular(10.0),
          color: AppColor.blackColor,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: FlatButton(
              color: AppColor.primaryColor,
              // onPressed: ()=>_navigationService.navigateTo(NavigationRouter.orderPlacedView),
              child: Text(
                'Submit',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        )
    );
  }
}
