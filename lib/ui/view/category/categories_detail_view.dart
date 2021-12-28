import 'dart:core';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/category_model.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/categories_detail_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';
import 'package:stacked/stacked.dart';

class CategoriesDetailView extends StatefulWidget {
  Map data;
  CategoriesDetailView(this.data);
  _VegetablesFruits createState() => _VegetablesFruits();
}

class _VegetablesFruits extends State<CategoriesDetailView>
    with SingleTickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  int i = 0;
  TabController _tabController;
  Category _category;
  List<Category> _subCategories;
  List<Product> _products;
  List<Widget> _tabs = [];

  @override
  void initState() {
    super.initState();
    print(widget.data);
    _category = widget.data['categories'];
    _subCategories = widget.data['subCategories'];
    _products = widget.data['products'];
    _tabController =
        new TabController(length: _subCategories.length, vsync: this);
    _tabs = [];
    print("selected");
    print(widget.data['selected']);
    for (int index = 0; index < _subCategories.length; index++) {
      if (widget.data['selected'] != null &&
          widget.data['selected'] == _subCategories[index].name) {
        var temp = _subCategories[0];
        _subCategories[0] = _subCategories[index];
        _subCategories[index] = temp;
      }
    }
    _subCategories.forEach((element) {
      _tabs.add(
        Tab(
          child: Text(
            element.name,
          ),
        ),
      );
    });
  }

  List<ScrollableListTab> getTabs(CategoriesDetailViewModel model) {
    List<ScrollableListTab> _tabs = [];
    _subCategories.forEach((element) {
      _tabs.add(
        ScrollableListTab(
            tab: ListTab(
                label: Text(element.name),
                activeBackgroundColor: AppColor.primaryColor),
            body: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _products.length,
                itemBuilder: (_, index) {
                  print(_products[index].subCategory);
                  print(element.id);
                  if (element.id == _products[index].subCategory)
                    return _categoryCard(model, _products[index]);
                  else
                    return Container();
                })),
      );
    });
    return _tabs;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ViewModelBuilder.reactive(
          viewModelBuilder: () => CategoriesDetailViewModel(
              cat: _category, sub: _subCategories, prod: _products),
          onModelReady: (model) => {},
          builder: (context, CategoriesDetailViewModel model, child) {
            return model.state == ViewState.loading
                ? Loading.normalLoading()
                : DefaultTabController(
                    length: _subCategories.length,
                    initialIndex: 0,
                    child: Scaffold(
                        backgroundColor: Colors.grey[300],
                        appBar: AppBar(
                          backgroundColor: AppColor.whiteColor,
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppColor.primaryColor,
                            ),
                            onPressed: () => _navigationService.goBack(),
                          ),
                          title: Text(
                            _category.name,
                            style: TextStyle(color: AppColor.darkGrey),
                          ),
                          actions: [
                            IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: AppColor.primaryColor,
                                ),
                                onPressed: () => _navigationService
                                    .navigateToAndBack(
                                        NavigationRouter.searchView,
                                        arguments: {"products": _products})),
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
                                        if (model.cartService.cartModelDataList
                                            .isEmpty)
                                          _navigationService
                                              .navigateToAndBack(
                                                  NavigationRouter
                                                      .emptyCartView)
                                              .then((value) {
                                            model.refresh();
                                          });
                                        else {
//                                          _navigationService.goBack();
//                                          _navigationService.goBack();
                                          _navigationService
                                              .navigateToAndBack(
                                                  NavigationRouter.cartView)
                                              .then((value) {
                                            model.refresh();
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                model.itemCount != 0
                                    ? Positioned(
                                        right: 11,
                                        bottom: 11,
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: AppColor.redColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          constraints: BoxConstraints(
                                              minWidth: 14, maxHeight: 14),
                                          child: Text(
                                            model.itemCount.toString(),
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
                        ),
                        body: ScrollableListTabView(
                            tabHeight: 48,
                            bodyAnimationDuration:
                                const Duration(milliseconds: 150),
                            tabAnimationCurve: Curves.easeOut,
                            tabAnimationDuration:
                                const Duration(milliseconds: 200),
                            tabs: getTabs(model).length == 0
                                ? []
                                : getTabs(model))),
                  );
          }),
    );
  }

  _categoryCard(
    CategoriesDetailViewModel model,
    Product product,
  ) {
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.2,
            margin: EdgeInsets.only(
              bottom: 2,
            ),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            color: Colors.white,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => _navigationService.navigateToAndBack(
                        NavigationRouter.itemDetailView,
                        arguments: {
                          'product': product,
                          'products': model.products
                        }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            child: Container(
                              height: 100,
                              width: 100,
//                width: 100,
                              child: product.imageUrl == null
                                  ? Image.asset(
                                      'assets/image/fresh9_home_view.png',
                                      height: 140,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: product.imageUrl,
                                      placeholder: (context, url) =>
                                          Loading.imageLoading(),
                                      errorWidget: (context, url, error) =>
                                          Image.asset("assets/image/placeholder.jpeg"),
                                      fit: BoxFit.contain,
                                    ),
                            ),
                            onTap: () => _navigationService.navigateToAndBack(
                                    NavigationRouter.itemDetailView,
                                    arguments: {
                                      'product': product,
                                      'products': model.products
                                    })),
                      ],
                    ),
                  ),
//                  Container(
//                    height: 100,
//                    width: 100,
//                    child: product.imageUrl == null
//                        ? Image.asset(
//                            'assets/image/fresh9_home_view.png',
//                            height: 120,
//                          )
//                        : CachedNetworkImage(
//                            imageUrl: product.imageUrl,
//                            placeholder: (context, url) =>
//                                Loading.imageLoading(),
//                            errorWidget: (context, url, error) => Container(
//                                color: AppColor.lightGrey,
//                                child: Icon(Icons.error)),
//                            fit: BoxFit.fitHeight,
//                          ),
//                  )),
//                  SizedBox(width: 5),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2),
                        Text(
                          product.name,
                          style: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: FontSize.l,
//                          fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          product.description == null
                              ? ""
                              : product.description,
                          style: TextStyle(
                            color: AppColor.normalGrey,
                            fontSize: FontSize.s,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                product.retailPrice == product.discountedPrice
                                    ? Container()
                                    : Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 1),
                                        child: Text(
                                          (((product.retailPrice -
                                                              product
                                                                  .discountedPrice) /
                                                          product.retailPrice) *
                                                      100)
                                                  .round()
                                                  .toString() +
                                              "% Off",
                                          style: TextStyle(
                                              fontSize: FontSize.m,
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                VerticalSpacing(
                                    height: product.retailPrice ==
                                            product.discountedPrice
                                        ? 0.06
                                        : 0.025),
//                          Flexible(child: Container()),
                                Text(
                                    "Rs. " +
                                        product.retailPrice.toString() +
                                        "/" +
                                        product.increment.toString() +
                                        product.unit,
                                    style: TextStyle(
                                        decoration: product.retailPrice ==
                                                product.discountedPrice
                                            ? null
                                            : TextDecoration.lineThrough,
                                        color: product.retailPrice ==
                                                product.discountedPrice
                                            ? AppColor.primaryColor
                                            : AppColor.blackColor,
                                        fontSize: product.retailPrice ==
                                                product.discountedPrice
                                            ? FontSize.l
                                            : FontSize.s,
                                        fontWeight: FontWeight.w500)),

                                product.retailPrice == product.discountedPrice
                                    ? Container()
                                    : RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: 'Rs.',
                                              style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontSize: FontSize.s,
                                                  fontWeight: FontWeight.w500)),
                                          TextSpan(
                                              text: product.discountedPrice
                                                      .toString() +
                                                  "/" +
                                                  product.increment.toString(),
                                              style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontSize: FontSize.l,
                                                  fontWeight: FontWeight.w500)),
                                          TextSpan(
                                              text: product.unit,
                                              style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontSize: FontSize.s,
                                                  fontWeight: FontWeight.w500)),
                                        ]),
                                      )
//                                Text(
//                                        "Rs." +
//                                            product.discountedPrice.toString() +
//                                            "/" +
//                                            product.increment.toString() +
//                                            product.unit,
//                                        style: TextStyle(
//                                            color: AppColor.primaryColor,
//                                            fontSize: FontSize.l,
//                                            fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Flexible(child: Container()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _navigationService.navigateToAndBack(
                                          NavigationRouter.itemDetailView,
                                          arguments: {
                                            'product': product,
                                            'products': model.products
                                          });
//                        model.enableSubCategory(category.id);
                                    },
                                    icon: Icon(
                                      Icons.chevron_right,
                                      color: AppColor.primaryColor,
                                    )),
                                product.orderQuantity != 0
                                    ? _quantityButton(model, product)
                                    : _addToCartButton(model, product)
//                      _addToCartButton(model, product)
                              ],
                            ),
//                      Stack(
//                        children: [
//                          Container(
//                            child:
//                            width: 140,
//                            height: MediaQuery.of(context).size.height * 0.20,
//                          ),
//                          Positioned(
//                            child: product.orderQuantity != 0
//                                ? _quantityButton(model, product)
//                                : _addToCartButton(model, product),
//                            right: 10,
//                            bottom: 10,
//                          )
//                        ],
//                      )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ])),
        Positioned(
            top: 15,
            left: 0,
            child: product.retailPrice == product.discountedPrice
                ? Container()
                : Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 1),
                    child: Text(
                      "Sale",
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w700),
                    ),
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  )),
      ],
    );
  }

  _quantityButton(CategoriesDetailViewModel model, Product product) {
    return Container(
      height: 40,
      width: 130,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
          ),
          border: Border.all(
            color: Color(0xff25D366),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff25D366).withOpacity(0.4),
              spreadRadius: -3,
              blurRadius: 7,
              offset: Offset(0, 7),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Icon(
              product.orderQuantity == 1
                  ? Icons.delete_outline
                  : Icons.remove_circle_outline,
              color: Color(0xff25D366),
              size: 24,
            ),
            onTap: () {
              if (product.orderQuantity == 1)
                model.onRemoveItem(product, context);
              else
                model.onRemoveItem(product, context);
            },
          ),
          Text(
            product.orderQuantity.toString(),
            style: TextStyle(
                color: product.inventory == 0 ? Colors.grey : Color(0xff25D366),
                fontSize: FontSize.l,
                fontWeight: FontWeight.w500),
          ),
          InkWell(
            child: Icon(
              Icons.add_circle_outline,
              color: product.maxQuantity == product.orderQuantity
                  ? Colors.grey
                  : Color(0xff25D366),
              size: 24,
            ),
            onTap: product.inventory == 0
                ? null
                : () {
                    if (product.maxQuantity > product.orderQuantity)
                      model.onTapAddItem(product, context);
                  },
          ),
        ],
      ),
    );
  }

  _addToCartButton(CategoriesDetailViewModel model, Product product) {
    return Container(
      height: 40,
      width: 130,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
          ),
          border: Border.all(
            color: Color(0xff25D366),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff25D366).withOpacity(0.4),
              spreadRadius: -3,
              blurRadius: 7,
              offset: Offset(0, 7),
            )
          ]),
      child: Center(
        child: GestureDetector(
          onTap: product.inventory == 0
              ? null
              : () {
                  if (model.userInfoModel == null)
                    model.navigateToLogin();
                  else
                    model.onTapAddItem(product, context);
                },
          child: Text(
            product.inventory == 0 ? "Out of Stock" : 'Add to Cart',
            style: TextStyle(
                color: product.inventory == 0
                    ? Colors.grey[300]
                    : Color(0xff25D366),
                fontSize: FontSize.l,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
