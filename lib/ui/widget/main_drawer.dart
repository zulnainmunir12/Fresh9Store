import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/viewmodel/drawer_view_model.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatefulWidget {
  _MainDrawer createState() => _MainDrawer();
}

class _MainDrawer extends State<MainDrawer> {
  onModelReady(model) {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ViewModelBuilder.reactive(
            viewModelBuilder: () => DrawerViewModel(),
            onModelReady: (model) => onModelReady(model),
            builder: (context, DrawerViewModel model, child) {
              return model.state == ViewState.loading
                  ? Loading.normalLoading()
                  : Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(16.0),
                            color: AppColor.primaryColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VerticalSpacing(height: 0.03),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.white,
                                      child: model.userInfoModel == null
                                          ? Center(
                                              child: Text(
                                                "FS",
                                                style: TextStyle(
                                                    color:
                                                        AppColor.primaryColor,
                                                    fontSize: FontSize.xxxxxxl,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          : model.userInfoModel.imageUrl != null
                                              ? CachedNetworkImage(
                                                  imageUrl: model
                                                      .userInfoModel.imageUrl,
                                                  placeholder: (context, url) =>
                                                      Loading.imageLoading(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset("assets/image/placeholder.jpeg"),
                                                  fit: BoxFit.fitHeight,
                                                )
                                              : Center(
                                                  child: Text(
                                                    model.userInfoModel.fullname
                                                        .substring(0, 1),
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .primaryColor,
                                                        fontSize:
                                                            FontSize.xxxxxxl,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                    )
                                  ],
                                ),
                                model.userInfoModel == null
                                    ? Container()
                                    : Text(
                                        model.userInfoModel.fullname,
                                        style: TextStyle(
                                            fontSize: FontSize.l,
                                            color: AppColor.whiteColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                model.userInfoModel == null
                                    ? Container()
                                    : Text(
                                        model.userInfoModel.email,
                                        style: TextStyle(
                                          fontSize: FontSize.l,
                                          color: AppColor.whiteColor,
                                        ),
                                      )
                              ],
                            )),
                        Flexible(
                            child: Container(
//                          margin: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              model.userInfoModel == null
                                  ? Container()
                                  : ListTile(
                                      title: Text(
                                        'My Orders',
                                        style: TextStyle(
                                            color: AppColor.darkGrey,
                                            fontSize: FontSize.xxl),
                                      ),
                                      onTap: () => model.navigateToPage(
                                          NavigationRouter.myOrderView),
                                      leading: Icon(
                                        Icons.date_range,
                                        color: AppColor.primaryColor,
                                        size: 28,
                                      ),
                                    ),
                              model.userInfoModel == null
                                  ? Container()
                                  : ListTile(
                                      title: Text(
                                        'My Profile',
                                        style: TextStyle(
                                            color: AppColor.darkGrey,
                                            fontSize: FontSize.xxl),
                                      ),
                                      onTap: () => model.navigateToPage(
                                          NavigationRouter.profileView),
                                      leading: Icon(
                                        Icons.account_circle_outlined,
                                        color: AppColor.primaryColor,
                                        size: 28,
                                      ),
                                    ),
                              model.userInfoModel == null
                                  ? Container()
                                  : ListTile(
                                      title: Text(
                                        'Wallet',
                                        style: TextStyle(
                                            color: AppColor.darkGrey,
                                            fontSize: FontSize.xxl),
                                      ),
                                      onTap: () => model.navigateToPage(
                                          NavigationRouter.walletView),
                                      leading: Icon(
                                        Icons.account_balance_wallet_outlined,
                                        color: AppColor.primaryColor,
                                        size: 28,
                                      ),
                                    ),
                              model.userInfoModel == null
                                  ? Container()
                                  : ListTile(
                                      title: Text(
                                        'My Address',
                                        style: TextStyle(
                                            color: AppColor.darkGrey,
                                            fontSize: FontSize.xxl),
                                      ),
                                      onTap: () => model.navigateToPage(
                                          NavigationRouter.addressView),
                                      leading: Icon(
                                        Icons.home_outlined,
                                        color: AppColor.primaryColor,
                                        size: 28,
                                      ),
                                    ),
                              ListTile(
                                title: Text(
                                  'Call Us',
                                  style: TextStyle(
                                      color: AppColor.darkGrey,
                                      fontSize: FontSize.xxl),
                                ),
                                onTap: () => launch("tel:+923111771118"),
                                leading: Icon(
                                  Icons.phone,
                                  color: AppColor.primaryColor,
                                  size: 28,
                                ),
                              ),
                              model.userInfoModel == null
                                  ? Container()
                                  : ListTile(
                                      title: Text(
                                        'Any Suggestions',
                                        style: TextStyle(
                                            color: AppColor.darkGrey,
                                            fontSize: FontSize.xxl),
                                      ),
                                      onTap: () => model.navigateToPage(
                                          NavigationRouter.suggestScreen),
                                      leading: Icon(
                                        Icons.wb_incandescent_outlined,
                                        color: AppColor.primaryColor,
                                        size: 28,
                                      ),
                                    ),
                              ListTile(
                                title: Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                      color: AppColor.darkGrey,
                                      fontSize: FontSize.xxl),
                                ),
                                onTap: () => model.navigateToPage(
                                    NavigationRouter.privacyPolicy),
                                leading: Icon(
                                  Icons.privacy_tip_outlined,
                                  color: AppColor.primaryColor,
                                  size: 28,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Terms & Conditions',
                                  style: TextStyle(
                                      color: AppColor.darkGrey,
                                      fontSize: FontSize.xxl),
                                ),
                                onTap: () => model.navigateToPage(
                                    NavigationRouter.termsScreen),
                                leading: Icon(
                                  Icons.content_copy,
                                  color: AppColor.primaryColor,
                                  size: 28,
                                ),
                              ),
                              Flexible(child: Container()),
                              ListTile(
                                title: Text(
                                  model.userInfoModel == null
                                      ? 'Login'
                                      : 'Logout',
                                  style: TextStyle(
                                      color: AppColor.darkGrey,
                                      fontSize: FontSize.xxl),
                                ),
                                onTap: () async {
                                  SharedPreferences sharedPreference =
                                      await SharedPreferences.getInstance();
                                  sharedPreference.clear();
                                  if (model.userInfoModel == null)
                                    model.logoutNavigate(
                                        NavigationRouter.enterNumberScreen);
                                  else
                                    model.logoutNavigate(
                                        NavigationRouter.landingScreen);
                                },
                                leading: Icon(
                                  model.userInfoModel == null
                                      ? Icons.login
                                      : Icons.exit_to_app,
                                  color: AppColor.primaryColor,
                                  size: 28,
                                ),
                              ),
                              VerticalSpacing(height: 0.01)
                            ],
                          ),
                        ))
                      ],
                    );
            }));
  }
}
