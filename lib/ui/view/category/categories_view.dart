import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/category_model.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/categories_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/customAppbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CategoriesView extends StatefulWidget {
  List<Product> products;
  CategoriesView(this.products);
  _Categories createState() => _Categories();
}

class _Categories extends State<CategoriesView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final CartService _cartService = locator<CartService>();
//  int get itemCount => ;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => CategoriesViewModel(),
        onModelReady: (model) => onModelReady(model),
        builder: (context, CategoriesViewModel model, child) {
          return Scaffold(
              backgroundColor: AppColor.lightGrey,
              appBar: customAppBarWithTitle(
                  'Categories', _cartService.cartModelDataList.length, model,
                  products: widget.products),
              body: model.state == ViewState.loading
                  ? Loading.normalLoading()
                  : body(model));
        });
  }

  onModelReady(CategoriesViewModel model) {
    print("category");
    print(widget.products);
    model.getProducts(widget.products);
  }

  body(CategoriesViewModel model) {
    return model.categories.length == 0
        ? Container(
            child: Center(
            child: Text(
              "No item available at the moment!",
              style: TextStyle(fontSize: 18),
            ),
          ))
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: model.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return _categoryCard(model.categories[index], model);
            },
          );
  }

  _categoryCard(Category category, CategoriesViewModel model) {
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
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
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
                                        'products': model.products,
                                        'selected': subCategories[index].name
                                      }));
                        }),
                  )
          ])),
      onTap: () => _navigationService
          .navigateToAndBack(NavigationRouter.categoriesDetailView, arguments: {
        'categories': category,
        'subCategories': subCategories,
        'products': model.products
      }),
    );
  }
}
