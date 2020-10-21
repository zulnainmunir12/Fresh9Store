import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/locator.dart';
import 'package:Product/ui/router.dart';


class SplashScreenView extends StatefulWidget {
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        ()=>_navigationService.navigateTo(NavigationRouter.landingScreen));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
         child: Image.asset('assets/image/logo.png',height: 250,),
        ),
      ),
    );
  }
}
