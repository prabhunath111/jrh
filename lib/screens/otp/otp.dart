import 'package:flutter/material.dart';
import 'package:jrh_innoventure/screens/home/home.dart';
import 'package:jrh_innoventure/screens/welcome/background_color.dart';
import 'package:jrh_innoventure/screens/welcome/welcome_text.dart';
import 'package:jrh_innoventure/styles/colors.dart';

class OtpScreen extends StatefulWidget {
  final mobile;

  const OtpScreen({Key key, this.mobile}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _otp;
  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
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
                                    controller: _otpController,
                                    cursorColor: primary,
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Provide OTP number';
                                      } else if(input.length < 4){
                                        return 'Provide 4 digit OTP';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'OTP',
                                      hintText: 'Enter OTP',
                                      counterText: '',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide:
                                              BorderSide(color: secondary)),
                                    ),
                                    maxLength: 4,
                                    onChanged: (e)=>_onChangehandler(),
                                    // onSaved: (input) => _otp = input,
                                  ),
                                ),
                              ],
                            )),
                        InkWell(
                          onTap: () {
                            verifyOtp();
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
          )
        ],
      ),
    );
  }

  void verifyOtp() {
    if(_formKey.currentState.validate()){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }

  _onChangehandler() {
    _otp = _otpController.text;
  }
}
