import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/wallet_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WalletView extends StatefulWidget {
  _WalletPage createState() => _WalletPage();
}

class _WalletPage extends State<WalletView> {
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
            onPressed: () => _navigationService.goBack(),
          ),
          title: Text(
            'Wallet',
            style: TextStyle(color: AppColor.darkGrey),
          ),
        ),
        body: ViewModelBuilder.reactive(
            viewModelBuilder: () => WalletViewModel(),
            onModelReady: (WalletViewModel model) {
//            model.nameController.text = model.userInfoModel.fullname;
            },
            builder: (context, WalletViewModel model, child) {
              return model.state == ViewState.loading
                  ? Loading.normalLoading()
                  : Column(
                      children: [
                        VerticalSpacing(height: 0.03),
                        Center(
                          child: _itemCard(model.userInfoModel.wallet,
                              model.userInfoModel.voucher),
                        )
                      ],
                    );
            }));
  }

  _itemCard(int wallet, int voucher) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      elevation: 5.0,
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
//        height: MediaQuery.of(context).size.height / 3,
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
                        fontSize: FontSize.xl,
                        fontWeight: FontWeight.w500),
                  ),
                  RichText(
                    text: TextSpan(
                        text: (wallet + voucher).toString(),
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
                  fontSize: FontSize.l,
                  fontWeight: FontWeight.w500),
            ),
            VerticalSpacing(height: 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vouchers',
                        style: TextStyle(
                            color: AppColor.darkGrey,
                            fontSize: FontSize.l,
                            fontWeight: FontWeight.w500),
                      ),
                      VerticalSpacing(height: 0.001),
                      Text(
                        'PKR ' + voucher.toString() + '.00',
                        style: TextStyle(
                            color: AppColor.secondaryColor,
                            fontSize: FontSize.m,
                            fontWeight: FontWeight.w500),
                      ),
                      VerticalSpacing(height: 0.001),
                      Text(
                        'Expire in 7 days',
                        style: TextStyle(
                            color: AppColor.redColor,
                            fontSize: FontSize.m,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Balance',
                        style: TextStyle(
                            color: AppColor.darkGrey,
                            fontSize: FontSize.l,
                            fontWeight: FontWeight.w500),
                      ),
                      VerticalSpacing(height: 0.001),
                      Text(
                        'PKR ' + wallet.toString() + '.00',
                        style: TextStyle(
                            color: AppColor.secondaryColor,
                            fontSize: FontSize.m,
                            fontWeight: FontWeight.w500),
                      ),
                      VerticalSpacing(height: 0.001),
                      Text(
                        'No Expiry',
                        style: TextStyle(
                            color: AppColor.redColor,
                            fontSize: FontSize.m,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),
            VerticalSpacing(height: 0.02),
          ],
        ),
      ),
    );
  }
}
