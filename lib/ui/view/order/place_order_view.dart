import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/user_info_model.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/place_order_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/error_view.dart';
import 'package:fresh9_rider/ui/widget/horizontal_spacing.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PlaceOrder extends StatefulWidget {
  String orderAmount;
  PlaceOrder(this.orderAmount);
  _PlaceOrder createState() => _PlaceOrder();
}

class _PlaceOrder extends State<PlaceOrder> {
  final List<String> _dropDownValues = ['Today', 'Tomorrow'];
  final TextEditingController _instructionsController =
      new TextEditingController();

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
              onPressed: () => _navigationService.goBack()),
          title: Text(
            'Place Order',
            style: TextStyle(color: AppColor.darkGrey),
          ),
        ),
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: ViewModelBuilder.reactive(
                viewModelBuilder: () => PlaceOrderViewModel(),
                onModelReady: (model) => {},
                builder: (context, PlaceOrderViewModel model, child) {
                  return model.state == ViewState.loading
                      ? Loading.normalLoading()
                      : model.state == ViewState.error
                          ? ErrorView(
                              text: model.serverError,
                              onPressed: () => model.getStore(),
                            )
                          : ListView(
                              children: [
                                Column(
                                  children: [
                                    VerticalSpacing(height: 0.03),
                                    _totalBillCard(widget.orderAmount, model),
                                    VerticalSpacing(height: 0.02),
                                    model.userInfoModel == null
                                        ? CircularProgressIndicator()
                                        : _contactCard(
                                            model.userInfoModel, model),
                                    VerticalSpacing(height: 0.02),
                                    _deliveryScheduleCard(model),
                                    VerticalSpacing(height: 0.02),
                                    _deliveryInstructionContainer(),
                                    VerticalSpacing(height: 0.02),
                                    _paymentContainer(),
                                    VerticalSpacing(height: 0.04),
                                    _orderButton(model),
                                    VerticalSpacing(height: 0.05),
                                  ],
                                )
                              ],
                            );
                })));
  }

  _totalBillCard(String total, PlaceOrderViewModel model) {
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
                'Grand Total',
                style:
                    TextStyle(color: AppColor.blackColor, fontSize: FontSize.l),
              ),
              Text(
                'Rs. ' +
                    ((int.tryParse(total) -
                                    model.userInfoModel.wallet -
                                    model.userInfoModel.voucher) <
                                0
                            ? 0
                            : (int.tryParse(total) -
                                model.userInfoModel.wallet -
                                model.userInfoModel.voucher))
                        .toString(),
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

  _contactCard(UserInfoModel userInfoModel, PlaceOrderViewModel model) {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
//        height: MediaQuery.of(context).size.height / 2.9,
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
                  new Flexible(
                    child: new TextFormField(
                      initialValue: userInfoModel.fullname,
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
//                      hintText: 'Usman Sukhera',
                        hintStyle: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xl),
                      ),
                    ),
                  ),
                  HorizontalSpacing(
                    width: 0.07,
                  ),
                ]),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.phone,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                new Flexible(
                  child: new TextFormField(
                      initialValue: userInfoModel.cell,
                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
//                          hintText: '03017316943',
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
                    onPressed: () {
                      _navigationService
                          .navigateToAndBack(NavigationRouter.profileView)
                          .then((value) => model.getUser());
                    })
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
                  width: 250,
                  child: new TextFormField(
                      initialValue: userInfoModel.email,
                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
//                          hintText: 'usman1sukhera@gmail.com',
                          hintStyle: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.xl))),
                ),
              ],
            ),
            VerticalSpacing(height: 0.02),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 1,
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
                    Icons.location_on_outlined,
                    color: AppColor.darkGrey,
                    size: 20,
                  ),
                  new Flexible(
                    child: new TextFormField(
                      initialValue: userInfoModel
                          .addressesList[model.deliveryAddressIndex].address,
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
//                        hintText: 'House# 535 Block A',
                        hintStyle: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xl),
                      ),
                    ),
                  ),
                  HorizontalSpacing(width: 0.07),
                ]),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.home,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                new Flexible(
                  child: new TextFormField(
                      initialValue: userInfoModel
                          .addressesList[model.deliveryAddressIndex]
                          .houseNumber,
                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
//                          hintText: 'Lahore',
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
                    onPressed: () {
                      _navigationService
                          .navigateToAndBack(NavigationRouter.addressView,
                              arguments: true)
                          .then((value) =>
                              model.updateDeliveryAddressIndex(value));
                    })
              ],
            ),
            Row(
              children: [
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.all_inbox_rounded,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                HorizontalSpacing(width: 0.02),
                Flexible(
                  child: new TextFormField(
                      initialValue: userInfoModel
                          .addressesList[model.deliveryAddressIndex]
                          .instructions,
                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
//                          hintText: 'Central park housing scheme',
                          hintStyle: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.xl))),
                ),
                HorizontalSpacing(width: 0.06)
              ],
            ),
            VerticalSpacing(height: 0.02)
          ],
        ),
      ),
    );
  }

  _deliveryScheduleCard(PlaceOrderViewModel model) {
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
                  Flexible(
                      child: DropdownButtonHideUnderline(
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
                              model.currentlySelected = value;
                            });
                            model.updateDay(model.currentlySelected);
                          },
                          isExpanded: false,
                          value: model.currentlySelected,
                          hint: Text(
                            'Today',
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )),
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
                  Flexible(
                      child: DropdownButtonHideUnderline(
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
                          items: model.timings
                              .map((value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (String value) {
                            setState(() {
                              model.selectedTime = value;
                            });
                          },
//                          isExpanded: false,

                          value: model.selectedTime,
                          hint: Text(
                            'Time',
                          ),
                          style: TextStyle(
                              fontSize: FontSize.s, color: Colors.black),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _deliveryInstructionContainer() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _instructionsController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: InputDecoration(
                    hintText: "e.g Please call don't ring the doorbell",
                    hintStyle: TextStyle(
                        fontSize: FontSize.l, color: AppColor.normalGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
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
            VerticalSpacing(height: 0.02),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: AppColor.whiteColor,
        ),
        child: Column(
          children: [
            VerticalSpacing(height: 0.01),
            Center(
              child: Text(
                'Payment Methods',
                style: TextStyle(
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w400,
                    color: AppColor.redColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      fontSize: FontSize.xl,
                    ),
                  ),
//Flexible(child: Container()),
//                  Transform.scale(
//                      scale: 1.5,
//                      child: Radio(
//                        value: 1,
//                        groupValue: 1,
//                        onChanged: (val) {
//                          print("Radio $val");
//                          setSelectedRadio(val);
//                        },
//                        activeColor: AppColor.redColor,
//                      )),
//                  Transform.scale(
//                      scale: 1.5,
//                      child: Radio(
//                        value: 2,
//                        groupValue: selectedRadio,
//                        onChanged: (val) {
//                          Dialog errorDialog = Dialog(
//                            shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(
//                                    12.0)), //this right here
//                            child: Container(
//                              height: 200.0,
//                              width: 300.0,
//                              child: Column(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: <Widget>[
//                                  Padding(
//                                    padding: EdgeInsets.all(15.0),
//                                    child: Text(
//                                      'Sorry',
//                                      style: TextStyle(
//                                          color: Colors.red,
//                                          fontSize: FontSize.xxxl),
//                                    ),
//                                  ),
//                                  Padding(
//                                    padding: EdgeInsets.all(15.0),
//                                    child: Text(
//                                      'Credit card facility coming soon!',
//                                      style: TextStyle(
//                                          color: Colors.red,
//                                          fontSize: FontSize.xl),
//                                    ),
//                                  ),
//                                  Padding(padding: EdgeInsets.only(top: 20.0)),
//                                  ElevatedButton(
//                                      onPressed: () {
//                                        Navigator.of(context).pop();
//                                      },
//                                      child: Text(
//                                        'Okay don\'t worry!',
//                                        style: TextStyle(
//                                            color: Colors.white,
//                                            fontSize: 18.0),
//                                      ))
//                                ],
//                              ),
//                            ),
//                          );
//                          showDialog(
//                              context: context,
//                              builder: (BuildContext context) => errorDialog);
////                      print("Radio $val");
////                      setSelectedRadio(val);
//                        },
//                        activeColor: AppColor.redColor,
//                      )),
                  HorizontalSpacing(width: 0.01),
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
                      fontSize: FontSize.xl,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                      scale: 1.5,
                      child: Radio(
                        value: 1,
                        groupValue: 1,
                        onChanged: (val) {
                          print("Radio $val");
                          setSelectedRadio(val);
                        },
                        activeColor: AppColor.redColor,
                      )),
                  HorizontalSpacing(width: 0.1),
                  Transform.scale(
                      scale: 1.5,
                      child: Radio(
                        value: 2,
                        groupValue: selectedRadio,
                        onChanged: (val) {
                          Dialog errorDialog = Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0)), //this right here
                            child: Container(
                              height: 230.0,
                              width: 300.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      'Sorry',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: FontSize.xxxl),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      'Credit card facility coming soon!',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: FontSize.xl),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 20.0)),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Okay don\'t worry!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ))
                                ],
                              ),
                            ),
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => errorDialog);
//                      print("Radio $val");
//                      setSelectedRadio(val);
                        },
                        activeColor: AppColor.redColor,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _orderButton(PlaceOrderViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
//      width: MediaQuery.of(context).size.width / 0.8,
      child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width / 0.8,
          child: Material(
            elevation: 7.0,
            borderRadius: BorderRadius.circular(10.0),
            color: model.loader ? null : AppColor.blackColor,
            child: Container(
              decoration: BoxDecoration(
                color: model.loader ? null : AppColor.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: model.loader
                  ? CircularProgressIndicator()
                  : FlatButton(
                      color: AppColor.primaryColor,
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'PLACE ORDER',
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: FontSize.xl,
                                fontWeight: FontWeight.w500),
                          ),
                          Flexible(child: Container()),
                          Icon(
                            Icons.east,
                            color: Colors.white,
                          )
                        ],
                      ),
                      onPressed: () {
//                  print(model.userInfoModel);
                        model.submitOrder(
                            widget.orderAmount,
                            context,
                            model.currentlySelected,
                            _instructionsController.text);
                      },
//                onPressed: () => _navigationService
//                    .navigateTo(NavigationRouter.orderPlacedView),
                    ),
            ),
          )),
    );
  }
}
