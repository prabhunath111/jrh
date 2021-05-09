import 'package:flutter/material.dart';
import 'package:jrh_innoventure/screens/otp/otp.dart';
import 'package:jrh_innoventure/screens/welcome/background_color.dart';
import 'package:jrh_innoventure/screens/welcome/welcome_text.dart';
import 'package:jrh_innoventure/styles/colors.dart';

import 'register_row.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mobileController = TextEditingController();
  String _mobile;

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
        BgColor(),
        WelcomeText(),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
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
                                  controller: _mobileController,
                                  keyboardType: TextInputType.number,
                                  cursorColor: primary,
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return 'Provide mobile number';
                                    }
                                    else if (input.length < 10) {
                                      return 'Provide 10 digit mobile number';
                                    }
                                    return input;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Mobile',
                                    hintText: 'Enter Mobile',
                                    counterText: "",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            BorderSide(color: secondary)),
                                  ),
                                  maxLength: 10,
                                  onChanged: (e) => _onChangehandler(),
                                  // onSaved: (input) => _mobile = input,
                                ),
                              ),
                            ],
                          )),
                      RegisterRow(isDoctor: true),
                      RegisterRow(isDoctor: false),
                      InkWell(
                        onTap: () {
                          sendOtp();
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
      ],
    );
  }

  void sendOtp() {
    if (_formKey.currentState.validate()) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => OtpScreen(mobile: _mobile)));
    }
  }

  _onChangehandler() {
    _mobile = _mobileController.text;
  }
}
