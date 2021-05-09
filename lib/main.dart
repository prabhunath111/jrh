import 'package:flutter/material.dart';
import 'screens/home/home.dart';
import 'screens/welcome/welcome.dart';

void main() => runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Welcome(),
          '/welcome': (context) => Welcome(),
          'home': (context) => HomeScreen()
        }));
