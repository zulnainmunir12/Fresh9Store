import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/category_model.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/stores_products_view_model.dart';
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

class StoreCategoriesView extends StatefulWidget {
  String index;
  StoreCategoriesView(this.index);
  _Categories createState() => _Categories();
}

class _Categories extends State<StoreCategoriesView> {
  final CartService _cartService = locator<CartService>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => StoreProductsViewModel(),
        onModelReady: (model) => onModelReady(model),
        builder: (context, StoreProductsViewModel model, child) {
          return Scaffold(
              backgroundColor: AppColor.lightGrey,
              appBar: customAppBarWithTitle(
                  'Categories', _cartService.cartModelDataList.length, model,
                  products: model.products),
              body: model.state == ViewState.loading
                  ? Loading.normalLoading()
                  : body(model));
        });
  }

  onModelReady(StoreProductsViewModel model) {
    print("category");
    print(widget.index);
    model.getProducts(widget.index);
  }

  body(StoreProductsViewModel model) {
    List<Widget> _widgets = [];
    model.categories.forEach((element) {
      _widgets.add(_categoryCard(element, model));
    });

    return model.categories.length == 0
        ? Container(
            child: Center(
            child: Text(
              "No item available at the moment!",
              style: TextStyle(fontSize: 18),
            ),
          ))
        : ListView(children: [
            Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Featured Products',
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: FontSize.xxl,
                            fontWeight: FontWeight.w500),
                      ),
                      _viewAllButton(NavigationRouter.featuredProductssView,
                          data: widget.index)
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
                items: model.featuredProducts.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return _productContainer(i, model);
                    },
                  );
                }).toList(),
              ),
            ),
            Column(
              children: _widgets,
            )
          ]);
  }

  _categoryCard(Category category, StoreProductsViewModel model) {
    List<Category> subCategories =
        model.getSpecificSubCategories(category.name);

    String subTitle = '';
    int i = 0;
    subCategories.forEach((element) {
      subTitle += (element.name + (i + 1 == subCategories.length ? "." : ", "));
      i++;
    });
    return InkWell(
      child: Container(
          height: category.showSubCategory ? null : 140,
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          color: Colors.white,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: category.imageUrl == null
                      ? Image.asset(
                          'assets/image/fresh9_home_view.png',
                          height: 120,
                        )
                      : CachedNetworkImage(
                          imageUrl: category.imageUrl,
                          placeholder: (context, url) => Loading.imageLoading(),
                          errorWidget: (context, url, error) => Image.asset("assets/image/placeholder.jpeg"),
                          fit: BoxFit.fitHeight,
                        ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: FontSize.xl,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                        width: 180,
                        child: Text(
                          subTitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.normalGrey,
                            fontSize: FontSize.s,
                          ),
                        )),
                  ],
                ),

//                      Text(
//                        product.category,
//                        style: TextStyle(
//                            color: AppColor.darkGrey, fontSize: FontSize.m),
//                      ),
//                      VerticalSpacing(height: 0.001),
//                      Text(
//                        product.subCategory,
//                        style: TextStyle(
//                            color: AppColor.darkGrey, fontSize: FontSize.m),
//                      ),
//                    ],
//                  ),
                Flexible(child: Container()),
//                  Text("Rs. " +
//                      product.retailPrice.toString() +
//                      "/" +
//                      product.unit)
                IconButton(
                    onPressed: () {
                      model.enableSubCategory(category.id);
                    },
                    icon: Icon(
                      category.showSubCategory
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColor.primaryColor,
                    )),
//
              ],
            ),
            !category.showSubCategory
                ? Container()
                : Container(
                    color: Colors.grey[300],
                    height: 130,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: subCategories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              child: Card(
                                child: Container(
                                  width: 130,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              subCategories[index].imageUrl,
                                          placeholder: (context, url) =>
                                              Loading.imageLoading(),
                                          errorWidget: (context, url, error) =>
                                              Image.asset("assets/image/placeholder.jpeg"),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Flexible(child: Container()),
                                      Text(
                                        subCategories[index].name,
                                        style: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontSize: FontSize.l,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () => _navigationService.navigateToAndBack(
                                      NavigationRouter.categoriesDetailView,
                                      arguments: {
                                        'categories': category,
                                        'subCategories': subCategories,
                                        'products': model.products
                                      }).then((value) => model.refresh()));
                        }),
                  )
          ])),
      onTap: () => _navigationService
          .navigateToAndBack(NavigationRouter.categoriesDetailView, arguments: {
        'categories': category,
        'subCategories': subCategories,
        'products': model.products
      }).then((value) => model.refresh()),
    );
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

  _productContainer(Product product, StoreProductsViewModel model) {
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
                    Positioned(
                        top: 5,
                        right: 0,
                        child: product.retailPrice == product.discountedPrice
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
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: product.retailPrice == product.discountedPrice
                            ? Container()
                            : Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 1),
                                child: Text(
                                  (((product.retailPrice -
                                                      product.discountedPrice) /
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
                                    borderRadius: BorderRadius.circular(10)),
                              ))
                  ],
                ),
//              Image.asset(
//                'assets/image/fresh9_home_view2.png',
//              ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(height: 0.02),
                    Container(
                        width: 160,
                        child: Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: FontSize.m, color: AppColor.darkGrey),
                        )),
                    VerticalSpacing(height: 0.01),
                    product.retailPrice == product.discountedPrice
                        ? Container()
                        : Row(children: [
                            Text(
                              'Rs.' +
                                  product.retailPrice.toString() +
                                  '/' +
                                  product.increment.toString() +
                                  product.unit,
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColor.darkGrey,
                                  color: AppColor.darkGrey,
                                  fontSize: FontSize.m),
                            ),
                          ]),
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

  _quantityButton(StoreProductsViewModel model, Product product) {
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
              if (product.maxQuantity > product.orderQuantity) {
                model.onTapAddItem(product, context);
              }
            },
          ),
        ],
      ),
    );
  }

  _addToCartButton(StoreProductsViewModel model, Product product) {
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
            if (model.userInfoModel == null) {
              model.navigateToLogin();
            } else {
              model.onTapAddItem(product, context);
            }
          },
          child: const Text(
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
