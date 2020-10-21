import 'package:flutter/material.dart';

class VerticalSpacing extends StatelessWidget {
  final double height;

  VerticalSpacing({@required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * height,
      ),
    );
  }
}