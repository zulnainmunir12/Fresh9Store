import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/item_detail_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/customAppbar.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ItemDetailView extends StatefulWidget {
  Product product;
  List<Product> products;
  ItemDetailView(this.product, this.products);
  _CartView createState() => _CartView();
}

//  final CartService _cartService = locator<CartService>();

class _CartView extends State<ItemDetailView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final CartService _cartService = locator<CartService>();

  onModelReady(ProductDetailViewModel model) async {
    await model.setProduct(widget.product);
    await model.setProducts(widget.products);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ProductDetailViewModel(),
        onModelReady: (model) => onModelReady(model),
        builder: (context, ProductDetailViewModel model, child) {
          return Scaffold(
              appBar: customAppBarWithTitle('Product Detail',
                  _cartService.cartModelDataList.length, model,
                  products: widget.products),
              body: model.state == ViewState.loading
                  ? Loading.normalLoading()
                  : ListView(
                      children: [
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: widget.product.imageUrl == null
                                      ? Image.asset(
                                          'assets/image/fresh9_home_view.png',
                                          fit: BoxFit.fitHeight,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: widget.product.imageUrl,
                                          placeholder: (context, url) =>
                                              Loading.imageLoading(),
                                          errorWidget: (context, url, error) =>
                                              Image.asset("assets/image/placeholder.jpeg"),
                                          fit: BoxFit.contain,
                                        ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                  width:
                                      MediaQuery.of(context).size.height * 0.45,
                                )
                              ],
                            ),
                            Positioned(
                                top: 15,
                                left: 5,
                                child: widget.product.retailPrice ==
                                        widget.product.discountedPrice
                                    ? Container()
                                    : Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 1),
                                        child: Text(
                                          "Sale",
                                          style: TextStyle(
                                              color: AppColor.whiteColor,
                                              fontSize: FontSize.xl,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      )),
                            Positioned(
                                bottom: 20,
                                left: 10,
                                child: widget.product.retailPrice ==
                                        widget.product.discountedPrice
                                    ? Container()
                                    : Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 1),
                                        child: Text(
                                          (((widget.product.retailPrice -
                                                              widget.product
                                                                  .discountedPrice) /
                                                          widget.product
                                                              .retailPrice) *
                                                      100)
                                                  .round()
                                                  .toString() +
                                              "% Off",
                                          style: TextStyle(
                                              fontSize: FontSize.xl,
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ))
                          ],
                        ),
                        VerticalSpacing(height: 0.01),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        widget.product.name,
                                        style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontSize: FontSize.xl),
                                      )),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        widget.product.description == null
                                            ? ""
                                            : widget.product.description,
                                        style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontSize: FontSize.m),
                                      )),
                                  VerticalSpacing(height: 0.01),
                                  widget.product.discountedPrice ==
                                          widget.product.retailPrice
                                      ? Container()
                                      : Text(
                                          'Rs.${widget.product.retailPrice}/${widget.product.increment.toString() + widget.product.unit}',
                                          style: TextStyle(
                                            color: AppColor.blackColor,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: FontSize.m,
                                          ),
                                        ),
                                  Text(
                                    'Rs.${widget.product.discountedPrice}/${widget.product.increment.toString() + widget.product.unit}',
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: FontSize.l,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Flexible(child: Container()),
                              Padding(
                                  padding: EdgeInsets.only(top: 55),
                                  child: model.currentProduct.orderQuantity == 0
                                      ? _addToCartButton(model, widget.product)
                                      : _quantityButton(model, widget.product)),
                            ],
                          ),
                        ),
                        VerticalSpacing(height: 0.03),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Similar Products',
                                    style: TextStyle(
                                        color: AppColor.blackColor,
                                        fontSize: FontSize.xxl,
                                        fontWeight: FontWeight.w500),
                                  ),
//                                  _viewAllButton(
//                                      NavigationRouter.productssView,
//                                      data: "6085479d37e6f748f7a9e55f")
                                ])),
                        VerticalSpacing(height: 0.01),
                        Container(
                          height: 316,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              autoPlayInterval: Duration(seconds: 4),
                              autoPlay: true,
                              initialPage: 0,
                              viewportFraction: 0.45,
                              height: 316,
                            ),
                            items: model.products.map((i) {
                              print(model.products.length);
                              print("in carosuel");
                              return Builder(
                                builder: (BuildContext context) {
                                  return _productContainer(i, model);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        VerticalSpacing(height: 0.03),
                      ],
                    ));
        });
  }

  _productContainer(Product product, ProductDetailViewModel model) {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Container(
//        height: 110,
          width: 160,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                child: Container(
                                  height: 140,
//                width: 100,
                                  child: product.imageUrl == null
                                      ? Image.asset(
                                          'assets/image/fresh9_home_view.png',
                                          height: 140,
                                          fit: BoxFit.fill,
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
                                onTap: () => _navigationService
                                        .navigateToAndBack(
                                            NavigationRouter.itemDetailView,
                                            arguments: {
                                          'product': product,
                                          'products': model.products
                                        })),
                          ],
                        ),
                        Positioned(
                            top: 5,
                            right: 0,
                            child:
                                product.retailPrice == product.discountedPrice
                                    ? Container()
                                    : Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 1),
                                        child: Text(
                                          "Sale",
                                          style: TextStyle(
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child:
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
                                      ))
                      ],
                    ),
                  ],
                ),
//              Image.asset(
//                'assets/image/fresh9_home_view2.png',
//              ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(height: 0.02),
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: FontSize.m, color: AppColor.darkGrey),
                    ),
                    VerticalSpacing(height: 0.01),
                    product.retailPrice == product.discountedPrice
                        ? Container()
                        : Text(
                            'Rs.' +
                                product.retailPrice.toString() +
                                '/' +
                                product.increment.toString() +
                                product.unit,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppColor.darkGrey,
                                color: AppColor.darkGrey,
                                fontSize: FontSize.xl),
                          ),
                    VerticalSpacing(
                        height: product.retailPrice == product.discountedPrice
                            ? 0.035
                            : 0.01),
                    Text(
                      'Rs.' +
                          product.discountedPrice.toString() +
                          '/' +
                          product.increment.toString() +
                          product.unit,
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: FontSize.xl,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Flexible(child: Container()),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  product.orderQuantity != 0
                      ? _quantityButton(model, product)
                      : _addToCartButton(model, product),
                ])
              ],
            ),
          ),
        ));
  }

  _viewAllButton(String route, {data}) {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.shortestSide * 0.23,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(
            side: BorderSide(color: AppColor.lawnGreen),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () =>
              _navigationService.navigateToAndBack(route, arguments: data),
          child: Text(
            'View all',
            style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: FontSize.xl,
                fontWeight: FontWeight.w400),
          ),
        ));
  }

  _quantityButton(ProductDetailViewModel model, Product product) {
    return Container(
      height: 40,
      width: 144,
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

  _addToCartButton(ProductDetailViewModel model, Product product) {
    return Container(
      height: 40,
      width: 144,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
          ),
          border: Border.all(
            color: product.inventory == 0 ? Colors.grey : Color(0xff25D366),
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
                color: product.inventory == 0 ? Colors.grey : Color(0xff25D366),
                fontSize: FontSize.xl,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  _checkOutButton() {
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
              child: Text(
                'CheckOut',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: FontSize.xl,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () =>
                  _navigationService.navigateTo(NavigationRouter.emptyCartView),
            ),
          ),
        ));
  }
}
