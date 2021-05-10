import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastCustom {
  showToast(String msg, bool isSuccess){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: (isSuccess)?Colors.greenAccent:Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}