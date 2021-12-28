import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

final CartService _cartService = locator<CartService>();
final NavigationService _navigationService = locator<NavigationService>();
final List<String> _dropDownValues = [
  'Fresh9',
  'Restaurants',
  'Shops',
  'Services'
];
String _currentlySelected;

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
//                TextStyle(color: AppColor.blackColor, fontSize: FontSize.xxxl),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColor.primaryColor,
        ),
      ),
    ),
  );
}

Widget customAppBar(int count, category, model, {List<Product> products,bool search = true}) {
  return AppBar(
    title: Center(
      child: _dropDrownWidget(),
    ),
    actions: [
      search ? IconButton(
          icon: const Icon(
            Icons.search,
            color: AppColor.primaryColor,
          ),
          onPressed: () {
            print(products.length);
            _navigationService.navigateToAndBack(NavigationRouter.searchView,
                arguments: {"products": products, 'type': category});
          }):Container(),
      Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {
                  if (_cartService.cartModelDataList.isEmpty)
                    _navigationService
                        .navigateToAndBack(NavigationRouter.emptyCartView)
                        .then((value) {
                      model.refresh();
                    });
                  else
                    _navigationService
                        .navigateToAndBack(NavigationRouter.cartView)
                        .then((value) {
                      model.refresh();
                    });
                },
              ),
            ],
          ),
          count != 0
              ? Positioned(
                  right: 11,
                  bottom: 11,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: AppColor.redColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    constraints: BoxConstraints(minWidth: 14, maxHeight: 14),
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Container()
        ],
      )
    ],
  );
}

Widget customAppBarWithTitle(String title, int count, model,
    {bool navigate = true, List<Product> products}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: AppColor.blackColor),
    ),
    actions: [
      !navigate
          ? Container()
          : IconButton(
              icon: Icon(
                Icons.search,
                color: AppColor.primaryColor,
              ),
              onPressed: () {
                _navigationService
                    .navigateToAndBack(NavigationRouter.searchView, arguments: {
                  "products": products == null ? <Product>[] : products
                });
              }),
//      IconButton(
//        icon: Icon(
//          Icons.shopping_cart_outlined,
//          color: AppColor.primaryColor,
//        ),
//        onPressed: () {
//          print("click");
//          if (_cartService.cartModelDataList.isEmpty)
//            _navigationService
//                .navigateToAndBack(NavigationRouter.emptyCartView);
//          else
//            _navigationService.navigateToAndBack(NavigationRouter.cartView);
//        },
//      )
      Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {
                  if (_cartService.cartModelDataList.isEmpty)
                    _navigationService
                        .navigateToAndBack(NavigationRouter.emptyCartView).then((value) {
                      model.refresh();
                    });
                  else
                    _navigationService
                        .navigateToAndBack(NavigationRouter.cartView)
                        .then((value) {
                      model.refresh();
                    });
                },
              ),
            ],
          ),
          count != 0
              ? Positioned(
                  right: 11,
                  bottom: 11,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: AppColor.redColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    constraints: BoxConstraints(minWidth: 14, maxHeight: 14),
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    ],
  );
}
