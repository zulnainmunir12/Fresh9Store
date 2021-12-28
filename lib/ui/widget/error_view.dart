import 'package:flutter/material.dart';
//import 'package:Product/core/app_config/localization/app_localizaton.dart';
//import 'package:Product/core/app_config/localization/text_model.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:fresh9_rider/ui/shared/font_size.dart';

class ErrorView extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;

  ErrorView({@required this.onPressed, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "No internet Connection",
            style: TextStyle(
              color: AppColor.normalBlack,
              fontSize: FontSize.l,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          RaisedButton(
            child: Text("Retry"),
            onPressed: onPressed,
            textColor: Colors.white,
            color: AppColor.primaryColor,
          )
        ],
      ),
    );
  }
}
