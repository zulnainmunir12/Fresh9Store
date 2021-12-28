import 'package:fresh9_rider/core/model/order_model.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  OrderModel order;
  OrderDetailPage(this.order);
  _ArrivedOrder createState() => _ArrivedOrder();
}

class _ArrivedOrder extends State<OrderDetailPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  int total = 0;

  calculateDeliveryFee() {
    total = 0;
    widget.order.products.forEach((element) {
      if (element.discountedPrice != null && element.discountedPrice != 0)
        total += (element.discountedPrice * element.quantity);
      else
        total += (element.retailPrice * element.quantity);
    });

    print("testing vals");
    print(widget.order.wallet);
    print(widget.order.total);
    print(total);
    return widget.order.total == 0
        ? (widget.order.wallet - total).toString()
        : ((widget.order.total - total) <= 0
                ? (widget.order.total - total) +
                    (widget.order.wallet == null ? 0 : widget.order.wallet)
                : (widget.order.total - total))
            .toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.order.orderType);
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
            'Order Details (' + widget.order.id.substring(0, 8) + ")",
            style: TextStyle(color: AppColor.darkGrey),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Text(
                widget.order.storeName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.order.orderStatus.substring(0, 1).toUpperCase() +
                    widget.order.orderStatus.substring(1),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: AppColor.primaryColor,
              ),
              widget.order.orderType == 'Store'
                  ? Container()
                  : Text(
                      widget.order.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: FontSize.xl, fontWeight: FontWeight.bold),
                    ),
              widget.order.orderType == 'Store'
                  ? Flexible(
                      child: ListView.builder(
                      itemCount: widget.order.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    widget.order.products[index].quantity
                                            .toString() +
                                        " * " +
                                        widget.order.products[index].name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Text(
                                  "Rs. " +
                                      (widget.order.products[index].quantity *
                                              widget.order.products[index]
                                                  .discountedPrice)
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Divider()
                          ],
                        );
                      },
                    ))
                  : Flexible(child: Text(widget.order.instructions)),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: AppColor.primaryColor,
              ),
              widget.order.orderType == 'Store'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Fee: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Rs. " + calculateDeliveryFee(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          color: AppColor.primaryColor,
          height: widget.order.orderType == 'Store' ? 50 : 0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total: ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColor.whiteColor),
              ),
              Text(
                "Rs. " + widget.order.total.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColor.whiteColor),
              ),
            ],
          ),
        ));
  }
}
