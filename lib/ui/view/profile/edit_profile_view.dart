import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/widget/horizontal_spacing.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfileView> {
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
            onPressed: () =>
                _navigationService.navigateTo(NavigationRouter.profileView)),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: ListView(
            children: [
              Center(
                child: _editCard(),
              ),
              VerticalSpacing(height: 0.2),
              _image()
            ],
          )),
    );
  }

  _editCard() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1,
        // height: MediaQuery.of(context).size.height/3,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Column(
          children: [
            VerticalSpacing(height: 0.01),
            Row(
              children: [
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.account_circle_outlined,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                HorizontalSpacing(width: 0.01),
                new Flexible(
                  child: SizedBox(
                    width: 150,
                    child: new TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Usman',
                        hintStyle: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xl),
                      ),
                    ),
                  ),
                ),
                HorizontalSpacing(width: 0.02),
                new Flexible(
                  child: SizedBox(
                    width: 150,
                    child: new TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Sukhera',
                            hintStyle: TextStyle(
                                color: AppColor.darkGrey,
                                fontSize: FontSize.xl))),
                  ),
                ),
              ],
            ),
            VerticalSpacing(height: 0.01),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.phone,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                HorizontalSpacing(width: 0.01),
                new Flexible(
                  child: SizedBox(
                    width: 150,
                    child: new TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: '03017316943',
                            hintStyle: TextStyle(
                                color: AppColor.darkGrey,
                                fontSize: FontSize.xl))),
                  ),
                ),
                HorizontalSpacing(width: 0.02),
                new Flexible(
                  child: SizedBox(
                    width: 150,
                    child: new TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: '03017316943',
                            hintStyle: TextStyle(
                                color: AppColor.lightestGrey,
                                fontSize: FontSize.xl))),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.mail_outline,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                HorizontalSpacing(width: 0.01),
                SizedBox(
                  width: 320,
                  child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          hintText: 'usman1sukhera@gmail.com',
                          hintStyle: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.xl))),
                ),
              ],
            ),
            VerticalSpacing(height: 0.01),
            _updateButton(),
            VerticalSpacing(height: 0.02),
          ],
        ),
      ),
    );
  }

  _updateButton() {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.width * 0.3,
        child: FlatButton(
          color: AppColor.redColor,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
          onPressed: () {},
          child: Text(
            'Update',
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: FontSize.l,
            ),
          ),
        ));
  }

  _image() {
    return Center(
      child: Image.asset(
        'assets/image/p_logo.png',
        height: 100,
      ),
    );
  }
}
