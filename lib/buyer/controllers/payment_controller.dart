import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:camera/camera.dart';
import 'package:cropsureconnect/buyer/widgets/payment/slideable_notification.dart';

class PaymentController extends GetxController {
  final RxBool showNotification = false.obs;

  // --- Prototype Actions ---

  void showPaymentMethodModal(String method) {
    Get.bottomSheet(
      Container(
        height: 300,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Center(
          child: Text(
            'Mock form for $method payment.',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void simulateWithdrawal() {
    showNotification.value = true;
    // Hide the notification after a few seconds
    Future.delayed(const Duration(seconds: 4), () {
      showNotification.value = false;
    });
  }

  Future<void> openCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      // Navigate to a new screen to display the camera preview
      Get.to(() => CameraPreviewScreen(camera: firstCamera));
    } catch (e) {
      Get.snackbar("Camera Error", "Could not access the camera.");
    }
  }
}

// A simple screen to display the camera preview
class CameraPreviewScreen extends StatelessWidget {
  final CameraDescription camera;
  const CameraPreviewScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    final controller = CameraController(camera, ResolutionPreset.medium);
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Harvest Proof')),
      body: FutureBuilder<void>(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}