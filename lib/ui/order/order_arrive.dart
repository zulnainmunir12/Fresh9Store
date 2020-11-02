import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/order/my_order.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArrivedOrder extends StatefulWidget {
  _ArrivedOrder createState() => _ArrivedOrder();
}

class _ArrivedOrder extends State<ArrivedOrder> {
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
          onPressed: ()=>_navigationService.navigateTo(NavigationRouter.myOrder)
        ),
        title: Text(
          'My Orders',
          style: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      body: Column(
        children: [
          VerticalSpacing(height: 0.03),
          Center(
            child: _container(),
          ),
        ],
      ),
    );
  }

  _container() {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      elevation: 5.0,
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Center(
          child: Column(
            children: [
              VerticalSpacing(
                height: 0.01,
              ),
              Text(
                'Order No',
                style: TextStyle(
                    color: AppColor.darkGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.xxl),
              ),
              Text(
                '65646',
                style: TextStyle(
                    color: AppColor.darkGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.xxl),
              ),
              Text(
                'Arrives in 4 pm Monday 12/08/20',
                style: TextStyle(
                    color: AppColor.darkGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.xxl),
              ),
              VerticalSpacing(height: 0.0),
              _radioButton(),
              VerticalSpacing(height: 0.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_orderButton(), _cancelButton()],
              )
            ],
          ),
        ),
      ),
    );
  }

  _orderButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        elevation: 7.0,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        color: AppColor.whiteColor,
        child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.shortestSide * 0.33,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(30),
              )),
              onPressed: ()=>_navigationService.navigateTo(NavigationRouter.placeOrder),
              padding: EdgeInsets.all(15.0),
              child: Text(
                'View order',
                style: TextStyle(
                    color: AppColor.secondaryColor, fontSize: FontSize.xxl),
              ),
              color: AppColor.whiteColor,
            )),
      ),
    );
  }

  _radioButton() {
    return Padding(
      padding: EdgeInsets.all(10),
      child:
         Column(
           children: [
             RadioListTile(
              value: 1,
              groupValue: selectedRadio,
              activeColor: AppColor.secondaryColor,
              onChanged: (val) {
                print("Radio $val");
                setSelectedRadio(val);
              },
              title: Text('Accepted'),
              selected: true,
        ),
           ],
         ),
    );
  }

  _cancelButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        elevation: 7.0,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        color: AppColor.whiteColor,
        child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.shortestSide * 0.33,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(30),
              )),
              onPressed: () {},
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Cancel order',
                style:
                    TextStyle(color: AppColor.redColor, fontSize: FontSize.xxl),
              ),
              color: AppColor.whiteColor,
            )),
      ),
    );
  }
}
