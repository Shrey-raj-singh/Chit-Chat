import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Screens/CameraViewScreen.dart';
import 'package:frontend/Screens/VideoView.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
  String _videoFilePath="";
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    camerValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    super.dispose();
    _cameraController.dispose();
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          )),
                      GestureDetector(
                        onLongPress: () async {
                          final path = join(
                            (await getTemporaryDirectory()).path,
                            '${DateTime.now()}.mp4',
                          );
                          ;
                          await _cameraController.startVideoRecording();
                          _videoFilePath = path;
                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async {
                          await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                            Navigator.push(context, MaterialPageRoute(builder: (builder)=>VideoViewScreen(path: _videoFilePath)));
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          )),
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
}
