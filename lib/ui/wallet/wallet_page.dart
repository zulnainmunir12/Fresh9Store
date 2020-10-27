import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  _WalletPage createState() => _WalletPage();
}

class _WalletPage extends State<WalletPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
          ),
          onPressed: ()=>_navigationService.navigateTo(NavigationRouter.myOrder),
        ),
        title: Text(
          'Wallet',
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
        child: Column(
          children: [
            VerticalSpacing(height: 0.04),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PKR',
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: FontSize.xxxxl,
                        fontWeight: FontWeight.w500),
                  ),
                  RichText(
                    text: TextSpan(
                        text: '50',
                        style: TextStyle(
                            color: AppColor.secondaryColor,
                            fontSize: FontSize.xxxxxxl,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                              text: '.00',
                              style: TextStyle(
                                  color: AppColor.secondaryColor,
                                  fontSize: FontSize.l)),
                        ]),
                  ),
                ],
              ),
            ),
            Text(
              'Available Balance',
              style: TextStyle(
                  color: AppColor.darkGrey,
                  fontSize: FontSize.xxxl,
                  fontWeight: FontWeight.w500),
            ),
            VerticalSpacing(height: 0.04),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Vouchers',style: TextStyle(
                  color: AppColor.darkGrey,
                  fontSize: FontSize.xxl,
                  fontWeight: FontWeight.w500
                ),),
                VerticalSpacing(height: 0.001),
                Text('pkr 50.00',style: TextStyle(
                    color: AppColor.secondaryColor,
                    fontSize: FontSize.l,
                    fontWeight: FontWeight.w500
                ),),
                  VerticalSpacing(height: 0.001),
                Text('Expire in 7 days',style: TextStyle(
                    color: AppColor.redColor,
                    fontSize: FontSize.l,
                    fontWeight: FontWeight.w500
                ),)],
              ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Your Balance',style: TextStyle(
                      color: AppColor.darkGrey,
                      fontSize: FontSize.xxl,
                      fontWeight: FontWeight.w500
                  ),),
                    VerticalSpacing(height: 0.001),
                    Text('pkr 0.00',style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: FontSize.l,
                        fontWeight: FontWeight.w500
                    ),),
                    VerticalSpacing(height: 0.001),
                    Text('No Expiry',style: TextStyle(
                        color: AppColor.redColor,
                        fontSize: FontSize.l,
                        fontWeight: FontWeight.w500
                    ),)],
                )],),
            )
          ],
        ),
      ),
    );
  }
}
