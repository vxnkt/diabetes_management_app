import 'package:appathon/screens/request_details_page.dart';
import 'package:flutter/material.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEFF5),
        title: const Text(
          'Doctors Available',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1596541223130-5d31a73fb6c6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGhvc3BpdGFsJTIwYnVpbGRpbmd8ZW58MHx8MHx8fDA%3D'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Dr A',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 46,
                      right: 10,
                      bottom: 5,
                      top: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Diabetes Specialist')),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetailsPage()));
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.83,
                          height: MediaQuery.of(context)
                              .size
                              .height *
                              0.05,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              vertical: 10),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.deepPurple,
                                  Colors.deepPurpleAccent
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius:
                              BorderRadius.circular(
                                  10)),
                          child: Center(
                            child: Text(
                              'Send Consultation Request',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
