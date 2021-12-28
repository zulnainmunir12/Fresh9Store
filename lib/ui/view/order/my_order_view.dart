import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/order_model.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:fresh9_rider/core/viewmodel/order_view_model.dart';

class MyOrderView extends StatefulWidget {
  _ArrivedOrder createState() => _ArrivedOrder();
}

class _ArrivedOrder extends State<MyOrderView> {
  final NavigationService _navigationService = locator<NavigationService>();
  int selectedRadio;

  void initState() {
    super.initState();
    selectedRadio = 1;
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
//        leading: IconButton(
//            icon: Icon(
//              Icons.arrow_back,
//              color: AppColor.primaryColor,
//            ),
//            onPressed: () => _navigationService
//                .navigateToAndClearAll(NavigationRouter.appServices)),
        title: Text(
          'My Orders',
          style: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      body: ViewModelBuilder.reactive(
          viewModelBuilder: () => OrderViewModel(),
          onModelReady: (model) {},
          builder: (context, OrderViewModel model, child) {
            return model.state == ViewState.loading
                ? Loading.normalLoading()
                : Container(
//              color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        VerticalSpacing(height: 0.03),
                        Flexible(
                            child: model.orderList.length == 0
                                ? Column(
                                    children: [
                                      VerticalSpacing(height: 0.2),
                                      Center(
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/image/order_emoji.png',
                                              height: 150,
                                            ),
                                            VerticalSpacing(height: 0.02),
                                            Text(
                                              'No orders yet',
                                              style: TextStyle(
                                                  color: AppColor.darkGrey,
                                                  fontSize: FontSize.xxxxl),
                                            )
                                          ],
                                        ),
                                      ),
                                      Flexible(child: Container()),
                                      _shoppingButton(model),
                                      VerticalSpacing(height: 0.05),
                                    ],
                                  )
                                : ListView.builder(
                                    itemCount: model.orderList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _container(
                                          model.orderList[

                                                  index],
                                          model);
                                    })
//                        _container(),
                            ),
                      ],
                    ));
          }),
    );
  }

  _shoppingButton(OrderViewModel model) {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 1.1,
        child: Material(
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
              onPressed: () => model.navigateToAppServices(),
              child: Text(
                'START SHOPPING',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ));
  }

  _container(Map order, OrderViewModel model) {
    return InkWell(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
//      elevation: 5.0,
//      color: AppColor.blackColor,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width / 1.1,
//        height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: Column(
            children: [
              VerticalSpacing(
                height: 0.02,
              ),
              Text(
                'Order No',
                style: TextStyle(
                    color: AppColor.darkGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.l),
              ),
              Text(
                order['_id'].substring(0, 8),
                style: TextStyle(
                    color: AppColor.darkGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.l),
              ),
              Text(
                order['storeName'],
                style: TextStyle(
                    color: AppColor.darkGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.l),
              ),
              order['orderType'] == "Store"
                  ? (order['orderStatus'] == 'canceled'
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Cancelled by You",
                            style: TextStyle(
                                fontSize: FontSize.xl,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : order['orderStatus'] == 'dropped'
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Cancelled by Store",
                                style: TextStyle(
                                    fontSize: FontSize.xl,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _radioButton(
                                    order['orderStatus'] == 'pending' ? 5 : 1,
                                    "Pending"),
                                _radioButton(
                                    order['orderStatus'] == 'confirmed' ? 5 : 2,
                                    "Accepted"),
                                _radioButton(
                                    order['orderStatus'] == 'picked' ? 5 : 3,
                                    "On Way"),
                                _radioButton(
                                    order['orderStatus'] == 'delivered' ? 5 : 4,
                                    "Delivered"),
                              ],
                            ))
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            order['orderType'],
                            style: TextStyle(
                                fontSize: FontSize.xl,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            order['day'] + " : " + order['selectedTime'],
                            style: TextStyle(
                              fontSize: FontSize.l,
                            ),
                          ),
                        ],
                      ),
                    ),
              VerticalSpacing(
                height: 0.01,
              ),
              order['orderStatus'] == 'canceled'
                  ? Container()
                  : order['orderStatus'] == 'dropped'
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            order['comment'],
                            style: TextStyle(
                              fontSize: FontSize.l,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment:
                              order['orderStatus'] == 'delivered' ||
                                      order['orderType'] == 'Service'
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceEvenly,
                          children: [
                            order['orderType'] == 'Service'
                                ? Container()
                                : _orderButton(order),
                            order['orderStatus'] == 'delivered'
                                ? Container()
                                : _cancelButton(order['_id'], model)
                          ],
                        ),
              VerticalSpacing(
                height: 0.02,
              ),
            ],
          ),
        ),
      ),
      onTap: () => _navigationService.navigateToAndBack(
          NavigationRouter.orderDetailView,
          arguments: OrderModel.fromJson(order)),
    );
  }

  _orderButton(Map order) {
    return ButtonTheme(
        minWidth: 120,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
          onPressed: () => _navigationService.navigateToAndBack(
              NavigationRouter.orderDetailView,
              arguments: OrderModel.fromJson(order)),
          padding: EdgeInsets.all(15.0),
          child: Text(
            'View order',
            style:
                TextStyle(color: AppColor.secondaryColor, fontSize: FontSize.l),
          ),
          color: AppColor.whiteColor,
        ));
  }

  _radioButton(int groupValue, String title) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio(
            value: groupValue,
            groupValue: 5,
            activeColor: AppColor.secondaryColor,
            onChanged: (val) {
//              print("Radio $val");
//              setSelectedRadio(val);
            },
          ),
          Text(
            title,
            style: TextStyle(
                color: groupValue == 5
                    ? AppColor.secondaryColor
                    : AppColor.blackColor),
          ),
        ],
      ),
    );
  }

  void errorDialog(BuildContext context, String orderId, OrderViewModel model) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 150.0,
        width: 350.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 1),
              child: Text(
                'Do you want to cancel',
                style: TextStyle(fontSize: FontSize.l),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Order # ' + orderId.substring(0, 8),
                style: TextStyle(fontSize: FontSize.xl),
              ),
            ),
            VerticalSpacing(height: 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'No',
                      style: TextStyle(
                          color: AppColor.greenColor, fontSize: FontSize.l),
                    )),
                OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          color: AppColor.redColor, fontSize: FontSize.l),
                    )),
              ],
            )
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog)
        .then((value) {
      if (value == true) model.cancelOrder(orderId);
    });
  }

  _cancelButton(String orderId, OrderViewModel model) {
    return ButtonTheme(
        minWidth: 120,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
          onPressed: () {
            errorDialog(context, orderId, model);
          },
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Cancel order',
            style: TextStyle(color: AppColor.redColor, fontSize: FontSize.l),
          ),
          color: AppColor.whiteColor,
        ));
  }
}
