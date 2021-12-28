import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/profile_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/horizontal_spacing.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<ProfileView> {
  final NavigationService _navigationService = locator<NavigationService>();
  bool _button = false;

  removeFocus(BuildContext context) {
    final node = FocusScope.of(context);
    node.unfocus();
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
            onPressed: () => _navigationService.goBack()),
        title: Text(
          'Profile',
          style: TextStyle(color: AppColor.darkGrey),
        ),
        actions: [],
      ),
      body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ViewModelBuilder.reactive(
              viewModelBuilder: () => ProfileViewModel(),
              onModelReady: (ProfileViewModel model) {
//            model.nameController.text = model.userInfoModel.fullname;
              },
              builder: (context, ProfileViewModel model, child) {
                return model.state == ViewState.loading
                    ? Loading.normalLoading()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: ListView(
                          children: [
                            Stack(children: [
                              _infoCard(model),
//                          Positioned(
//                              right: 0,
//                              top: 10,
//                              child: IconButton(
//                                  icon: Icon(Icons.edit,
//                                  color: _button?AppColor.primaryColor:AppColor.normalGrey,
//                                  ), onPressed: () {
//                                    setState(() {
//                                      _button=!_button;
//                                    });
//                              }))
                            ]),
                            VerticalSpacing(height: 0.1),
                            _image(),
                            VerticalSpacing(height: 0.25),
                            model.loader
                                ? Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : (model.nameController.text ==
                                            model.userInfoModel.fullname &&
                                        model.emailController.text ==
                                            model.userInfoModel.email
                                    ? Container()
                                    : _updateButton(model, context)),
                          ],
                        ),
                      );
              })),
    );
  }

  _updateButton(ProfileViewModel model, BuildContext context) {
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
              onPressed: () {
                removeFocus(context);
                model.update(
                    model.nameController.text, model.emailController.text);
              },
              child: Text(
                'Update',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ));
  }

  _infoCard(ProfileViewModel model) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      child: Container(
        width: MediaQuery.of(context).size.width,
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
//                  child: SizedBox(
//                    width: 150,
                  child: new TextFormField(
//                    initialValue: model.userInfoModel.fullname,
                    controller: model.nameController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: TextStyle(
                          color: AppColor.darkGrey, fontSize: FontSize.xl),
                    ),
                  ),
//                  ),
                ),
                HorizontalSpacing(width: 0.02),
//                new Flexible(
//                  child: SizedBox(
//                    width: 150,
//                    child: new TextField(
//                        decoration: InputDecoration(
//                            contentPadding: EdgeInsets.all(10),
//                            hintText: 'Sukhera',
//                            hintStyle: TextStyle(
//                                color: AppColor.darkGrey,
//                                fontSize: FontSize.xl))),
//                  ),
//                ),
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
                  child: new TextFormField(
                      enabled: false,
                      initialValue: model.userInfoModel.cell,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintStyle: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.xl))),
                ),
                HorizontalSpacing(width: 0.02),
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
                Flexible(
                  child: TextFormField(
                      controller: model.emailController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                          contentPadding: EdgeInsets.all(6),
                          hintStyle: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.xl))),
                ),
                HorizontalSpacing(width: 0.02),
              ],
            ),
            VerticalSpacing(height: 0.02)
          ],
        ),
      ),
    );
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
