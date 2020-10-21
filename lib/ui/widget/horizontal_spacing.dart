import 'package:flutter/material.dart';

class HorizontalSpacing extends StatelessWidget {
  final double width;

  HorizontalSpacing({@required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.height * width,
      ),
    );
  }
}