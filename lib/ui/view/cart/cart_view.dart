import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/viewmodel/cart_view_model.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';
import 'package:fresh9_rider/ui/shared/loading.dart';
import 'package:fresh9_rider/ui/widget/horizontal_spacing.dart';
import 'package:fresh9_rider/ui/widget/vertical_spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatefulWidget {
  _CartView createState() => _CartView();
}

class _CartView extends State<CartView> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  onModelReady(model) {}

  cartItems(BuildContext context, CartViewModel model) {
    List<Product> _cartModelList =
        Provider.of<List<Product>>(context, listen: false);
    return Flexible(
        child: RawScrollbar(
            thumbColor: Colors.redAccent,
            radius: Radius.circular(20),
            isAlwaysShown: true,
            thickness: 10,
            child: ListView.builder(
                itemCount: _cartModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _cartInfo(_cartModelList[index], model, index);
                })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
          ),
          onPressed: () => _navigationService.goBack(),
        ),
        title: Text(
          'View Cart',
          style: TextStyle(color: AppColor.darkGrey),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: AppColor.primaryColor,
              ),
              onPressed: () {
                _navigationService.navigateToAndBack(
                    NavigationRouter.searchView,
                    arguments: {"products": <Product>[]});
              })
        ],
      ),
      body: ViewModelBuilder.reactive(
          viewModelBuilder: () => CartViewModel(),
          onModelReady: (model) => onModelReady(model),
          builder: (context, CartViewModel model, child) {
            return model.state == ViewState.loading
                ? Loading.normalLoading()
                : Column(
                    children: [
                      cartItems(context, model),
                      VerticalSpacing(height: 0.01),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(5.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(5.0),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sub Total',
                                style: TextStyle(
                                    color: AppColor.blackColor,
                                    fontSize: FontSize.xxl,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Rs ' + model.subTotal.toString(),
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: FontSize.xxl,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      VerticalSpacing(height: 0.01),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(5.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(5.0),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount',
                                style: TextStyle(
                                    color: AppColor.blackColor,
                                    fontSize: FontSize.xxl,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Rs ' + model.discount.toString(),
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: FontSize.xxl,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      VerticalSpacing(height: 0.01),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(5.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(5.0),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery Fee',
                                style: TextStyle(
                                    color: AppColor.blackColor,
                                    fontSize: FontSize.xxl,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Rs ' + model.deliveryFee.toString(),
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: FontSize.xxl,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),

                      model.wallet > 0
                          ? VerticalSpacing(height: 0.01)
                          : Container(),
                      model.wallet > 0
                          ? Material(
                              elevation: 3,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(5.0),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(5.0),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Wallet',
                                      style: TextStyle(
                                          color: AppColor.blackColor,
                                          fontSize: FontSize.xxl,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '- Rs ' + model.wallet.toString(),
                                      style: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontSize: FontSize.xxl,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      VerticalSpacing(height: 0.01),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(5.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(5.0),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Grand Total',
                                style: TextStyle(
                                    color: AppColor.blackColor,
                                    fontSize: FontSize.xxl,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Rs ' +
                                    (model.grandTotal < 0
                                            ? 0
                                            : model.grandTotal)
                                        .toString(),
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: FontSize.xxl,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
//          Flexible(child: Container()),
                      VerticalSpacing(height: 0.05),
                      _checkOutButton(model),
                      VerticalSpacing(height: 0.05),
                    ],
                  );
          }),
    );
  }

  _cartInfo(Product product, CartViewModel model, int index) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(14.0),
              )),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.only(),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                child: product.imageUrl == null
                    ? Image.asset(
                        'assets/image/fresh9_home_view.png',
                        height: 100,
                      )
                    : CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        placeholder: (context, url) => Loading.imageLoading(),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/image/placeholder.jpeg"),
                        fit: BoxFit.fitHeight,
                      ),
              ),
              HorizontalSpacing(width: 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 108,
                    child: Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColor.blackColor, fontSize: FontSize.m),
                    ),
                  ),
                  Text(
                    'Rs.' +
                        product.discountedPrice.toString() +
                        '/' +
                        product.increment.toString() +
                        product.unit,
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: FontSize.l,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Flexible(child: Container()),
              _quantityButton(product.quantity, model, index,
                  product.maxQuantity, product.inventory)
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  _quantityButton(int quantity, CartViewModel model, int index, int maxQuantity,
      int inventory) {
    {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColor.secondaryColor)),
        child: Row(
          children: [
            GestureDetector(
              child: Icon(
                quantity == 1
                    ? Icons.delete_outline
                    : Icons.remove_circle_outline,
                color: AppColor.secondaryColor,
              ),
              onTap: () {
                if (quantity > 1)
                  model.decrementQuantity(index);
                else
                  model.removeItem(index);
              },
            ),
            HorizontalSpacing(width: 0.02),
            Text(
              quantity.toString(),
              style: TextStyle(color: AppColor.secondaryColor),
            ),
            HorizontalSpacing(width: 0.02),
            GestureDetector(
              child: Icon(
                Icons.add_circle_outline,
                color: quantity == maxQuantity
                    ? Colors.grey
                    : AppColor.secondaryColor,
              ),
              onTap: inventory == 0
                  ? null
                  : () {
                      if (quantity < maxQuantity) model.addQuantity(index);
                    },
            ),
          ],
        ),
      );
    }
  }

  _checkOutButton(CartViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
//      width: MediaQuery.of(context).size.width / 0.8,
      child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width / 0.8,
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
                child: Row(
                  children: [
                    Flexible(child: Container()),
                    Text(
                      'Check Out',
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: FontSize.xl,
                          fontWeight: FontWeight.w500),
                    ),
                    Flexible(child: Container()),
                    Icon(
                      Icons.east,
                      color: Colors.white,
                    )
                  ],
                ),
                onPressed: () async {
                  if (model.subTotal <
                      model.minimumOrder) {
                    Dialog errorDialog = Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12.0)), //this right here
                      child: Container(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Text(
                                'Your order amount is less than minimum order limit',
                                style: TextStyle(
                                    fontSize: FontSize.xl,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                'Kindly add more items to reach minimum order limit of Rs. ${model.minimumOrder}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                        context: context,
                        builder: (BuildContext context) => errorDialog);
                  } else
                    _navigationService.navigateToAndBack(
                        NavigationRouter.placeOrderView,
                        arguments:
                            (model.grandTotal + model.wallet).toString());
                },
              ),
            ),
          )),
    );
  }
}
