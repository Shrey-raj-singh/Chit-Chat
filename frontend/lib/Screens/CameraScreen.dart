import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Screens/CameraViewScreen.dart';
import 'package:frontend/Screens/VideoView.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
// import 'package:image/image.dart' as img;

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> camerValue;
  bool isRecording = false;
  bool flash = false;
  bool frontcamera = true;
  double transform = 0;

  String _videoFilePath = "";
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    camerValue = _cameraController.initialize();
    _videoPlayerController = VideoPlayerController.network(
        ''); // Initialize with an empty network URL
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    super.dispose();
    _cameraController.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: Alignment.center,
        children: [
          FutureBuilder<void>(
            future: camerValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_cameraController));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? _cameraController.setFlashMode(FlashMode.torch)
                              : _cameraController.setFlashMode(FlashMode.off);
                        },
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          await startVideoRecording();
                        },
                        onLongPressUp: () async {
                          XFile videoFile =
                              await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                            _videoFilePath = videoFile.path;
                            _videoPlayerController =
                                VideoPlayerController.file(File(_videoFilePath))
                                  ..initialize().then((_) {
                                    _videoPlayerController.play();
                                  });
                            Navigator.push(
                                context as BuildContext,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        VideoViewScreen(path: _videoFilePath)));
                          });
                        },
                        onTap: () {
                          if (!isRecording) {
                            takePicture(context);
                          }
                        },
                        child: isRecording
                            ? Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 80,
                              )
                            : Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                          icon: Transform.rotate(
                            angle: transform,
                            child: Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28,
                              ),
                          ),
                          onPressed: () {
                              setState(() {
                                frontcamera =!frontcamera;
                                transform=transform+pi;
                              });
                              int _camerpos = frontcamera?0:1;
                            _cameraController = CameraController(
                              cameras[_camerpos],
                              ResolutionPreset.max);
                              camerValue = _cameraController.initialize();
                          },
                          ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Hold for video, tap for photo",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePicture(BuildContext context) async {
    await camerValue;
    XFile picture = await _cameraController.takePicture();
    final path = join(
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
    await picture.saveTo(path);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewScreen(
                  path: path,
                )));
  }

  Future<void> startVideoRecording() async {
    await _cameraController.startVideoRecording();
    setState(() {
      isRecording = true;
    });
  }
}
