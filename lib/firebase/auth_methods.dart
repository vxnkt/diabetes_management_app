import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> signupUser({
    required String email,
    required String password,
    required String mobileNumber,
    required String name,
    required int age,
    required String gender,
    required String diabetesType,
    required String diabetesDuration,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save additional user data (e.g., mobile number, name, etc.) in Firestore
      await saveUserDetails(
        uid: userCredential.user!.uid,
        mobileNumber: mobileNumber,
        name: name,
        age: age,
        gender: gender,
        diabetesType: diabetesType,
        diabetesDuration: diabetesDuration,
      );

      return "Success";
    } catch (e) {
      return e.toString(); // Return error message as a string
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Success"; // Return success message
    } catch (e) {
      return e.toString(); // Return error message as a string
    }
  }

  Future<void> saveMedicalDetails({
    required String uid,
    required Map<String, dynamic> medicalDetails,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('medicalDetails')
          .add(medicalDetails);
    } catch (e) {
      print("Error saving medical details: $e");
    }
  }

  Future<void> saveUserDetails({
    required String uid,
    required String mobileNumber,
    required String name,
    required int age,
    required String gender,
    required String diabetesType,
    required String diabetesDuration,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'mobileNumber': mobileNumber,
        'name': name,
        'age': age,
        'gender': gender,
        'diabetesType': diabetesType,
        'diabetesDuration': diabetesDuration,
      });
    } catch (e) {
      print("Error saving user details: $e"); // Log any errors
    }
  }
}
