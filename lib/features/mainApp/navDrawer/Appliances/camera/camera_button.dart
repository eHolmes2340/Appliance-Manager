import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera_screen.dart';

//Class       :CameraButton
//Description : This class will contain the camera button widget
class CameraButton extends StatefulWidget {
  final Function(XFile) onPictureTaken;

  CameraButton({required this.onPictureTaken});

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

//Class       :_CameraButtonState
//Description : This class will contain the state for the camera button widget
class _CameraButtonState extends State<CameraButton> {
  CameraController? _controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  //Function  :_initializeCamera
  //Description : This function will initialize the camera
  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      _controller = CameraController(cameras![0], ResolutionPreset.high);
      await _controller?.initialize();
      setState(() {}); // Refresh  the UI after camera initialization
    }
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_controller != null && _controller!.value.isInitialized) {
          final XFile? picture = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CameraScreen(controller: _controller!),
            ),
          );
          if (picture != null) {
            widget.onPictureTaken(picture);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Camera not initialized')),
          );
        }
      },
      child: Text('Take Picture of Appliance'),
    );
  }
}
