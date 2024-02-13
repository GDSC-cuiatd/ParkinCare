import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String predictionResult;

  ResultPage({required this.predictionResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009DD1),
        centerTitle: true,
        title: Text(
          "ParkinCare",
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text(predictionResult),
      ),
    );
  }
}
