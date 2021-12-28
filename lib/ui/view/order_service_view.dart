import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/order_service_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/error_view.dart';
import 'package:fresh9_rider/ui/widget/horizontal_spacing.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class OrderServiceView extends StatefulWidget {
  String title;
  OrderServiceView(this.title);
  _Electrician createState() => _Electrician();
}

class _Electrician extends State<OrderServiceView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final List<String> _dropDownValues = ['Today', 'Tomorrow'];
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _detailController = new TextEditingController();

  onModelReady(OrderServicesViewModel model) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _navigationService.goBack(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ViewModelBuilder.reactive(
              viewModelBuilder: () => OrderServicesViewModel(),
              onModelReady: (model) => onModelReady(model),
              builder: (context, OrderServicesViewModel model, child) {
                return model.state == ViewState.loading
                    ? Loading.normalLoading()
                    : model.state == ViewState.error
                        ? ErrorView(
                            text: model.serverError,
                            onPressed: () => model.determinePosition(),
                          )
                        : ListView(
                            children: [
                              VerticalSpacing(height: 0.02),
                              Center(
                                child: Text(
                                  'Whats Your Task',
                                  style: TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: FontSize.xl,
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
                                      fontSize: FontSize.xl,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              VerticalSpacing(height: 0.01),
                              _detailForm(),
                              VerticalSpacing(height: 0.01),
                              _taskScheduleCard(model),
                              VerticalSpacing(height: 0.06),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [_submitButton(model)],
                              ),
                              VerticalSpacing(height: 0.1),
                            ],
                          );
              })),
    );
  }

  _serviceCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Material(
        color: AppColor.whiteColor,
        elevation: 7.0,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(children: [
          HorizontalSpacing(width: 0.02),
          Image.asset(
            'assets/image/electrian_service.png',
            height: 18,
          ),
          HorizontalSpacing(width: 0.02),
          Flexible(
              child: TextField(
            controller: _titleController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
              fillColor: Colors.white,
              hintText: 'Task title: e.g Ac service',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
            ),
            cursorColor: AppColor.blackColor,
          ))
        ]),
      ),
    );
  }

  _detailForm() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: AppColor.blackColor,
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.message_outlined,
                        color: AppColor.whiteColor,
                        size: 16,
                      ),
                      label: Text(
                        'Text',
                        style: TextStyle(color: Colors.white),
                      ),
//                            color: AppColor.primaryColor,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(10),
//                            )
                    )),
//                    SizedBox(width: 10,),
//                    Expanded(
//                      child: ElevatedButton.icon(
//                        onPressed: () {},
//                        icon: Icon(
//                          Icons.keyboard_voice_outlined,
//                          color: AppColor.darkGrey,
//                          size: 16,
//                        ),
//                        label: Text(
//                          'Voice Note',
//                          style: TextStyle(color: AppColor.darkGrey,),
//                        ),
//                        style:  ElevatedButton.styleFrom(
//                          primary: Colors.white,
//                        ),
////                        minWidth: MediaQuery.of(context).size.width * 0.4,
////                        height: 40,
////                        color: AppColor.whiteColor,
////                        shape: RoundedRectangleBorder(
////                          borderRadius: BorderRadius.circular(10),
////                        )
//                      ),
//                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _detailController,
                    maxLines: 4,
                    decoration: InputDecoration(
                        hintText:
                            'Describe your task:e.g 2 ac services may be gas\ may b gas filling and fan dimmer',
                        border: InputBorder.none),
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

  _taskScheduleCard(OrderServicesViewModel model) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Material(
          elevation: 3,
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
                                model.updateSelectedDay(value);
                              },
                              isExpanded: false,
                              value: model.selectedDay,
                              hint: Text(
                                'Select Day',
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
                              items: model.timingList
                                  .map((value) => DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: (String value) {
                                model.updateSelectedTime(value);
                              },
                              isExpanded: false,
                              value: model.selectedTime,
                              hint: Text(
                                'Select Time',
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
        ));
  }

  _submitButton(OrderServicesViewModel model) {
    return model.loader
        ? CircularProgressIndicator()
        : ButtonTheme(
            height: 40,
            minWidth: MediaQuery.of(context).size.width * 0.9,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                if (model.userInfoModel == null)
                  model.navigateToLogin();
                else
                  model.placeOrder(context, _titleController.text,
                      _detailController.text, widget.title);
              },
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
          );
  }
}
