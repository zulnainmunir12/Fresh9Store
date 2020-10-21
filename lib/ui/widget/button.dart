import 'package:flutter/material.dart';
import 'package:Product/ui/shared/app_colors.dart';
import 'package:Product/ui/shared/font_size.dart';
import 'package:Product/ui/widget/my_text.dart';

class MyButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  final Color backColor;
  final Color textColor;
  final bool star;
  final double verticalSpacing;
  final double borderRadius;
  final double width;

  MyButton(
      {@required this.text,
      @required this.onPressed,
      this.backColor = AppColor.whiteColor,
      this.textColor = AppColor.lightestLightestGrey,
      this.star = true,
      this.verticalSpacing = 10,
      this.borderRadius = 20,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == null ? MediaQuery.of(context).size.width : width,
      child: RaisedButton(
        child: MyText(
          text,
          style: TextStyle(
            color: AppColor.primaryColor,
            fontSize: FontSize.xl,
            fontWeight: FontWeight.w400,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
        color: backColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  final Color backColor;
  final Color textColor;
  final bool star;
  final double verticalSpacing;
  final double borderRadius;
  final double width;
  final String image;

  SocialMediaButton(
      {@required this.text,
      @required this.onPressed,
      @required this.image,
      this.backColor = AppColor.whiteColor,
      this.textColor = AppColor.lightestLightestGrey,
      this.star = true,
      this.verticalSpacing = 10,
      this.borderRadius = 20,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == null ? MediaQuery.of(context).size.width : width,
      child: RaisedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image,
              height: MediaQuery.of(context).size.shortestSide * 0.06,
            ),
            MyText(
              text,
              style: TextStyle(
                color: AppColor.blackColor,
                fontSize: FontSize.xl,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
        color: backColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
