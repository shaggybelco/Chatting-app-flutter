import 'dart:math';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Pages/camera_view.dart';
import 'package:frontend/Pages/video_view.dart';

List<CameraDescription> cameras = [];

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameracontroller;
  Future<void>? cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;
  Timer? _timer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    cameracontroller = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = cameracontroller.initialize();
  }

  @override
  void dispose() {
    cameracontroller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 11, 36, 71),
                Color.fromARGB(255, 165, 215, 232),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // return CameraPreview(cameracontroller);
                  final screenAspectRatio =
                      MediaQuery.of(context).size.aspectRatio;
                  final cameraAspectRatio = cameracontroller.value.aspectRatio;
                  final aspectRatio = cameraAspectRatio / screenAspectRatio;

                  return SafeArea(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height * aspectRatio,
                      height: MediaQuery.of(context).size.width * aspectRatio,
                      child: CameraPreview(cameracontroller),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            top: 5,
            right: 10,
            child: Text(
              _elapsedSeconds.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: Icon(flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white, size: 28),
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? cameracontroller.setFlashMode(FlashMode.torch)
                              : cameracontroller.setFlashMode(FlashMode.off);
                        },
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          await cameracontroller.startVideoRecording();
                          _elapsedSeconds = 0;
                          setState(() {
                            isRecording = true;
                          });
                          _timer = Timer.periodic(const Duration(seconds: 1),
                              (timer) {
                            setState(() {
                              if (!isRecording) {
                                _elapsedSeconds = 0;
                              } else {
                                _elapsedSeconds++;
                              }
                            });
                          });
                        },
                        onLongPressUp: () async {
                          XFile videopath =
                              await cameracontroller.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => VideoViewPage(
                                path: videopath.path,
                              ),
                            ),
                          );
                        },
                        onTap: () {
                          if (!isRecording) takePhoto(context);
                        },
                        child: isRecording ? const Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 70,
                              )
                            : const Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.flip_camera_android, color: Colors.white, size: 28),
                        onPressed: () {
                          setState(() {
                            iscamerafront = !iscamerafront;
                            transform = transform + pi;
                          });
                          int cameraPos = iscamerafront ? 0 : 1;
                          cameracontroller = CameraController(cameras[cameraPos], ResolutionPreset.high);
                          cameraValue = cameracontroller.initialize();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "Hold for video, tap for photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(context) async {
    XFile file = await cameracontroller.takePicture();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => CameraView(path: file.path),
      ),
    );
  }
}
