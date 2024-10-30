import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class OCRComponent extends StatefulWidget {
  @override
  _OCRComponentState createState() => _OCRComponentState();
}

class _OCRComponentState extends State<OCRComponent> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String _extractedText = 'No text recognized';
  String _selectedText = '';

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _extractTextFromImage();
    }
  }

  // Function to capture an image with the camera
  Future<void> _captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _extractTextFromImage();
    }
  }

  // Function to extract text using Google Cloud Vision API
  Future<void> _extractTextFromImage() async {
    if (_image == null) return;

    // Convert the image to base64 format
    final bytes = await _image!.readAsBytes();
    final base64Image = base64Encode(bytes);

    final apiKey = 'YOUR_GOOGLE_CLOUD_VISION_API_KEY';
    final url = Uri.parse(
        'https://vision.googleapis.com/v1/images:annotate?key=$apiKey');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "requests": [
          {
            "image": {"content": base64Image},
            "features": [
              {"type": "TEXT_DETECTION"}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final textAnnotations = data['responses'][0]['textAnnotations'];
      setState(() {
        _extractedText = textAnnotations.isNotEmpty
            ? textAnnotations[0]['description']
            : 'No text found';
      });
    } else {
      setState(() {
        _extractedText = 'Error recognizing text';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Text Recognition (OCR)',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 20),
            _image != null
                ? Image.file(_image!, height: 200)
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(child: Text('No Image Selected')),
                  ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _captureImage,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Capture Photo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: Icon(Icons.photo),
                  label: Text('Upload Photo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Extracted Text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SelectableText(
              _extractedText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
              onSelectionChanged: (selection, cause) {
                if (cause == SelectionChangedCause.tap ||
                    cause == SelectionChangedCause.longPress) {
                  setState(() {
                    _selectedText = _extractedText.substring(
                        selection.start, selection.end);
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _selectedText.isNotEmpty ? _getFoodRecommendations : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: Text('Get Food Recommendations'),
            ),
          ],
        ),
      ),
    );
  }

  void _getFoodRecommendations() {
    if (_selectedText.isNotEmpty) {
      print("Getting food recommendations for: $_selectedText");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Getting food recommendations for: $_selectedText')),
      );
    }
  }
}
