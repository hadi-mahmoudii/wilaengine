import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CaptureImage extends StatefulWidget {
  @override
  _CaptureImageState createState() {
    return _CaptureImageState();
  }
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _CaptureImageState extends State<CaptureImage>
    with WidgetsBindingObserver {
  CameraController controller;
  String imagePath;
  // String videoPath;
  VoidCallback videoPlayerListener;
  bool isInit = true;
  int curCamera = 0;
  var cameras;
  Function function;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      cameras = await availableCameras();
      onNewCameraSelected(cameras[curCamera]);
      function = ModalRoute.of(context).settings.arguments as Function;
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        // appBar: AppBar(
        //   title: const Text('Take Picture'),
        // ),
        body: isInit
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(children: <Widget>[
                _cameraPreviewWidget(),
                Positioned(
                    bottom: 100, left: 100, child: _captureControlRowWidget()),
                Positioned(
                  bottom: 100,
                  right: 100,
                  child: InkWell(
                    onTap: () {
                      if (curCamera == 0) {
                        try {
                          onNewCameraSelected(cameras[1]);
                          setState(() {
                            curCamera = 1;
                          });
                        } catch (e) {}
                      } else {
                        onNewCameraSelected(cameras[0]);
                        setState(() {
                          curCamera = 0;
                        });
                      }
                    },
                    child: Icon(
                      curCamera == 0 ? Icons.camera_rear : Icons.camera_front,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                // _cameraTogglesRowWidget(cameras),
              ]),
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        child: CameraPreview(controller),
      );
    }
  }

  /// Toggle recording audio

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.camera_alt,
            size: 40,
            color: Colors.white,
          ),
          // color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }

  getCameras() async {
    return await availableCameras();
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  // Widget _cameraTogglesRowWidget(var cameras) {
  //   final List<Widget> toggles = <Widget>[];

  //   if (cameras.isEmpty) {
  //     return const Text('No camera found');
  //   } else {
  //     for (CameraDescription cameraDescription in cameras) {
  //       print("${cameraDescription.name}");
  //       toggles.add(
  //         SizedBox(
  //           width: 90.0,
  //           child: RadioListTile<CameraDescription>(
  //             title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
  //             groupValue: controller?.description,
  //             value: cameraDescription,
  //             onChanged: controller != null && controller.value.isRecordingVideo
  //                 ? null
  //                 : onNewCameraSelected,
  //           ),
  //         ),
  //       );
  //     }
  //   }

  // return Row(children: toggles);
  // }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(this._scaffoldKey.currentContext)
        .showSnackBar(SnackBar(content: Text(message)));
    
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    print(cameraDescription.lensDirection.toString());
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      // enableAudio: enableAudio,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          // var profileProviderObject =
          //     Provider.of<TestResultsProvider>(context, listen: false);
          // List<File> files = profileProviderObject.catchImages;
          // files.add(File(imagePath));
          // profileProviderObject.setCatchImages(files);
          // profileProviderObject.setImages();
          print(imagePath);
          function(context, [File(imagePath)], false);
        });
        if (filePath != null) {
          Navigator.of(context).pop();
          // showInSnackBar('Picture saved to $filePath');
        }
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

// class CameraApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CaptureImage(),
//     );
//   }
// }

// List<CameraDescription> cameras = [];

// Future<void> main() async {
//   // Fetch the available cameras before initializing the app.
//   try {
//     WidgetsFlutterBinding.ensureInitialized();
//   } on CameraException catch (e) {
//     logError(e.code, e.description);
//   }
//   runApp(CameraApp());
// }
