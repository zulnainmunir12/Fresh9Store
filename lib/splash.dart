import 'dart:async';
import 'package:Product/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile())));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
         child: Image.asset('logo.png',height: 250,),
        ),
      ),
    );
  }
}
