import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart'; // For handling dates

class HomesScreen extends StatefulWidget {
  const HomesScreen({super.key});

  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  List<FlSpot> hba1cDataPoints = [];
  List<FlSpot> rbsDataPoints = []; // Store the graph points
  double hba1c = 0.0;
  double rbs = 0.0;
  int daysCounter = 0; // Keep track of days for x-axis

  File? _image; // Store the selected image

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source:
          ImageSource.gallery, // You can also use ImageSource.camera for camera
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the selected image
      });
    }
  }

  Future<void> _uploadImage(XFile pickedFile) async {
    try {
      // Create a unique filename for the image
      String fileName = 'wounds/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Upload the image to Firebase Storage
      TaskSnapshot uploadTask = await FirebaseStorage.instance
          .ref(fileName)
          .putFile(File(pickedFile.path));

      // Get the download URL
      String downloadUrl = await uploadTask.ref.getDownloadURL();

      // Save the image URL to Firestore
      // await FirebaseFirestore.instance.collection('users').doc(userId).collection('photos').add({
      //   'url': downloadUrl,
      //   'uploadedAt': Timestamp.now(),
      // });

      print("Image uploaded successfully. URL: $downloadUrl");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController hba1cController = TextEditingController();
        TextEditingController rbsController = TextEditingController();

        return AlertDialog(
          title: const Text("Enter Lab Values"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: hba1cController,
                  decoration: const InputDecoration(labelText: 'HbA1c'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: rbsController,
                  decoration: const InputDecoration(labelText: 'RBS'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  hba1c = double.tryParse(hba1cController.text) ?? 0.0;
                  rbs = double.tryParse(rbsController.text) ?? 0.0;
                  _updateGraph();
                });
                Navigator.of(context).pop();
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _updateGraph() {
    // Update the graph with new points
    setState(() {
      hba1cDataPoints.add(FlSpot(daysCounter.toDouble(), hba1c));
      rbsDataPoints.add(FlSpot(daysCounter.toDouble(), rbs));
      daysCounter++; // Increment days for next input
    });
  }

  Size get preferredSize => const Size.fromHeight(100); // Custom height

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color(0xFFEEEFF5),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   padding: const EdgeInsets.only(
              //       top: 15, left: 15, right: 15, bottom: 10),
              //   decoration: BoxDecoration(
              //     gradient: const LinearGradient(
              //       colors: [Colors.blueAccent, Colors.lightBlueAccent],
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //     ),
              //     borderRadius: const BorderRadius.only(
              //       bottomLeft: Radius.circular(20),
              //       bottomRight: Radius.circular(20),
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Icon(Icons.dashboard,
              //               size: 30, color: Colors.white),
              //           Icon(Icons.notifications,
              //               size: 30, color: primaryColor),
              //         ],
              //       ),
              //       const SizedBox(height: 20),
              //       const Padding(
              //         padding: EdgeInsets.only(left: 3, bottom: 15),
              //         child: Text(
              //           "Hi, User",
              //           style: TextStyle(
              //             fontSize: 25,
              //             fontWeight: FontWeight.w600,
              //             letterSpacing: 1,
              //             wordSpacing: 2,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text(
                      "Health Chart",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: _showInputDialog,
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 350,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: hba1cDataPoints,
                          isCurved: false,
                          color: Colors.blue,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(show: false),
                        ),
                        LineChartBarData(
                          spots: rbsDataPoints,
                          isCurved: false,
                          color: Colors.red,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < hba1cDataPoints.length) {
                                return Text(
                                  DateFormat('MM/dd').format(DateTime.now()
                                      .add(Duration(days: value.toInt()))),
                                  style: const TextStyle(fontSize: 10),
                                );
                              }
                              return Container(); // Hide labels for non-existent points
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toStringAsFixed(1),
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        verticalInterval: 1,
                        horizontalInterval: 1,
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 5),
                        const Text("HbA1c"),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 5),
                        const Text("RBS"),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color:
                      _image != null ? Colors.white : const Color(0xFFEEEFF5),
                ),
                child: Column(
                  children: [
                    _image == null ?
                    GestureDetector(
                      onTap: _pickImage, // Trigger image picking on tap
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.deepPurple,
                              Colors.deepPurpleAccent
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Upload New Wound Photo',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ):GestureDetector(
                      onTap: () {}, // Trigger image picking on tap
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.deepPurple,
                              Colors.deepPurpleAccent
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Confirm Upload',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
        
                    // Display the image if selected
                    _image != null
                        ? Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: FileImage(_image!), // Display the image
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0, // Remove AppBar shadow
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.deepPurpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 3.0),
        child: const Text(
          "Hi, User",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            wordSpacing: 2,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white, // Change this to `primaryColor` if necessary
          ),
        ),
      ],
      leading: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Icon(
          Icons.dashboard,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80); // Custom height
}
