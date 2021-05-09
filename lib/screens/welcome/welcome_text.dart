import 'package:flutter/material.dart';
import 'package:jrh_innoventure/styles/colors.dart';

class WelcomeText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Positioned(
      top: height * 0.2,
      right: 0,
      left: 0,
      child: Center(
        child: Text(
          '~ Welcome ~',
          style: TextStyle(
              color: white,
              fontSize: width * 0.11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5),
        ),
      ),
    );
  }
}
