import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  _MainDrawer createState() => _MainDrawer();
}

class _MainDrawer extends State<MainDrawer> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(16.0),
              color: AppColor.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(height: 0.02),
                  Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.whiteColor),
                        child: Center(
                          child: Text(
                            'U',
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: FontSize.xxxxxxl,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Usman Sukhera',
                    style: TextStyle(
                        fontSize: FontSize.l,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Usman1sukhera@gmail.com',
                    style: TextStyle(
                      fontSize: FontSize.l,
                      color: AppColor.whiteColor,
                    ),
                  )
                ],
              )),
          Flexible(child: Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lock_clock,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    HorizontalSpacing(width: 0.08),
                    InkWell(
                      child: Text(
                        'My Orders',
                        style: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xxl),
                      ),
                      onTap: () => _navigationService
                          .navigateTo(NavigationRouter.myOrderView),
                    )
                  ],
                ),
                VerticalSpacing(height: 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    HorizontalSpacing(width: 0.08),
                    InkWell(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xxl),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
                VerticalSpacing(height: 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    HorizontalSpacing(width: 0.08),
                    InkWell(
                      child: Text(
                        'Wallet',
                        style: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xxl),
                      ),
                      onTap: () => _navigationService
                          .navigateTo(NavigationRouter.walletView),
                    )
                  ],
                ),
                VerticalSpacing(height: 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    HorizontalSpacing(width: 0.08),
                    InkWell(
                      child: Text(
                        'My Address',
                        style: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xxl),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
                VerticalSpacing(height: 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.notifications_none_rounded,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    HorizontalSpacing(width: 0.08),
                    InkWell(
                      child: Text(
                        'Notification',
                        style: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xxl),
                      ),
                      onTap: () => _navigationService
                          .navigateTo(NavigationRouter.notificationView),
                    )
                  ],
                ),
                VerticalSpacing(height: 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    HorizontalSpacing(width: 0.08),
                    InkWell(
                      child: Text(
                        'Call Us',
                        style: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xxl),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
                VerticalSpacing(height: 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.wb_incandescent_outlined,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    HorizontalSpacing(width: 0.08),
                    InkWell(
                      child: Text(
                        'Any Suggestion',
                        style: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xxl),
                      ),
                      onTap: () => _navigationService
                          .navigateTo(NavigationRouter.suggestScreen),
                    )
                  ],
                ),
                VerticalSpacing(height: 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    HorizontalSpacing(width: 0.08),
                    InkWell(
                      child: Text(
                        'Share & Earn',
                        style: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xxl),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
                VerticalSpacing(height: 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    HorizontalSpacing(width: 0.08),
                    InkWell(
                      child: Text(
                        'Terms & Conditions',
                        style: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xxl),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
                Flexible(child: Container()),
                Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: AppColor.primaryColor,
                      size: 28,
                    ),
                    HorizontalSpacing(width: 0.08),
                    InkWell(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xxl),
                      ),
                      onTap: () => _navigationService
                          .navigateTo(NavigationRouter.landingScreen),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
