import 'package:Product/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Product());
}
class Product extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Product',
      home: Splash(),

    );
  }

}