import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';

class Loading {
  static normalLoading() {
    return Container(
      color: AppColor.whiteColor,
      child: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColor.primaryColor,
        ),
      ),
    ),);
  }

  static imageLoading() {
    return SpinKitThreeBounce(
      color: AppColor.darkGrey,
      size: 20.0,
    );
  }

}
