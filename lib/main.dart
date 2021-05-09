import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home/home.dart';
import 'screens/welcome/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Welcome(),
          '/welcome': (context) => Welcome(),
          'home': (context) => HomeScreen()
        }));
}
