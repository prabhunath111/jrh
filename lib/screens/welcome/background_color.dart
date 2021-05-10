import 'package:flutter/material.dart';
import 'package:jrh_innoventure/styles/colors.dart';

class BgColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.6,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [primary, secondary]),
          borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(height * 0.25))),
    );
  }
}
