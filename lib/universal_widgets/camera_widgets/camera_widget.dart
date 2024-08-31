
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class cameraControlScreen extends StatefulWidget
{

  cameraControlScreen({super.key, required this.cameraToControl, required this.imageRefrence});

  CameraDescription cameraToControl;

  XFile imageRefrence;

  State<StatefulWidget> createState()
  {
    return _cameraControlScreenState();
  }

}

class _cameraControlScreenState extends State<cameraControlScreen>
{

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState()
  {
    super.initState();
    _controller = CameraController(widget.cameraToControl, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: FutureBuilder<void>
      (
        future: _initializeControllerFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done)
          {
            return CameraPreview(_controller);
          }
          else
          {
            return Center
            (
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton
      (
        child: Icon(Icons.camera_alt),
        onPressed: () async
        {
          try
          {
            await _initializeControllerFuture;
            widget.imageRefrence = await _controller.takePicture();
            print("Picture saved to ${widget.imageRefrence.path}");
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
  
}