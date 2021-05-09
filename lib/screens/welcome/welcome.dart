import 'package:flutter/material.dart';
import 'package:jrh_innoventure/styles/colors.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _mobile;
  bool isOtp = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _getBody(height, width),
    );
  }

  _getBody(double height, double width) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          color: greyBackground,
        ),
        Container(
          height: height * 0.6,
          width: width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [primary, secondary]),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(height * 0.25))),
        ),
        Positioned(
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
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Visibility(
            visible: !isOtp,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                // height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                  // color: secondary,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // color: primary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Theme(
                                  data: ThemeData(primaryColor: primary),
                                  child: TextFormField(
                                    cursorColor: primary,
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Provide mobile number';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Mobile',
                                      hintText: 'Enter Mobile',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide:
                                              BorderSide(color: secondary)),
                                    ),
                                    onSaved: (input) => _mobile = input,
                                  ),
                                ),
                              ],
                            )),
                        InkWell(
                          onTap: () => sendOtp(),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: secondary),
                              child: Center(
                                child: Text(
                                  'Send OTP',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Visibility(
            visible: isOtp,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                // height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // color: secondary,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // color: primary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Theme(
                                  data: ThemeData(primaryColor: primary),
                                  child: TextFormField(
                                    cursorColor: primary,
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Provide mobile number';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'OTP',
                                      hintText: 'Enter OTP',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide:
                                              BorderSide(color: secondary)),
                                    ),
                                    onSaved: (input) => _mobile = input,
                                  ),
                                ),
                              ],
                            )),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isOtp = true;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: secondary),
                              child: Center(
                                child: Text(
                                  'Verify',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void sendOtp() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isOtp = true;
      });
    }
  }
}
