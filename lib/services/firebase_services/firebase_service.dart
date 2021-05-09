import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jrh_innoventure/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseServices {
  Future saveToDatabase(CollectionReference collection, Object data) async {
    await collection.add(data).then((value) async {
      Constants.prefs = await SharedPreferences.getInstance();
      await Constants.prefs.setString('doctor_id', value.id.toString());
      return value;
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  updateToDatabase() {}

  saveImageToDatabase() {}

  updateImageToDatabase() {}

  getFromDatabase(CollectionReference collection) async {
    Constants.prefs = await SharedPreferences.getInstance();

    var id = Constants.prefs.getString('doctor_id');
    print("Line26 $id");
    return await collection.doc(id).get();
  }
}
