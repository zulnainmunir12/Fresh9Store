import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppServices extends StatefulWidget {
  _AppServices createState() => _AppServices();
}

class _AppServices extends State<AppServices> {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ListView(children: [
        Column(
          children: [
            VerticalSpacing(height: 0.03),
            _screenContainer()
          ],
        ),
      ]
      ),
    );
  }
  _screenContainer(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              elevation: 7,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Container(
                width: MediaQuery.of(context).size.shortestSide * 0.47,
                height: MediaQuery.of(context).size.shortestSide * 0.84,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                   child: Column(
                     children: [
                       VerticalSpacing(height: 0.0001),
                       Image.asset('assets/image/fresh9_store.png'),
                       VerticalSpacing(height: 0.001),
                       Container(
                           margin: EdgeInsets.only(top: 10.0, bottom: 10.0,right: 50),
                           child: Text('Fresh9store',style: TextStyle(
                               fontSize: FontSize.xxxl
                               ,color: AppColor.primaryColor,fontWeight: FontWeight.bold
                           ),),),
                       Container(
                         margin: EdgeInsets.only(top: 8.0, bottom: 10.0,left: 8),
                         child: Text('Fresh fruits,fresh vegetables,\ fresh meat fresh dairy,\ grocery',style: TextStyle(
                             fontSize: FontSize.l
                             ,color: AppColor.darkGrey
                         ),),),
                       Container(
                         margin: EdgeInsets.only(top: 10.0, bottom: 10.0,right: 75),
                         child: _shopButton()),
                       // Padding(padding: EdgeInsets.only(right: 70,top: 8),
                       // child: _shopButton(),)
                     ],
                   ),
                 ),
               ),
              ),

            Material(
              elevation: 7,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Container(
                width: MediaQuery.of(context).size.shortestSide * 0.47,
                height: MediaQuery.of(context).size.shortestSide * 0.84,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      VerticalSpacing(height: 0.0001),
                      Image.asset('assets/image/other_shops.png'),
                      VerticalSpacing(height: 0.001),
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0,right: 50),
                        child: Text('Other shops',style: TextStyle(
                            fontSize: FontSize.xxxl
                            ,color: AppColor.primaryColor,fontWeight: FontWeight.bold
                        ),),),
                      Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 10.0,left: 8),
                        child: Text('Grocery, medicine,\ panshop and more',style: TextStyle(
                            fontSize: FontSize.l
                            ,color: AppColor.darkGrey
                        ),),),
                      Container(
                          margin: EdgeInsets.only(top: 30.0, bottom: 10.0,right: 75),
                          child: _otherShopButton(),
                      // Padding(padding: EdgeInsets.only(right: 70,top: 8),
                     )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        VerticalSpacing(height: 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              elevation: 7,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Container(
                width: MediaQuery.of(context).size.shortestSide * 0.47,
                height: MediaQuery.of(context).size.shortestSide * 0.84,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      VerticalSpacing(height: 0.0001),
                      Image.asset('assets/image/restarunt.png'),
                      VerticalSpacing(height: 0.001),
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0,right: 50),
                        child: Text('Restaurants',style: TextStyle(
                            fontSize: FontSize.xxxl
                            ,color: AppColor.primaryColor,fontWeight: FontWeight.bold
                        ),),),
                      Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 10.0,left: 8),
                        child: Text('Pizza, burgers, karahi\ naan and more',style: TextStyle(
                            fontSize: FontSize.l
                            ,color: AppColor.darkGrey
                        ),),),
                      Container(
                          margin: EdgeInsets.only(top: 30.0, bottom: 10.0,right: 75),
                          child: _orderButton()),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              elevation: 7,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Container(
                width: MediaQuery.of(context).size.shortestSide * 0.45,
                height: MediaQuery.of(context).size.shortestSide * 0.84,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      VerticalSpacing(height: 0.0001),
                      Image.asset('assets/image/services.png'),
                      VerticalSpacing(height: 0.001),
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0,right: 50),
                        child:  Text('Services',style: TextStyle(
                            fontSize: FontSize.xxxl
                            ,color: AppColor.primaryColor,fontWeight: FontWeight.bold
                        ),),),
                      Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 10.0,left: 8),
                        child: Text('Delivery boy, electrician\ Plumber and more',style: TextStyle(
                            fontSize: FontSize.l
                            ,color: AppColor.darkGrey
                        ),),),
                      Container(
                          margin: EdgeInsets.only(top: 30.0, bottom: 10.0,right: 75),
                          child: _serviceButton()),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
  _shopButton(){
    return FlatButton(onPressed: ()=> _navigationService.navigateTo(NavigationRouter.fresh9View)
        , child: Text('Shop now',style: TextStyle(
      fontSize: FontSize.xl,color: AppColor.primaryColor,fontWeight: FontWeight.bold
    ),));
  }
  _otherShopButton(){
    return FlatButton(onPressed: ()=> _navigationService.navigateTo(NavigationRouter.shopsView)
        , child: Text('Shop now',style: TextStyle(
            fontSize: FontSize.xl,color: AppColor.primaryColor,fontWeight: FontWeight.bold
        ),));
  }
  _orderButton(){
    return FlatButton(onPressed: ()=> _navigationService.navigateTo(NavigationRouter.restaurantView), child: Text('Order now',style: TextStyle(
        fontSize: FontSize.l,color: AppColor.primaryColor,fontWeight: FontWeight.bold
    ),));
  }
  _serviceButton(){
    return FlatButton(onPressed: ()=> _navigationService.navigateTo(NavigationRouter.servicesView), child:
    Text('Service now',style: TextStyle(
        fontSize: FontSize.m,color: AppColor.primaryColor,fontWeight: FontWeight.bold
    ),)
    );
  }
}
