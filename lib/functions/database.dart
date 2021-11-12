import 'package:cloud_firestore/cloud_firestore.dart';

create(String colName, docName, email, password) async {
  await FirebaseFirestore.instance
      .collection(colName)
      .doc(docName)
      .set({'email': email, 'password': password});
}

update(String colName, docName, email, password) async {
  await FirebaseFirestore.instance
      .collection(colName)
      .doc(docName)
      .set({'email': email, 'password': password});
}

delete(String colName, docName) async {
  await FirebaseFirestore.instance.collection(colName).doc(docName).delete();
}
