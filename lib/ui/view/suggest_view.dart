import 'dart:math';

import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/suggest_view_model.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

class SuggestView extends StatefulWidget {
  _SuggestViewState createState() => _SuggestViewState();
}

class _SuggestViewState extends State<SuggestView> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.primaryColor),
          onPressed: () => _navigationService.goBack(),
        ),
        title: Text(
          'Suggestion',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ViewModelBuilder.reactive(
              viewModelBuilder: () => SuggestViewModel(),
              onModelReady: (SuggestViewModel model) {
//            model.nameController.text = model.userInfoModel.fullname;
              },
              builder: (context, SuggestViewModel model, child) {
                return model.state == ViewState.loading
                    ? Loading.normalLoading()
                    : ListView(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Text(
                                    "What's Your Suggestion",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.xxl,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Material(
                                        elevation: 7.0,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: TextField(
                                          controller: model.cityController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 18.0),
                                            fillColor: Colors.white,
                                            hintText: 'Suggest City ?',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: FontSize.l),
                                            prefixIcon: Transform.rotate(
                                              angle: 180 * pi / 180,
                                              child: Icon(
                                                Icons.wb_incandescent_outlined,
                                                color: AppColor.primaryColor,
                                                size: 28,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          cursorColor: AppColor.blackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Material(
                                        elevation: 7.0,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: TextField(
                                          controller: model.areaController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 18.0),
                                            fillColor: Colors.white,
                                            hintText: 'Suggest Area ?',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: FontSize.l),
                                            prefixIcon: Transform.rotate(
                                              angle: 180 * pi / 180,
                                              child: Icon(
                                                Icons.wb_incandescent_outlined,
                                                color: AppColor.primaryColor,
                                                size: 28,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          cursorColor: AppColor.blackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Material(
                                        elevation: 7.0,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: TextField(
                                          controller: model.productController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 18.0),
                                            fillColor: Colors.white,
                                            hintText:
                                                'Suggest Restaurant and Product ?',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: FontSize.l),
                                            prefixIcon: Transform.rotate(
                                              angle: 180 * pi / 180,
                                              child: Icon(
                                                Icons.wb_incandescent_outlined,
                                                color: AppColor.primaryColor,
                                                size: 28,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          cursorColor: AppColor.blackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Material(
                                        elevation: 7.0,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: TextField(
                                          controller:
                                              model.suggestionController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 18.0),
                                            fillColor: Colors.white,
                                            hintText: 'Suggest Any More ?',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: FontSize.l),
                                            prefixIcon: Transform.rotate(
                                              angle: 180 * pi / 180,
                                              child: Icon(
                                                Icons.wb_incandescent_outlined,
                                                color: AppColor.primaryColor,
                                                size: 28,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          cursorColor: AppColor.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: model.loader
                                        ? CircularProgressIndicator()
                                        : Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 40,
                                            child: Material(
                                              elevation: 6.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              clipBehavior: Clip.antiAlias,
                                              shadowColor: Colors.black,
                                              child: MaterialButton(
                                                onPressed: () {
                                                  model.submit(
                                                      model.cityController.text,
                                                      model.areaController.text
                                                              .isEmpty
                                                          ? "N/A"
                                                          : model.areaController
                                                              .text,
                                                      model.productController
                                                              .text.isEmpty
                                                          ? "N/A"
                                                          : model
                                                              .productController
                                                              .text,
                                                      model.suggestionController
                                                          .text);
                                                },
                                                color: AppColor.primaryColor,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                child: Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                VerticalSpacing(height: 0.03)
                              ],
                            ),
                          )
                        ],
                      );
              })),
    );
  }
}
