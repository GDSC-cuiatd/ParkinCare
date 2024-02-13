import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:myworking_app/API/ResultPage.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final picker = ImagePicker();
  String predictionResult = '';

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Make API request with the selected image
      await predictImage(pickedFile.path);
    }
  }

  Future<void> predictImage(String imagePath) async {
    var url = 'http://192.168.31.31:5000';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    var file = await http.MultipartFile.fromPath('imagefile', imagePath);
    request.files.add(file);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var result = json.decode(await response.stream.bytesToString());
        setState(() {
          predictionResult =
              'Predicted Class: ${result['predicted_class']}, \nConfidence: ${result['confidence']}';
        });

        // Navigate to the result page and pass the prediction result
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultPage(predictionResult: predictionResult),
          ),
        );
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

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
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: getImageFromGallery,
              child: Text(
                'Select Image from Gallery',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 50),
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
