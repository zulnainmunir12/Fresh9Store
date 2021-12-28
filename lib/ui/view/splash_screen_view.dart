import 'dart:async';
import 'dart:convert';
import 'package:fresh9_rider/core/model/login_model.dart';
import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/ui/shared/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashScreenView extends StatefulWidget {
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/splash.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.play();
      });
    getUser();
  }

  getUser() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
//    sharedPreference.clear();
    String user = sharedPreference.getString(
      SharedPreference.user,
    );

    Timer(Duration(seconds: 3), () {
      if (user != null) {
        _authService.addUserDataToService(
            LoginModel.fromJson(jsonDecode(user)).userInfo);
        _navigationService.navigateTo(NavigationRouter.appServices);
      } else
        _navigationService.navigateTo(NavigationRouter.landingScreen);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: _controller.value.isInitialized
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
    );
  }
}
