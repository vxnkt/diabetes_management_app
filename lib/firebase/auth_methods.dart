import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User Signup
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
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user details in Firestore
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
      return e.toString();
    }
  }

  // Doctor Signup
  Future<String?> signupDoctor({
    required String email,
    required String password,
    required String mobileNumber,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save doctor details in Firestore
      await saveDoctorDetails(
        uid: userCredential.user!.uid,
        mobileNumber: mobileNumber,
        email: email,
        name: name,
      );

      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  // Login for both Users and Doctors
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the logged-in user's uid
      String uid = userCredential.user!.uid;

      // Check if it's a regular user
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return "User"; // Return user message to identify a user login
      }

      // Check if it's a doctor
      DocumentSnapshot doctorDoc =
          await _firestore.collection('doctors').doc(uid).get();
      if (doctorDoc.exists) {
        return "doctor"; // Return doctor message to identify a doctor login
      }

      // If neither found, return an error
      return "No user or doctor account found";
    } catch (e) {
      return e.toString(); // Return error message as a string
    }
  }

  // Save medical details for user
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

  // Save regular user details in Firestore
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
        'role': 'user', // Define user role
      });
    } catch (e) {
      print("Error saving user details: $e");
    }
  }

  // Save doctor details in Firestore
  Future<void> saveDoctorDetails({
    required String uid,
    required String mobileNumber,
    required String email,
    required String name,
  }) async {
    try {
      await _firestore.collection('doctors').doc(uid).set({
        'mobileNumber': mobileNumber,
        'name': name,
        'email': email,
        'role': 'doctor', // Define doctor role
      });
    } catch (e) {
      print("Error saving doctor details: $e");
    }
  }
}
