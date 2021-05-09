import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jrh_innoventure/Utils/toast.dart';
import 'package:jrh_innoventure/services/firebase_services/firebase_service.dart';
import 'package:jrh_innoventure/styles/colors.dart';

class RegisterDoctor extends StatefulWidget {
  @override
  _RegisterDoctorState createState() => _RegisterDoctorState();
}

class _RegisterDoctorState extends State<RegisterDoctor> {
  File _image;
  final picker = ImagePicker();
  final baseUrl = 'localhost:3030/user';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String _mobile;
  String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: secondary,
        title: Text(
          'Doctor Detail',
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
          _addDoctors();
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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
          child: Form(
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
                        } else if (input.length < 10) {
                          return 'Provide 10 digit mobile number';
                        } else {}
                        return input;
                      },
                      decoration: InputDecoration(
                        labelText: 'Mobile',
                        hintText: 'Enter Mobile',
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: secondary)),
                      ),
                      maxLength: 10,
                      onChanged: (e) => _onChangehandler(true),
                      // onSaved: (input) => _mobile = input,
                    ),
                  ),
                  SizedBox(height: 8),
                  Theme(
                    data: ThemeData(primaryColor: primary),
                    child: TextFormField(
                      controller: _nameController,
                      cursorColor: primary,
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Provide name';
                        } else {}
                        return input;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name (As PAN Card)',
                        hintText: 'Enter Name',
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: secondary)),
                      ),
                      onChanged: (e) => _onChangehandler(false),
                      // onSaved: (input) => _mobile = input,
                    ),
                  )
                ],
              )),
        ),
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

  _onChangehandler(bool isMobile) {
    if (isMobile) {
      _mobile = _mobileController.text;
    } else {
      _name = _nameController.text;
    }
  }

  Future<void> _addDoctors() async{
    CollectionReference doctors =
        FirebaseFirestore.instance.collection('doctors');
    var a = await FirebaseServices().getFromDatabase(doctors);
    // print("Line217 ${a.data.data()}");
    print("line218 ${a.data()['mobile']}");
    // Call the user's CollectionReference to add a new user
    var data = {
      'name': _name,
      'mobile': _mobile
    };
    await FirebaseServices().saveToDatabase(doctors, data);
  }
}
