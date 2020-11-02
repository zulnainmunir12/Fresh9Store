import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceOrder extends StatefulWidget {
  _PlaceOrder createState() => _PlaceOrder();
}

class _PlaceOrder extends State<PlaceOrder> {
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
  final NavigationService _navigationService = locator<NavigationService>();
  int selectedRadio;

  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.primaryColor,
            ),
            onPressed: () =>
                _navigationService.navigateTo(NavigationRouter.arrivedOrder)),
        title: Text(
          'Place Order',
          style: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              VerticalSpacing(height: 0.03),
              _container(),
              VerticalSpacing(height: 0.02),
              _contactContainer(),
              VerticalSpacing(height: 0.02),
              _deliveryContainer(),
              VerticalSpacing(height: 0.02),
              _instructionContainer(),
              VerticalSpacing(height: 0.02),
              _paymentContainer(),
              VerticalSpacing(height: 0.02),
              _orderButton()
            ],
          )
        ],
      ),
    );
  }

  _container() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        height: MediaQuery.of(context).size.height / 9.5,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Center(
          child: Column(
            children: [
              VerticalSpacing(height: 0.01),
              Text(
                'Total',
                style:
                    TextStyle(color: AppColor.blackColor, fontSize: FontSize.l),
              ),
              VerticalSpacing(height: 0.02),
              Text(
                'Rs 116',
                style: TextStyle(
                    color: AppColor.redColor,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.xxxl),
              )
            ],
          ),
        ),
      ),
    );
  }

  _contactContainer() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 2.9,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Column(
          children: [
            VerticalSpacing(height: 0.01),
            Center(
              child: Text(
                'Contact Info',
                style: TextStyle(
                    color: AppColor.redColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w400),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.account_circle_outlined,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                SizedBox(
                  width: 30.0,
                ),
                new Flexible(
                  child: new TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Usman Sukhera',
                      hintStyle: TextStyle(
                          color: AppColor.darkGrey, fontSize: FontSize.xl),
                    ),
                  ),
                ),
                Icon(
                  Icons.phone,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                SizedBox(
                  width: 35.0,
                ),
                new Flexible(
                  child: new TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: '03017316943',
                          hintStyle: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.xl))),
                ),
                IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColor.redColor,
                      size: 20,
                    ),
                    onPressed: () {})
              ],
            ),
            Row(
              children: [
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.mail_outline,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                HorizontalSpacing(width: 0.02),
                SizedBox(
                  width: 330,
                  child: new Flexible(
                    child: new TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6),
                            hintText: 'usman1sukhera@gmail.com',
                            hintStyle: TextStyle(
                                color: AppColor.darkGrey,
                                fontSize: FontSize.xl))),
                  ),
                ),
              ],
            ),
            VerticalSpacing(height: 0.02),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 300,
              decoration: BoxDecoration(color: AppColor.darkGrey),
            ),
            VerticalSpacing(height: 0.01),
            Center(
              child: Text(
                'Delivery Info',
                style: TextStyle(
                    color: AppColor.redColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w400),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.home,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                SizedBox(
                  width: 30.0,
                ),
                new Flexible(
                  child: new TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'House# 535 Block A',
                      hintStyle: TextStyle(
                          color: AppColor.darkGrey, fontSize: FontSize.xl),
                    ),
                  ),
                ),
                Icon(
                  Icons.apartment_sharp,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                SizedBox(
                  width: 35.0,
                ),
                new Flexible(
                  child: new TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Lahore',
                          hintStyle: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.xl))),
                ),
                IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColor.redColor,
                      size: 20,
                    ),
                    onPressed: () {})
              ],
            ),
            Row(
              children: [
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.home_outlined,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                HorizontalSpacing(width: 0.02),
                SizedBox(
                  width: 330,
                  child: new Flexible(
                    child: new TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6),
                            hintText: 'Central park housing scheme',
                            hintStyle: TextStyle(
                                color: AppColor.darkGrey,
                                fontSize: FontSize.xl))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _deliveryContainer() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Column(
          children: [
            VerticalSpacing(height: 0.01),
            Center(
              child: Text(
                'Delivery Schedule',
                style: TextStyle(
                    color: AppColor.redColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w400),
              ),
            ),
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
                    'Delivery Day',
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: FontSize.xl,
                        fontWeight: FontWeight.w500),
                  ),
                  HorizontalSpacing(width: 0.02),
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
                    'Delivery Slot',
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: FontSize.xl,
                        fontWeight: FontWeight.w500),
                  ),
                  HorizontalSpacing(width: 0.02),
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

  _instructionContainer() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: AppColor.whiteColor,
        ),
        child: Column(
          children: [
            VerticalSpacing(height: 0.01),
            Center(
              child: Text(
                'Delivery Instruction',
                style: TextStyle(
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w400,
                    color: AppColor.redColor),
              ),
            ),
            VerticalSpacing(height: 0.01),
            SizedBox(
              width: 350,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "e.g Please call don't ring the doorbell",
                    hintStyle: TextStyle(
                        fontSize: FontSize.l, color: AppColor.normalGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          width: 0.5,
                          style: BorderStyle.none,
                          color: AppColor.darkGrey),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    fillColor: AppColor.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _paymentContainer() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: AppColor.whiteColor,
        ),
        child: Column(
          children: [
            VerticalSpacing(height: 0.01),
            Center(
              child: Text(
                'Payment Method',
                style: TextStyle(
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w400,
                    color: AppColor.redColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.payments_outlined,
                    color: AppColor.darkGrey,
                    size: 20,
                  ),
                  HorizontalSpacing(width: 0.01),
                  Text(
                    'Cash on delivery ',
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: FontSize.l,
                        fontWeight: FontWeight.w500),
                  ),
                  Radio(
                    value: 1,
                    groupValue: selectedRadio,
                    onChanged: (val) {
                      print("Radio $val");
                      setSelectedRadio(val);
                    },
                    activeColor: AppColor.redColor,
                  ),
                  Radio(
                    value: 2,
                    groupValue: selectedRadio,
                    onChanged: (val) {
                      print("Radio $val");
                      setSelectedRadio(val);
                    },
                    activeColor: AppColor.redColor,
                  ),
                  Icon(
                    Icons.credit_card,
                    color: AppColor.darkGrey,
                    size: 20,
                  ),
                  HorizontalSpacing(width: 0.01),
                  Text(
                    'Credit card ',
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: FontSize.l,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  _orderButton() {
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
              onPressed: ()=>_navigationService.navigateTo(NavigationRouter.receivedOrder),
              child: Text(
                'PLACE ORDER',
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
