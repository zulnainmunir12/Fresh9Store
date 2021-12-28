import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/model/store_model.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/core/viewmodel/search_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/customAppbar.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatefulWidget {
  List<Product> products;
  String type;
  SearchView(this.products, this.type);
  _Fresh9View createState() => _Fresh9View();
}

class _Fresh9View extends State<SearchView> {
  final CartService _cartService = locator<CartService>();

  onModelReady(SearchViewModel model) {
    model.getProducts(widget.products);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SearchViewModel(),
        onModelReady: (model) => onModelReady(model),
        builder: (context, SearchViewModel model, child) {
          return Scaffold(
              backgroundColor: Colors.grey[100],
//        drawer: MainDrawer(),
              appBar: customAppBarWithTitle("Search", model.count, model,
                  navigate: false),
              body: model.state == ViewState.loading
                  ? Loading.normalLoading()
                  : Container(
                      child: Column(
                        children: [
                          VerticalSpacing(height: 0.01),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: model.searchText,
                              onChanged: (val) {
                                model.searchProductsAndShops(val, widget.type);
                              },
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Search...",
                                  fillColor: Colors.white70),
                            ),
                          ),
                          Flexible(
                              child: ScrollableListTabView(
                                  tabHeight: 48,
                                  bodyAnimationDuration:
                                      const Duration(milliseconds: 150),
                                  tabAnimationCurve: Curves.easeOut,
                                  tabAnimationDuration:
                                      const Duration(milliseconds: 200),
                                  tabs: model.stores.length == 0 &&
                                          model.products.length == 0
                                      ? []
                                      : (widget.products == null ||
                                              widget.products.isEmpty
                                          ? [
                                              ScrollableListTab(
                                                  tab: ListTab(
                                                      label: Text("Stores"),
                                                      activeBackgroundColor:
                                                          AppColor
                                                              .primaryColor),
                                                  body: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          model.stores.length,
                                                      itemBuilder: (_, index) {
//                                          print(_products[index].subCategory);
//                                          print(element.id);
                                                        if (model.stores[index]
                                                            .storeName
                                                            .contains(model
                                                                .searchText
                                                                .text))
                                                          return _storeCard(
                                                              model.stores[
                                                                  index],
                                                              model);
                                                        else
                                                          return Container();
                                                      })),
                                              ScrollableListTab(
                                                  tab: ListTab(
                                                      label: Text("Products"),
                                                      activeBackgroundColor:
                                                          AppColor
                                                              .primaryColor),
                                                  body: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          model.products.length,
                                                      itemBuilder: (_, index) {
                                                        return _productCard(
                                                            model.products[
                                                                index],
                                                            model);
                                                      })),
                                            ]
                                          : [
//                                    ScrollableListTab(
//                                        tab: ListTab(
//                                            label: Text("Stores"),
//                                            activeBackgroundColor:
//                                            AppColor.primaryColor),
//                                        body: ListView.builder(
//                                            shrinkWrap: true,
//                                            physics:
//                                            NeverScrollableScrollPhysics(),
//                                            itemCount:
//                                            model.stores.length,
//                                            itemBuilder: (_, index) {
////                                          print(_products[index].subCategory);
////                                          print(element.id);
//                                              if (model
//                                                  .stores[index].storeName
//                                                  .contains(model
//                                                  .searchText.text))
//                                                return _storeCard(
//                                                    model.stores[index],
//                                                    model);
//                                              else
//                                                return Container();
//                                            })),
                                              ScrollableListTab(
                                                  tab: ListTab(
                                                      label: Text("Products"),
                                                      activeBackgroundColor:
                                                          AppColor
                                                              .primaryColor),
                                                  body: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          model.products.length,
                                                      itemBuilder: (_, index) {
                                                        return _productCard(
                                                            model.products[
                                                                index],
                                                            model);
                                                      })),
                                            ])))
                        ],
                      ),
                    ));
        });
  }

  _storeCard(StoreModel store, SearchViewModel model) {
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.15,
            margin: EdgeInsets.only(bottom: 2),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            color: Colors.white,
            child: Column(children: [
              Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => model.navigateToStore(store),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            height: 100,
                            width: 100,
//                width: 100,
                            child: store.imageUrl == null
                                ? Image.asset(
                                    'assets/image/fresh9_home_view.png',
                                    height: 140,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: store.imageUrl,
                                    placeholder: (context, url) =>
                                        Loading.imageLoading(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset("assets/image/placeholder.jpeg"),
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          onTap: () => model.navigateToStore(store),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          store.storeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: FontSize.l,
//                          fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          store.subTitle,
                          style: TextStyle(
                            color: AppColor.normalGrey,
                            fontSize: FontSize.s,
                          ),
                        ),
//                        Row(
//                          children: [
//                            Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                product.retailPrice == product.discountedPrice
//                                    ? Container()
//                                    : Container(
//                                  padding: EdgeInsets.only(
//                                      left: 10, right: 10, bottom: 1),
//                                  child: Text(
//                                    (((product.retailPrice -
//                                        product
//                                            .discountedPrice) /
//                                        product.retailPrice) *
//                                        100)
//                                        .round()
//                                        .toString() +
//                                        "% Off",
//                                    style: TextStyle(
//                                        fontSize: FontSize.m,
//                                        color: AppColor.whiteColor,
//                                        fontWeight: FontWeight.w700),
//                                  ),
//                                  decoration: BoxDecoration(
//                                      color: AppColor.primaryColor,
//                                      borderRadius:
//                                      BorderRadius.circular(10)),
//                                ),
//                                VerticalSpacing(
//                                    height: product.retailPrice ==
//                                        product.discountedPrice
//                                        ? 0.06
//                                        : 0.025),
////                          Flexible(child: Container()),
//                                Text(
//                                    "Rs. " +
//                                        product.retailPrice.toString() +
//                                        "/" +
//                                        product.increment.toString() +
//                                        product.unit,
//                                    style: TextStyle(
//                                        decoration: product.retailPrice ==
//                                            product.discountedPrice
//                                            ? null
//                                            : TextDecoration.lineThrough,
//                                        color: product.retailPrice ==
//                                            product.discountedPrice
//                                            ? AppColor.primaryColor
//                                            : AppColor.blackColor,
//                                        fontSize: product.retailPrice ==
//                                            product.discountedPrice
//                                            ? FontSize.l
//                                            : FontSize.s,
//                                        fontWeight: FontWeight.w500)),
//
//                                product.retailPrice == product.discountedPrice
//                                    ? Container()
//                                    : Text(
//                                    "Rs." +
//                                        product.discountedPrice.toString() +
//                                        "/" +
//                                        product.increment.toString() +
//                                        product.unit,
//                                    style: TextStyle(
//                                        color: AppColor.primaryColor,
//                                        fontSize: FontSize.xl,
//                                        fontWeight: FontWeight.w500)),
//                              ],
//                            ),
//                            Flexible(child: Container()),
//                            Column(
//                              crossAxisAlignment: CrossAxisAlignment.end,
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: [
//                                IconButton(
//                                    onPressed: () {
//                                      _navigationService.navigateToAndBack(
//                                          NavigationRouter.itemDetailView,
//                                          arguments: {
//                                            'product': product,
//                                            'products': model.products
//                                          });
////                        model.enableSubCategory(category.id);
//                                    },
//                                    icon: Icon(
//                                      Icons.chevron_right,
//                                      color: AppColor.primaryColor,
//                                    )),
////                                product.orderQuantity != 0
////                                    ? _quantityButton(model, product)
////                                    : _addToCartButton(model, product)
////                      _addToCartButton(model, product)
//                              ],
//                            ),
////                      Stack(
////                        children: [
////                          Container(
////                            child:
////                            width: 140,
////                            height: MediaQuery.of(context).size.height * 0.20,
////                          ),
////                          Positioned(
////                            child: product.orderQuantity != 0
////                                ? _quantityButton(model, product)
////                                : _addToCartButton(model, product),
////                            right: 10,
////                            bottom: 10,
////                          )
////                        ],
////                      )
//                          ],
//                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ])),
//        Positioned(
//            top: 15,
//            left: 0,
//            child: product.retailPrice == product.discountedPrice
//                ? Container()
//                : Container(
//              padding: EdgeInsets.only(left: 10, right: 10, bottom: 1),
//              child: Text(
//                "Sale",
//                style: TextStyle(
//                    color: AppColor.whiteColor,
//                    fontWeight: FontWeight.w700),
//              ),
//              decoration: BoxDecoration(
//                  color: AppColor.primaryColor,
//                  borderRadius: BorderRadius.circular(10)),
//            )),
      ],
    );
  }

  _productCard(Product product, SearchViewModel model) {
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.2,
            margin: EdgeInsets.only(bottom: 2),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            color: Colors.white,
            child: Column(children: [
              Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.products == null || widget.products.isEmpty)
                        model.navigateToStore(product.store);
                      else
                        model.navigateToProductDetail(product);
                    },
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
                          onTap: () {
                            if (widget.products == null ||
                                widget.products.isEmpty)
                              model.navigateToStore(product.store);
                            else
                              model.navigateToProductDetail(product);
                          },
                        ),
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
                  SizedBox(width: 5),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                                    : Text(
                                        "Rs." +
                                            product.discountedPrice.toString() +
                                            "/" +
                                            product.increment.toString() +
                                            product.unit,
                                        style: TextStyle(
                                            color: AppColor.primaryColor,
                                            fontSize: FontSize.xl,
                                            fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Flexible(child: Container()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.products == null ||
                                        widget.products.isEmpty
                                    ? IconButton(
                                        onPressed: () {
//                                        model.navigateToProductDetail(product);
                                          model.navigateToStore(product.store);
//                        model.enableSubCategory(category.id);
                                        },
                                        icon: Icon(
                                          Icons.chevron_right,
                                          color: AppColor.primaryColor,
                                        ))
                                    : product.orderQuantity != 0
                                        ? _quantityButton(model, product)
                                        : _addToCartButton(model, product),
//                                product.orderQuantity != 0
//                                    ? _quantityButton(model, product)
//                                    : _addToCartButton(model, product)
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

  _quantityButton(SearchViewModel model, Product product) {
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
                color: Color(0xff25D366),
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
            onTap: () {
              if (product.maxQuantity > product.orderQuantity)
                model.onTapAddItem(product, context);
            },
          ),
        ],
      ),
    );
  }

  _addToCartButton(SearchViewModel model, Product product) {
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
          onTap: () {
            if (model.userInfoModel == null)
              model.navigateToLogin();
            else
              model.onTapAddItem(product, context);
          },
          child: Text(
            'Add to cart',
            style: TextStyle(
                color: Color(0xff25D366),
                fontSize: FontSize.l,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
