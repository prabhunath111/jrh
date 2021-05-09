import 'package:flutter/material.dart';
import 'package:jrh_innoventure/screens/register_doctor/register_doctor.dart';
import 'package:jrh_innoventure/screens/register_hospital/register_hospital.dart';
import 'package:jrh_innoventure/styles/colors.dart';

class RegisterRow extends StatelessWidget {
  final isDoctor;

  const RegisterRow({Key key, this.isDoctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (isDoctor)
              ? Text('Are you a new Doctor ?')
              : Text('Are you a new Hospital ?'),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          (isDoctor) ? RegisterDoctor() : RegisterHospital()));
            },
            child: Text(
              ' REGISTER',
              style: TextStyle(color: secondary, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
