import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/view/order/no_order_view.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.primaryColor,
            ),
            onPressed: () =>
                _navigationService.goBack()),
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
              '65646',
              style: TextStyle(
                  color: AppColor.darkGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.l),
            ),
            Text(
              'Arrives in 4 pm Monday 12/08/20',
              style: TextStyle(
                  color: AppColor.darkGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.l),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _radioButton(1, "Accepted"),
                _radioButton(2, "Packed"),
                _radioButton(3, "On Way"),
                _radioButton(4, "Delivered"),
              ],
            ),
            VerticalSpacing(
              height: 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_orderButton(), _cancelButton()],
            ),
            VerticalSpacing(
              height: 0.02,
            ),
          ],
        ),
      ),
    );
  }

  _orderButton() {
    return ButtonTheme(
        minWidth: 120,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
          onPressed: () {},
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
            groupValue: selectedRadio,
            activeColor: AppColor.secondaryColor,
            onChanged: (val) {
              print("Radio $val");
              setSelectedRadio(val);
            },
          ),
          Text(
            title,
            style: TextStyle(
                color: groupValue == selectedRadio
                    ? AppColor.secondaryColor
                    : AppColor.blackColor),
          ),
        ],
      ),
    );
  }

  void errorDialog (BuildContext context){
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 150.0,
        width: 300.0,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.only(top:1),
              child: Text('Do you want to cancel', style: TextStyle(fontSize: FontSize.l),),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom:10),
              child: Text('Order # 65646', style: TextStyle(fontSize: FontSize.xl),),
            ),
            VerticalSpacing(height: 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                onPressed: (){
              Navigator.pop(context);
            },
                child: Text('No', style: TextStyle(color: AppColor.greenColor, fontSize: FontSize.l),)),
            OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                onPressed: (){
              Navigator.pop(context);
            },
                child: Text('Yes', style: TextStyle(color: AppColor.redColor, fontSize: FontSize.l),)),],)
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);

 }

  _cancelButton() {
    return ButtonTheme(
        minWidth: 120,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
          onPressed: () {
            errorDialog(context);
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
