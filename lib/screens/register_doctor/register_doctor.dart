import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jrh_innoventure/Utils/toast.dart';
import 'package:jrh_innoventure/constants/strings.dart';
import 'package:jrh_innoventure/services/firebase_services/firebase_service.dart';
import 'package:jrh_innoventure/styles/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class RegisterDoctor extends StatefulWidget {
  @override
  _RegisterDoctorState createState() => _RegisterDoctorState();
}

class _RegisterDoctorState extends State<RegisterDoctor> {
  final picker = ImagePicker();
  final baseUrl = 'localhost:3030/user';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  var storage = FirebaseStorage.instance;
  bool isDeclaration = false;
  bool isTermsCondition = false;
  bool isAllRequiredFilled = false;
  bool isLoading = false;

  CollectionReference imgRef;
  firebase_storage.Reference ref;

  List _filesList = [];
  List _imageUrls = [];
  String _mobile;
  String _name;
  String _selfDeclaration =
      'I hereby declare that above submitted docs are correct.';
  File _aadhar;
  File _pan;
  File _cv;
  File _image;
  File _degreeCertificate;
  File _registrationCertificate;
  File _signImage;
  File _expLetter;
  File _lastPaySlip;

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
      body: (isLoading)
          ? Center(
              child: Card(
              clipBehavior: Clip.antiAlias,
              color: primary,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: secondary,
                      valueColor: new AlwaysStoppedAnimation<Color>(white),
                    ),
                    Text("Please wait", style: TextStyle(
                      color: white,
                      fontSize: 20
                    ))
                  ],
                ),
              ),
            ))
          : _getBody(),
    );
  }

  Widget _getBody() {
    return ListView(
      children: [
        getCards(
            'Upload Aadhar',
            Icon(
              (_aadhar == null) ? Icons.upload_sharp : Icons.done,
              color: (_aadhar == null) ? grey : secondary,
            )),
        getCards(
            'Upload PAN',
            Icon(
              (_pan == null) ? Icons.upload_sharp : Icons.done,
              color: (_pan == null) ? grey : secondary,
            )),
        getCards(
            'Upload CV',
            Icon((_cv == null) ? Icons.upload_sharp : Icons.done,
                color: (_cv == null) ? grey : secondary)),
        getCards(
            'Degree Certificate',
            Icon(
              (_degreeCertificate == null) ? Icons.upload_sharp : Icons.done,
              color: (_degreeCertificate == null) ? grey : secondary,
            )),
        getCards(
            'Registration Certificate',
            Icon(
                (_registrationCertificate == null)
                    ? Icons.upload_sharp
                    : Icons.done,
                color: (_registrationCertificate == null) ? grey : secondary)),
        getCards(
            'Upload Image',
            Icon((_image == null) ? Icons.upload_sharp : Icons.done,
                color: (_image == null) ? grey : secondary)),
        getCards(
            'Signature Image',
            Icon((_signImage == null) ? Icons.upload_sharp : Icons.done,
                color: (_signImage == null) ? grey : secondary)),
        getCards(
            'Experience Letter(Optional)',
            Icon(
              (_expLetter == null) ? Icons.upload_sharp : Icons.done,
              color: (_expLetter == null) ? grey : secondary,
            )),
        getCards(
            'Last Pay Slip(Optional)',
            Icon((_lastPaySlip == null) ? Icons.upload_sharp : Icons.done,
                color: (_lastPaySlip == null) ? grey : secondary)),
        getmobileWidget(),
        getDeclarationText(),
        getTermsCondition(),
        getSubmitBtn()
      ],
    );
  }

  Widget getCards(String title, Icon icon) {
    return InkWell(
      onTap: () async {
        FilePickerResult result = await FilePicker.platform.pickFiles();
        if (result != null) {
          File file = File(result.files.single.path);
          if (title == 'Upload Aadhar') {
            setState(() {
              _aadhar = file;
              _filesList.add(_aadhar);
            });
          } else if (title == 'Upload PAN') {
            setState(() {
              _pan = file;
              _filesList.add(_pan);
            });
          } else if (title == 'Upload CV') {
            setState(() {
              _cv = file;
              _filesList.add(_cv);
            });
          } else if (title == 'Degree Certificate') {
            setState(() {
              _degreeCertificate = file;
              _filesList.add(_degreeCertificate);
            });
          } else if (title == 'Registration Certificate') {
            setState(() {
              _registrationCertificate = file;
              _filesList.add(_registrationCertificate);
            });
          } else if (title == 'Signature Image') {
            setState(() {
              _signImage = file;
              _filesList.add(_signImage);
            });
          } else if (title == 'Experience Letter(Optional)') {
            setState(() {
              _expLetter = file;
              _filesList.add(_expLetter);
            });
          } else if (title == 'Last Pay Slip(Optional)') {
            setState(() {
              _lastPaySlip = file;
              _filesList.add(_lastPaySlip);
            });
          } else if (title == 'Upload Image') {
            setState(() {
              _image = file;
              _filesList.add(_image);
            });
          } else {}
        } else {
          // User canceled the picker
          print("Line68 Didn't pick aadhar...");
        }
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
        onTap: () async {
          if (_formKey.currentState.validate()) {
            // Upload image
            bool isValidation = (_aadhar != null &&
                _pan != null &&
                _cv != null &&
                _degreeCertificate != null &&
                _registrationCertificate != null &&
                _image != null &&
                _signImage != null &&
                isDeclaration &&
                isTermsCondition);
            print("Line160 $isValidation");
            if (isValidation) {
              setState(() {
                isLoading = true;
              });
              List idList = await FirebaseServices().getFromDatabase('doctors');
              if (idList.contains(_mobile)) {
                print('$_mobile is present in the list $idList');
                ToastCustom().showToast('Already Registered', false);
              } else {
                for (int i = 0; i < _filesList.length; i++) {
                  await uploadFile(_filesList[i]);
                  print("Line257 ${_imageUrls.length}");
                }
                // print("Line133 ${_imageUrls.length}");
                _addDoctors();
              }
            } else {
              ToastCustom().showToast('Select required files', false);
            }
          }
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

  _onChangehandler(bool isMobile) {
    if (isMobile) {
      _mobile = _mobileController.text;
    } else {
      _name = _nameController.text;
    }
  }

  Future<void> _addDoctors() async {
    // _nameController.clear();
    // _mobileController.clear();
    // FocusScope.of(context).unfocus();
    String doctor = 'doctors';
    print('$_mobile is not present in the list $_mobile');
    Map<String, dynamic> data = {
      'name': _name,
      'mobile': _mobile,
      'status': 'unverified',
      'aadhar': _imageUrls[0],
      'pan': _imageUrls[1],
      'cv': _imageUrls[2],
      'degreeCertificate': _imageUrls[3],
      'registration': _imageUrls[4],
      'image': _imageUrls[5],
      'sign': _imageUrls[6],
      'experience': (_imageUrls.length>=8)?_imageUrls[7]:'null',
      'paySlip': (_imageUrls.length>=9)?_imageUrls[8]:'null',
      'createdAt': DateTime.now()
    };
    await FirebaseServices().saveToDatabase(doctor, data);
    setState(() {
      isLoading = false;
    });
    ToastCustom().showToast('Registered successfully', true);
    Navigator.pop(context);
  }

  Future<void> uploadFile(File file) async {
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(_mobile.toString() + file.path.split('/').last);
    await ref.putFile(file).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        _imageUrls.add(value);
        // imgRef.add({'url': value});
      });
    });
  }

  Widget getDeclarationText() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                    activeColor: secondary,
                    value: isDeclaration,
                    onChanged: (v) {
                      setState(() {
                        isDeclaration = !isDeclaration;
                      });
                    }),
                Expanded(
                  child: Text(
                    _selfDeclaration,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getTermsCondition() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                    activeColor: secondary,
                    value: isTermsCondition,
                    onChanged: (v) {
                      setState(() {
                        isTermsCondition = !isTermsCondition;
                      });
                    }),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Accept? ',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(),
                      ),
                      FlatButton(onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(context),
                        );
                      }, child: Text(
                        'Terms & Conditions',
                        style: TextStyle(color: primary),
                      ))
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Center(child: const Text('Terms & Conditions')),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(TERMS_CONDS),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close', style: TextStyle(color: primary),),
        ),
      ],
    );
  }
}
