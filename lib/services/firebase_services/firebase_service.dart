import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jrh_innoventure/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseServices {
  Future saveToDatabase(String collection, Map data) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(data['mobile'])
        .set(data)
        .then((value) {

    });
  }

  updateToDatabase() {}

  saveImageToDatabase() {}

  updateImageToDatabase() {}

  getFromDatabase(String collection) async {
    List a = [];
    await FirebaseFirestore.instance
        .collection(collection)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print('Line28 ${doc["name"]}');
        a.add(doc["mobile"]);
      });
    }).catchError((onError) {
      print("Line31 $onError");
    });
    return a;
  }
}
