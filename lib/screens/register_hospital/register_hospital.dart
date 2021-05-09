import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jrh_innoventure/Utils/toast.dart';
import 'package:jrh_innoventure/styles/colors.dart';

class RegisterHospital extends StatefulWidget {
  @override
  _RegisterHospitalState createState() => _RegisterHospitalState();
}

class _RegisterHospitalState extends State<RegisterHospital> {
  File _image;
  final picker = ImagePicker();
  final baseUrl = 'localhost:3030/user';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mobileController = TextEditingController();
  String _mobile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.withOpacity(0.5),
        title: Text(
          'Hospital Detail',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: _getBody(),
    );
  }
  Widget _getBody() {
    return ListView(
      children: [
        getCards('Upload Aadhar', Icon(Icons.upload_sharp)),
        getCards('Upload PAN', Icon(Icons.upload_sharp)),
        getCards('Upload CV', Icon(Icons.upload_sharp)),
        getCards('Upload Image', Icon(Icons.upload_sharp)),
        getmobileWidget(),
        getSubmitBtn()
      ],
    );
  }
  Widget getCards(String title, Icon icon) {
    return InkWell(
      onTap: () {
        getImage();
      },
      child: Card(
        elevation: 1,
        shadowColor: Colors.greenAccent,
        child: Container(
          height: 60,
          // width: MediaQuery.of(context).size.width * 0.1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 1.5),
                ),
                icon
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget getSubmitBtn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // _upload(_image);
        },
        child: Container(
          height: 60,
          // width: MediaQuery.of(context).size.width * 0.1,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.green, Colors.greenAccent]),
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'SUBMIT',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.5,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget getmobileWidget() {
    return Container(
      // height: 60,
      // width: MediaQuery.of(context).size.width * 0.1,
      child:
      Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child:
        Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Theme(
                  data: ThemeData(primaryColor: primary),
                  child: TextFormField(
                    controller: _mobileController,
                    cursorColor: primary,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Provide mobile number';
                      }
                      if (input.length < 10) {
                        return 'Provide 10 digit mobile number';
                      }
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
                    onChanged: (e)=>_onChangehandler(),
                    // onSaved: (input) => _mobile = input,
                  ),
                ),
              ],
            )),
      ),
    );
  }
  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('line154 $_image');
      } else {
        ToastCustom().showToast('No image selected.');
        // print('No image selected.');
      }
    });
  }

  _onChangehandler() {
    _mobile = _mobileController.text;
  }
}
