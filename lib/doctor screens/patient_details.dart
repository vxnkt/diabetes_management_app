import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore

class PatientDetailsPage extends StatelessWidget {
  final String userId;

  const PatientDetailsPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No details found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          var name = userData['name'] ?? 'Unknown';
          var age = userData['age'] ?? 'N/A';
          var diabetesType = userData['diabetesType'] ?? 'N/A';
          var diabetesDuration = userData['diabetesDuration'] ?? 'N/A';
          var gender = userData['gender'] ?? 'N/A';
          var mobileNumber = userData['mobileNumber'] ?? 'N/A';

          // Fetch medical details and photos
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: $name', style: const TextStyle(fontSize: 18)),
                Text('Age: $age', style: const TextStyle(fontSize: 18)),
                Text('Diabetes Type: $diabetesType', style: const TextStyle(fontSize: 18)),
                Text('Diabetes Duration: $diabetesDuration', style: const TextStyle(fontSize: 18)),
                Text('Gender: $gender', style: const TextStyle(fontSize: 18)),
                Text('Mobile Number: $mobileNumber', style: const TextStyle(fontSize: 18)),

                const SizedBox(height: 20),

                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .collection('medicalDetails')
                      .get(),
                  builder: (context, medicalSnapshot) {
                    if (medicalSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!medicalSnapshot.hasData || medicalSnapshot.data!.docs.isEmpty) {
                      return const Text('No medical details available');
                    }

                    // Fetch the first document in the medicalDetails collection
                    var medicalData = medicalSnapshot.data!.docs.first.data() as Map<String, dynamic>;

                    var medicalInfo = '''
                    Medical Details: 
                    Age: ${medicalData['age']}, 
                    Diabetes Type: ${medicalData['diabetesType']}, 
                    Diabetes Duration: ${medicalData['diabetesDuration']}, 
                    Has Hypertension: ${medicalData['hasHypertension'] ? 'Yes' : 'No'},
                    HbA1C Value: ${medicalData['hbA1CValue']},
                    ''';

                    return Text(medicalInfo, style: const TextStyle(fontSize: 18));
                  },
                ),

                const SizedBox(height: 20),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .collection('photos')
                      .snapshots(),
                  builder: (context, photoSnapshot) {
                    if (photoSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!photoSnapshot.hasData || photoSnapshot.data!.docs.isEmpty) {
                      return const Text('No photos uploaded');
                    }

                    var photos = photoSnapshot.data!.docs;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Photos:', style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: photos.length,
                          itemBuilder: (context, index) {
                            var photoUrl = photos[index]['url'] ?? '';
                            return Image.network(photoUrl);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
