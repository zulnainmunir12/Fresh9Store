import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/category_model.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/products_view_model.dart';
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

class Fresh9HomeView extends StatefulWidget {
  _Fresh9View createState() => _Fresh9View();
}

class _Fresh9View extends State<Fresh9HomeView> {
  final NavigationService _navigationService = locator<NavigationService>();

  onModelReady(ProductsViewModel model) {}

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ProductsViewModel(context),
        onModelReady: (model) => onModelReady(model),
        builder: (context, ProductsViewModel model, child) {
          return Scaffold(
              drawer: MainDrawer(),
              appBar: customAppBar(model.itemCount, 'fresh9', model,
                  products: model.products),
              body: model.state == ViewState.loading
                  ? Loading.normalLoading()
                  : model.state == ViewState.idle
                      ? (model.products.length == 0
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
                          : ListView(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          autoPlayInterval:
                                              Duration(seconds: 3),
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
//                            Container(
//                              margin: EdgeInsets.symmetric(vertical: 0.0),
//                              width: MediaQuery.of(context).size.width,
//                              height: MediaQuery.of(context).size.shortestSide *
//                                  0.43,
//                              color: AppColor.lightestGrey.withOpacity(0.5),
//                              child: ListView.builder(
//                                scrollDirection: Axis.horizontal,
//                                itemCount: model.banners.length,
//                                itemBuilder: (BuildContext context, int index) {
//                                  return AdvertisementCard(
//                                      model.banners[index]);
//                                },
//                              ),
//                            ),
                                    Card(
                                      elevation: 3,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 55,
                                        color: AppColor.whiteColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Categories',
                                                style: TextStyle(
                                                    color: AppColor.blackColor,
                                                    fontSize: FontSize.xxl,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              _viewAllButton(
                                                  NavigationRouter
                                                      .categoriesView,
                                                  model,
                                                  data: model.products)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 235,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      padding: EdgeInsets.only(left: 10),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: model.categories.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return _servicesContainer(
                                              model.categories[index], model);
                                        },
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Featured Products',
                                                style: TextStyle(
                                                    color: AppColor.blackColor,
                                                    fontSize: FontSize.xxl,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              _viewAllButton(
                                                NavigationRouter
                                                    .featuredProductssView,
                                                model,
                                                data: model.stores[0].id,
                                              )
                                            ])),
                                    VerticalSpacing(height: 0.01),
                                    Container(
                                      height: 316,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          autoPlayInterval:
                                              Duration(seconds: 4),
                                          autoPlay: true,
                                          initialPage: 0,
                                          viewportFraction: 0.45,
                                          height: 316,
                                        ),
                                        items: model.featuredProducts.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return _productContainer(
                                                  i, model);
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    VerticalSpacing(height: 0.01),
                                  ],
                                ),
                              ],
                            ))
                      : ErrorView(
                          text: model.serverError,
                          onPressed: () => model.determinePosition(context),
                        ));
        });
  }

  _viewAllButton(String route, ProductsViewModel model, {data}) {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.shortestSide * 0.23,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(
            side: BorderSide(color: AppColor.lawnGreen),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () => _navigationService
              .navigateToAndBack(route, arguments: data)
              .then((value) => model.refresh()),
          child: Text(
            'View all',
            style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: FontSize.xl,
                fontWeight: FontWeight.w400),
          ),
        ));
  }

  _servicesContainer(Category category, ProductsViewModel model) {
    List<Category> subCategories =
        model.getSpecificSubCategories(category.name);
    return InkWell(
      child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(100),
            ),
          ),
          child: Container(
            height: 100,
            width: 140,
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(100),
                )),
            child: Column(
              children: [
                // VerticalSpacing(height: 0.01),

                Container(
                  height: 140,
//                width: 100,
                  child: category.imageUrl == null
                      ? Image.asset(
                          'assets/image/fresh9_home_view.png',
                          height: 140,
                        )
                      : CachedNetworkImage(
                          imageUrl: category.imageUrl,
                          placeholder: (context, url) => Loading.imageLoading(),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/image/placeholder.jpeg"),
                          fit: BoxFit.contain,
                        ),
                ),
//              Center(
//                child: Image.network(
//                        category['imageUrl'],
////                        height: 140,
//                      ),
////                height: 110,
//              ),

//            VerticalSpacing(height: 0.01),
                Center(
                  child: Text(
                    category.name,
                    style: TextStyle(
                        color: AppColor.primaryColor, fontSize: FontSize.m),
                  ),
                ),
                VerticalSpacing(height: 0.005),

                ClipPath(
                  clipper: TriangleClipper(),
                  child: Container(
                    height: 60,
                    width: 80,
                    decoration: BoxDecoration(color: AppColor.primaryColor),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Best',
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: FontSize.s),
                          ),
                          Text(
                            'Price',
                            style: TextStyle(color: AppColor.whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      onTap: () => _navigationService
          .navigateToAndBack(NavigationRouter.categoriesDetailView, arguments: {
        'categories': category,
        'subCategories': subCategories,
        'products': model.products
      }),
    );
  }

  _productContainer(Product product, ProductsViewModel model) {
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
                              width: 138,
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
                                          Image.asset(
                                              "assets/image/placeholder.jpeg"),
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

  _quantityButton(ProductsViewModel model, Product product) {
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

  _addToCartButton(ProductsViewModel model, Product product) {
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
            product.inventory == 0 ? "Out of Stock" : 'Add to cart',
            style: TextStyle(
                color: product.inventory == 0 ? Colors.grey : Color(0xff25D366),
                fontSize: FontSize.l,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
