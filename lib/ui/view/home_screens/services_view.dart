import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/service_model.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/service.view.model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/error_view.dart';
import 'package:fresh9_rider/ui/widget/main_drawer.dart';
import 'package:fresh9_rider/ui/widget/adverisement_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ServicesView extends StatefulWidget {
  _ServicesView createState() => _ServicesView();
}

class _ServicesView extends State<ServicesView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final List<String> _dropDownValues = [
    'Services',
    'Fresh9',
    'Restaurants',
    'Shops'
  ];
  String _currentlySelected;

  onModelReady(ServicesViewModel model) {
//    model.getAds("services");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.lightGrey,
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Center(
            child: _dropDrownWidget(),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: AppColor.whiteColor,
                ),
                onPressed: () {}),
          ],
        ),
        body: ViewModelBuilder.reactive(
            viewModelBuilder: () => ServicesViewModel(),
            onModelReady: (model) => onModelReady(model),
            builder: (context, ServicesViewModel model, child) {
              return model.state == ViewState.loading
                  ? Loading.normalLoading()
                  : model.state == ViewState.error
                      ? ErrorView(
                          text: model.serverError,
                          onPressed: () => model.determinePosition(),
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
                                  height:
                                      MediaQuery.of(context).size.shortestSide *
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'We Have Professionals Team',
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
                                itemCount: model.services == null
                                    ? 0
                                    : model.services.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _itemCard(
                                      model.services[index], model);
                                },
                              ),
                            ),
                          ],
                        );
            }));
  }

  List _items = [
    {
      "image": 'assets/image/photographer.png',
      "title": "Photographer",
      "description": "Events photography, products, and more.. "
    },
    {
      "image": 'assets/image/electricion.png',
      "title": "Electrician",
      "description": "Fridge, Ac service, lights and more.."
    },
    {
      "image": 'assets/image/plumber.png',
      "title": "Plumber",
      "description": "New fitting, complains and more.."
    },
    {
      "image": 'assets/image/barber.png',
      "title": "Barber",
      "description": "Hair cutting, chilled hair cutting and more.."
    },
  ];

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

  _itemCard(Service service, ServicesViewModel model) {
    return Container(
        margin: EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        color: Colors.white,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 120,
                width: 120,
                child: service.imageUrl == null
                    ? Image.asset(
                        'assets/image/fresh9_home_view.png',
                        height: 120,
                      )
                    : CachedNetworkImage(
                        imageUrl: service.imageUrl,
                        placeholder: (context, url) => Loading.imageLoading(),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/image/placeholder.jpeg"),
                        fit: BoxFit.fitHeight,
                      ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: FontSize.xl,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                      width: 160,
                      child: Text(
                        service.description,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColor.normalGrey,
                          fontSize: FontSize.s,
                        ),
                      )),
                ],
              ),
              Flexible(child: Container()),
              IconButton(
                  onPressed: () {
                    if (model.userInfoModel == null)
                      model.navigateToLogin();
                    else
                      model.navigateToServiceOrder(service.name);
                  },
                  icon: Icon(
                    Icons.chevron_right,
                    color: AppColor.primaryColor,
                    size: 26,
                  )),
//
            ],
          ),
        ]));

//      Container(
//      width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height / 5,
//      color: AppColor.backgroundColor,
//      margin: EdgeInsets.only(bottom: 5),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          HorizontalSpacing(width: 0.01),
//          Image.asset(
//            image,
//            height: 64,
//          ),
//          HorizontalSpacing(width: 0.01),
//          Column(
//            mainAxisSize: MainAxisSize.min,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                title,
//                style: TextStyle(
//                    color: AppColor.primaryColor,
//                    fontSize: FontSize.xl,
//                    fontWeight: FontWeight.bold),
//              ),
//              VerticalSpacing(height: 0.02),
//              Text(
//                description,
//                style:
//                    TextStyle(color: AppColor.darkGrey, fontSize: FontSize.m),
//              )
//            ],
//          ),
//          new Spacer(), // I just added one line
//          IconButton(
//            icon: Icon(Icons.navigate_next, color: AppColor.primaryColor),
//            onPressed: () => _navigationService
//                .navigateTo(NavigationRouter.serviceDetailView),
//          ) // This Icon
//        ],
//      ),
//    );
  }
}
