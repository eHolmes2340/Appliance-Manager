//File       : camera_screen.dart
//Programmer : Erik Holmes
//Date       : Feb 13, 2025
//Description: This file will contain the camera screen for the appliance manager project
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

//Class       :CameraScreen
//Description : This class will create the camera screen widget 
class CameraScreen extends StatefulWidget {
  final CameraController controller;

  CameraScreen({required this.controller});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

//Class       :_CameraScreenState
//Description : This class will create the state for the camera screen widget
class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Picture of Appliance'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(widget.controller),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final XFile? picture = await widget.controller.takePicture();
                if (picture != null) {
                  Navigator.of(context).pop(picture);
                }
              },
              child: Text('Capture'),
            ),
          ),
        ],
      ),
    );
  }
}
