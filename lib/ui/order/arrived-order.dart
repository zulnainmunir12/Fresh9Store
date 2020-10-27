import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArrivedOrder extends StatefulWidget {
  _ArrivedOrder createState() => _ArrivedOrder();
}

class _ArrivedOrder extends State<ArrivedOrder> {
  List<Color> _colors = [
    //Get list of colors
    AppColor.whiteColor,
    AppColor.secondaryColor,
  ];

  int _currentIndex = 0;

  _onChanged() {
    //update with a new color when the user taps button
    int _colorCount = _colors.length;

    setState(() {
      if (_currentIndex == _colorCount - 1) {
        _currentIndex = 0;
      } else {
        _currentIndex += 1;
      }
    });

    //setState(() => (_currentIndex == _colorCount - 1) ? _currentIndex = 1 : _currentIndex += 1);
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
          )
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
                height: 0.03,
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
              VerticalSpacing(height: 0.04),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_orderButton(),_cancelButton()],
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
              onPressed: () {},
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
