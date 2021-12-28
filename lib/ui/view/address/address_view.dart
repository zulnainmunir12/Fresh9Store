import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/address_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/horizontal_spacing.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddressView extends StatefulWidget {
  bool choose = false;
  AddressView({this.choose = false});
  _AddressView createState() => _AddressView();
}

class _AddressView extends State<AddressView> {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AddressViewModel(),
        onModelReady: (AddressViewModel model) {
//            model.nameController.text = model.userInfoModel.fullname;
        },
        builder: (context, AddressViewModel model, child) {
          return model.state == ViewState.loading
              ? Container(
                  color: Colors.white,
                  child: Loading.normalLoading(),
                )
              : Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColor.primaryColor,
                        ),
                        onPressed: () => _navigationService
                            .goBackWithData(model.chosenAddress)),
                    title: Text(
                      'Addresses',
                      style: TextStyle(color: AppColor.darkGrey),
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => _navigationService
                        .navigateToAndBack(NavigationRouter.addAddressView,
                            arguments: model.userInfoModel.addresses)
                        .then((value) {
                      model.getAddresses();
                    }),
                    child: Icon(Icons.add),
                    backgroundColor: AppColor.primaryColor,
                  ),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: ListView.builder(
                      itemCount: model.userInfoModel.addresses.length,
                      itemBuilder: (BuildContext context, int index) {
//                        decodeAddress(model.userInfoModel.addresses[index]['loc']);
                        return _addressCard(
                          model.userInfoModel.addresses[index],
                          model,
                          index,
                          model.userInfoModel.addresses.length,
                        );
                      },
                    ),
                  ));
        });
  }

  _addressCard(Map data, AddressViewModel model, int index, int length) {
    return Stack(
      children: [
        InkWell(
            onTap: () {
              model.updateChosen(index);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Material(
                elevation: 7,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                color: AppColor.blackColor,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: widget.choose ==true
                          ? (model.chosenAddress == index
                              ? Colors.grey[300]
                              : Colors.white)
                          : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  child: Column(
                    children: [
                      VerticalSpacing(height: 0.01),
                      Row(
                        children: [
                          HorizontalSpacing(width: 0.01),
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColor.darkGrey,
                            size: 20,
                          ),
                          HorizontalSpacing(width: 0.01),
                          new Flexible(
                            child: SizedBox(
                              width: 250,
                              child: new TextFormField(
                                initialValue: data['address'],
//                      initialValue: 'Lahore',
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
//                        hintText: 'Lahore',
                                  hintStyle: TextStyle(
                                      color: AppColor.darkGrey,
                                      fontSize: FontSize.xl),
                                ),
                              ),
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
                            Icons.home,
                            color: AppColor.darkGrey,
                            size: 20,
                          ),
                          HorizontalSpacing(width: 0.01),
                          new Flexible(
                            child: SizedBox(
                              width: 250,
                              child: new TextFormField(
                                  enabled: false,
                                  initialValue:
                                      data['houseNumber'].toString().isEmpty
                                          ? "N/A"
                                          : data['houseNumber'],
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: 'Central Park housing scheme',
                                      hintStyle: TextStyle(
                                          color: AppColor.darkGrey,
                                          fontSize: FontSize.xl))),
                            ),
                          ),
                          HorizontalSpacing(width: 0.05),
                          IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: AppColor.redColor,
                                size: 16,
                              ),
//onPressed: ()=>print(data),
                              onPressed: () => _navigationService
                                      .navigateToAndBack(
                                          NavigationRouter.yourAddressView,
                                          arguments: data)
                                      .then((value) {
                                    model.getAddresses();
                                  }))
                        ],
                      ),
                      Row(
                        children: [
                          HorizontalSpacing(width: 0.01),
                          Icon(
                            Icons.all_inbox_rounded,
                            color: AppColor.darkGrey,
                            size: 20,
                          ),
                          HorizontalSpacing(width: 0.01),
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                                enabled: false,
                                initialValue:
                                    data['instructions'].toString().isEmpty
                                        ? "N/A"
                                        : data['instructions'],
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(6),
                                    hintText: 'House# 528 Block A St 2',
                                    hintStyle: TextStyle(
                                        color: AppColor.darkGrey,
                                        fontSize: FontSize.xl))),
                          ),
                        ],
                      ),
                      VerticalSpacing(height: 0.02)
                    ],
                  ),
                ),
              ),
//              color: ,
            )),
        Positioned(
          child: length == 1
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.clear,
                    size: 30,
                  ),
                  onPressed: () {
                    model.updateAddresses(index);
                  },
                ),
          right: 5,
          top: 5,
        )
      ],
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
