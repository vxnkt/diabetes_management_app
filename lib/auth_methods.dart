import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String name,
    required int age,
    required String gender,
    required String mobile,
    required String diabetesType,
    required String diabetesDuration,
    required String email,
    required String password,
  }) async {
    String res = "Something went wrong";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection("users").doc(cred.user!.uid).set({
        "name": name,
        "age": age,
        "gender": gender,
        "mobile": mobile,
        "diabetesType": diabetesType,
        "diabetesDuration": diabetesDuration,
        "email": email,
        "uid": cred.user!.uid,
      });

      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Something went wrong";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
