import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/store_model.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/other_shops_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/customAppbar.dart';
import 'package:fresh9_rider/ui/widget/error_view.dart';
import 'package:fresh9_rider/ui/widget/main_drawer.dart';
import 'package:fresh9_rider/ui/widget/adverisement_card.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ShopsView extends StatefulWidget {
  _ShopsView createState() => _ShopsView();
}

class _ShopsView extends State<ShopsView> {
  final NavigationService _navigationService = locator<NavigationService>();

  final List<String> _dropDownValues = [
    'Shops',
    'Fresh9',
    'Restaurants',
    'Services'
  ];
  String _currentlySelected;

  onModelReady(OtherShopsViewModel model) {
//
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => OtherShopsViewModel(),
        onModelReady: (model) => onModelReady(model),
        builder: (context, OtherShopsViewModel model, child) {
          return Scaffold(
              drawer: MainDrawer(),
              appBar: customAppBar(model.itemCount, "grocery", model,search: false),
              body: model.state == ViewState.loading
                  ? Loading.normalLoading()
                  : model.state == ViewState.error
                      ? ErrorView(
                          text: model.serverError,
                          onPressed: () => model.determinePosition(),
                        )
                      : (model.stores.length == 0
                          ? Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlay: true,
                                      initialPage: 0,
                                      viewportFraction: 0.9,
                                      height: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                          0.43,
                                    ),
                                    items: model.banners.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return AdvertisementCard(i);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  color: Colors.grey[300],
                                ),
                                Flexible(
                                    child: Center(
                                        child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      size: 60,
                                    ),
                                    Text("Coming to your area soon.")
                                  ],
                                )))
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlay: true,
                                      initialPage: 0,
                                      viewportFraction: 0.9,
                                      height: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                          0.43,
                                    ),
                                    items: model.banners.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return AdvertisementCard(i);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  color: Colors.grey[300],
                                ),
                                Card(
                                  elevation: 3,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55,
                                    color: AppColor.whiteColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'All Shops',
                                            style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: FontSize.xxl,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: ListView.builder(
                                    itemCount: model.stores.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _itemCard(
                                          model.stores[index], model);
                                    },
                                  ),
                                ),
                                VerticalSpacing(height: 0.01)
                              ],
                            )));
        });
  }

  _dropDrownWidget() {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        buttonColor: AppColor.primaryColor,
        alignedDropdown: true,
        child: DropdownButton(
          items: _dropDownValues
              .map((value) => DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  ))
              .toList(),
          onChanged: (String value) {
            setState(() {
              _currentlySelected = value;
            });
            if (value == "Fresh9")
              _navigationService.navigateTo(NavigationRouter.fresh9View);
            else if (value == "Restaurants")
              _navigationService.navigateTo(NavigationRouter.restaurantView);
            else if (value == "Shops")
              _navigationService.navigateTo(NavigationRouter.shopsView);
            else
              _navigationService.navigateTo(NavigationRouter.servicesView);
          },
          isExpanded: false,
          value: _currentlySelected,
          hint: Text(
            'Choose Option',
//            style:
//            TextStyle(color: AppColor.blackColor, fontSize: FontSize.xxxl),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }

  _itemCard(StoreModel item, OtherShopsViewModel model) {
    return InkWell(
      child: Container(
        child: Column(
          children: [
            VerticalSpacing(height: 0.01),
            Stack(
              children: [
                (item.imageUrl != null
                    ? Container(
                        margin: EdgeInsets.only(bottom: 60.0),
                        height: 150,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: item.imageUrl,
                            placeholder: (context, url) =>
                                Loading.imageLoading(),
                            errorWidget: (context, url, error) =>
                                Image.asset("assets/image/placeholder.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ))
                    : Container(
                        margin: EdgeInsets.only(bottom: 60.0),
                        height: 150,
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                      )),
                Positioned(
                    top: 120,
                    left: 5,
                    right: 5,
                    child: Card(
                      child: Container(
                        height: 85,
                        padding: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
//                        border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(6.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VerticalSpacing(height: 0.005),
                            Text(
                              item.storeName,
                              style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: FontSize.xxl),
                            ),
                            VerticalSpacing(height: 0.005),
                            Text(
                              item.subTitle,
                              style: TextStyle(
                                  color: AppColor.darkGrey,
                                  fontSize: FontSize.m),
                            ),
//                            VerticalSpacing(height: 0.005),
                            RichText(
                              text: TextSpan(
                                  text: 'Rs ' + item.minimumOrder.toString(),
                                  style: TextStyle(
                                      color: AppColor.darkGrey,
                                      fontSize: FontSize.s),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' Minimum',
                                        style: TextStyle(
                                            color: AppColor.darkGrey
                                                .withOpacity(0.4),
                                            fontSize: FontSize.s)),
                                    TextSpan(
                                        text: ' | Rs ' +
                                            item.deliveryFee.toString(),
                                        style: TextStyle(
                                            color: AppColor.darkGrey,
                                            fontSize: FontSize.s)),
                                    TextSpan(
                                        text: ' Delivery',
                                        style: TextStyle(
                                            color: AppColor.darkGrey
                                                .withOpacity(0.4),
                                            fontSize: FontSize.s)),
                                    TextSpan(
                                        text:
                                            ' | ${item.ownDelivery ? 'store own delivery' : 'delivered by Fresh9'}',
                                        style: TextStyle(
                                            color: AppColor.darkGrey,
                                            fontSize: FontSize.s)),
                                  ]),
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
      onTap: () async {
        if (item.breakStatus) {
          Dialog errorDialog = Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)), //this right here
            child: Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(
                      'This store isn\'t available at the moment',
                      style: TextStyle(
                          fontSize: FontSize.xl, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      'Kindly try again in while. Thanks',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    RaisedButton(
                        color: AppColor.primaryColor,
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          'Okay!',
                          style: TextStyle(color: Colors.white),
                        )),
                  ])
                ],
              ),
            ),
          );
          await showDialog(
              context: context, builder: (BuildContext context) => errorDialog);
        } else {
          model.navigateToStore(item.id);
        }
      },
    );
  }
}
