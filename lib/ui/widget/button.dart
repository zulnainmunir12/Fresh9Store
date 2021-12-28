import 'package:flutter/material.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';

class MyButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  final Color backColor;
  final Color textColor;
  final bool star;
  final double verticalSpacing;
  final double borderRadius;
  final double width;
  final double height;

  MyButton(
      {@required this.text,
      @required this.onPressed,
      this.backColor = AppColor.whiteColor,
      this.textColor = AppColor.lightestLightestGrey,
      this.star = true,
      this.verticalSpacing = 10,
      this.borderRadius = 20,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == null ? MediaQuery.of(context).size.width : width,
      height: height == null ? 45 : height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300].withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, -2), // changes position of shadow
            ),
          ]),

      // ignore: deprecated_member_use
      child: RaisedButton(
        splashColor: Colors.red.shade50,
        highlightColor: Colors.red.shade50,
        child: Text(
          text,
          style: TextStyle(
            color: AppColor.primaryColor,
            fontSize: FontSize.xl,
            fontWeight: FontWeight.w600,
          ),
        ),
//        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
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
      height: 45,
      width: width == null ? MediaQuery.of(context).size.width : width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300].withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, -2), // changes position of shadow
            ),
          ]),
      child: RaisedButton(
        splashColor: Colors.red.shade50,
        highlightColor: Colors.red.shade50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image,
              height: MediaQuery.of(context).size.shortestSide * 0.04,
            ),
            Text(
              text,
              style: TextStyle(
                color: AppColor.blackColor,
                fontSize: FontSize.xl,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
//        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
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
