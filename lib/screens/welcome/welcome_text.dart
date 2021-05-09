import 'package:flutter/material.dart';
import 'package:jrh_innoventure/styles/colors.dart';

class WelcomeText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Positioned(
      top: height * 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          '~ Welcome ~',
          style: TextStyle(
              color: white,
              fontSize: width * 0.15,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      ),
    );
  }
}
