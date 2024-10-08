import 'package:flutter/material.dart';

class RequestDetailsPage extends StatefulWidget {
  const RequestDetailsPage({super.key});

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  TextEditingController _requestController = TextEditingController();
  TextEditingController _hbacsController = TextEditingController();
  TextEditingController _rbsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEFF5),
        title: Text('Sending Request to Dr A'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Padding(
          padding: EdgeInsets.only(left: 20, top: 18),
          child: Text(
            'Enter your details:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(18),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: TextField(
            maxLines: 5,
            controller: _requestController,
            decoration: InputDecoration(
              hintText: 'Enter any symptoms that you have ',
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
            ),
          ),
        ),
            Container(
              margin: EdgeInsets.all(18),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: TextField(
                maxLines: 1,
                controller: _hbacsController,
                decoration: InputDecoration(
                  hintText: 'Enter recent HbacS Value',
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(18),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: TextField(
                maxLines: 1,
                controller: _rbsController,
                decoration: InputDecoration(
                  hintText: 'Enter recent Rbs Value',
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(left: 18,right: 18,bottom: MediaQuery.of(context).size.height*0.05),
                width: MediaQuery.of(context).size.width*0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.deepPurple,
                      Colors.deepPurpleAccent
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Submit Details',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            )
      ]),
    );
  }
}
