import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  String doctorName = '';

  @override
  void initState() {
    super.initState();
    fetchDoctorName(); // Fetch doctor name when page loads
  }

  // Method to fetch doctor's name from Firestore
  Future<void> fetchDoctorName() async {
    try {
      // Query the Firestore collection 'doctors' where the role is 'doctor'
      var snapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where('role', isEqualTo: 'doctor')
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          doctorName = snapshot.docs[0]['name'] ?? 'Unknown'; // Set doctor name
        });
      }
    } catch (e) {
      print('Error fetching doctor name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEFF5),
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepPurple,
                child: Text(
                  doctorName.isNotEmpty
                      ? doctorName[0]
                      : 'D', // Display first letter of name or default
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        doctorName.isNotEmpty
                            ? doctorName
                            : 'Fetching name...', // Display doctor name
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
