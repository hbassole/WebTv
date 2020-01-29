import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:webtv_app/main.dart';

import 'package:path_provider/path_provider.dart';

class CameraTT extends StatefulWidget {
  @override
  _CameraTTState createState() => _CameraTTState();
}

class _CameraTTState extends State<CameraTT> {
  int current = 0;
  bool isPlay = false;
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[current], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );

// If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller)
          ),
          Positioned(
            top: 30,
            left: 30,
            child: IconButton(
                icon: Icon(Icons.swap_horiz),
                onPressed: () async{
                  print('-------------------------------------');
                  print(cameras.length);
                  onNewCameraSelected(cameras[1]);
                }
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: IconButton(
                icon: Icon(isPlay ? Icons.pause : Icons.video_call),
                onPressed: () async{
                  if(controller.value.isRecordingVideo) {
                    controller.stopVideoRecording();
                    return;
                  }
                  final path = join(
                    (await getTemporaryDirectory()).path,
                    '${DateTime.now()}.mp4',
                  );

                  print(path);

                  await controller.prepareForVideoRecording();
                  isPlay = true;
                  setState(() {});
                  controller.startVideoRecording(path);
                }
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}