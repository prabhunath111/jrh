import 'package:flutter/material.dart';
import 'package:jrh_innoventure/styles/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
            'Home Screen'
        ),
        backgroundColor: secondary,
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Home Screen'
          ),
        ),
      ),
    );
  }
}
