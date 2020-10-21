import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final int maxLines;

  MyText(this.text, {this.style, this.textAlign, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style,
      maxLines: maxLines,
      minFontSize: 0,
      textAlign: textAlign,
    );
  }
}