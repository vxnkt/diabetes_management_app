import 'package:appathon/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart'; // For handling dates

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FlSpot> hba1cDataPoints = [];
  List<FlSpot> rbsDataPoints = []; // Store the graph points
  double hba1c = 0.0;
  double rbs = 0.0;
  int daysCounter = 0; // Keep track of days for x-axis

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController hba1cController = TextEditingController();
        TextEditingController rbsController = TextEditingController();

        return AlertDialog(
          title: Text("Enter Lab Values"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: hba1cController,
                decoration: InputDecoration(labelText: 'HbA1c'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: rbsController,
                decoration: InputDecoration(labelText: 'RBS'),
                keyboardType: TextInputType.number,
              ),
            ],
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
              child: Text("Update"),
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

  String _formatDateLabel(double value) {
    final DateTime startDate =
        DateTime.now().subtract(Duration(days: daysCounter));
    final DateTime date = startDate.add(Duration(days: value.toInt()));
    return DateFormat('MM/dd').format(date); // Format date as 'MM/dd'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.dashboard, size: 30, color: primaryColor),
                        Icon(Icons.notifications,
                            size: 30, color: primaryColor),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 3, bottom: 15),
                      child: Text(
                        "Hi, User",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Health Chart",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: _showInputDialog,
                      child: Text('Update'),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20), // Adjust padding to center the graph
                child: Container(
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
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval:
                                1, // Show X-axis labels only for each point
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < hba1cDataPoints.length) {
                                // Assuming the X-axis represents dates or integers
                                return Text(
                                  DateFormat('MM/dd').format(DateTime.now()
                                      .add(Duration(days: value.toInt()))),
                                  style: TextStyle(
                                      fontSize:
                                          10), // Styling for X-axis labels
                                );
                              }
                              return Container(); // Hide labels for non-existent points
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1, // Adjust interval to reduce congestion
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 12, // Y-axis label size
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
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
                        SizedBox(width: 5),
                        Text("HbA1c"),
                      ],
                    ),
                    SizedBox(width: 20),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Text("RBS"),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Medical History",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
          Positioned(
            bottom: 100,
            left: MediaQuery.of(context).size.width / 2 -
                60, // Center the circular widget
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    FlutterPhoneDirectCaller.callNumber('+123123213');
                  },
                  child: Container(
                    width: 120, // Size of the circular widget
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Colors.greenAccent, // Background color of the circle
                    ),
                    child: Center(
                      child: Icon(
                        Icons.call,
                        size: 50, // Size of the call icon
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // Spacing between button and text
                Text(
                  "Emergency Call",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
