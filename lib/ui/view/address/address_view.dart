 import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/horizontal_spacing.dart';
import 'package:Product/ui/widget/vertical_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressView extends StatefulWidget{
  _AddressView createState()=> _AddressView();
}
class _AddressView extends State<AddressView>{
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
   return Scaffold (
     appBar: AppBar(
       leading: IconButton(
           icon: Icon(
             Icons.arrow_back,
             color: AppColor.primaryColor,
           ),
           onPressed: () => _navigationService.navigateTo(NavigationRouter.addAddress)),
       title: Text(
         'Addresses',
         style: TextStyle(color: AppColor.darkGrey),
       ),
     ),
     body: Column(children: [
       VerticalSpacing(height: 0.02),
       Center(child: _addressCard(),),
       VerticalSpacing(height: 0.02),
       Center(child: _image(),),
       VerticalSpacing(height: 0.5),
      Row(children: [HorizontalSpacing(width: 0.4),
        _addButton()],)
     ],),
   );
  }
  _addressCard(){
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColor.blackColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        // height: MediaQuery.of(context).size.height/3,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Column(
          children: [
            VerticalSpacing(height: 0.01),
            Row(
              children: [
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.apartment_sharp,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                HorizontalSpacing(width: 0.01),
                new Flexible(
                  child: SizedBox(
                    width: 250,
                    child: new TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Lahore',
                        hintStyle: TextStyle(
                            color: AppColor.darkGrey, fontSize: FontSize.xl),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            VerticalSpacing(height: 0.01),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.home_outlined,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                HorizontalSpacing(width: 0.01),
                new Flexible(
                  child: SizedBox(
                    width: 250,
                    child: new TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Central Park housing scheme',
                            hintStyle: TextStyle(
                                color: AppColor.darkGrey,
                                fontSize: FontSize.xl))),
                  ),
                ),
                HorizontalSpacing(width: 0.05),
                IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColor.redColor,
                      size: 20,
                    ),
                    onPressed: () =>
                        _navigationService.navigateTo(NavigationRouter.editProfile))
              ],
            ),
            Row(
              children: [
                HorizontalSpacing(width: 0.01),
                Icon(
                  Icons.home_outlined,
                  color: AppColor.darkGrey,
                  size: 20,
                ),
                HorizontalSpacing(width: 0.01),
                SizedBox(
                  width: 250,
                  child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          hintText: 'House# 528 Block A St 2',
                          hintStyle: TextStyle(
                              color: AppColor.darkGrey,
                              fontSize: FontSize.xl))),
                ),
              ],
            ),
            VerticalSpacing(height: 0.02)
          ],
        ),
      ),
    );
  }
  _image(){
    return Center(child: Image.asset('p_logo.png'),);
  }
  _addButton(){
    return MaterialButton(onPressed: ()=>_navigationService.navigateTo(NavigationRouter.yourAddress),
    color: AppColor.redColor,
    child: Icon(Icons.add,color: AppColor.whiteColor,),
      padding: EdgeInsets.all(15.0),
    shape: CircleBorder(),);
  }
  }
