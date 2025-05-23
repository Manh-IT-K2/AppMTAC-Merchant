import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtac/controllers/connection/connection_controller.dart';
import 'package:mtac/routes/app_routes.dart';

class NoConnectionMiddlewareScreen extends StatelessWidget {
  const NoConnectionMiddlewareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final connectionController = Get.find<ConnectionController>();

    return Obx(() {
      if (connectionController.hasConnection.value) {
        // Nếu mạng có lại -> tự động về màn chính
        Future.delayed(Duration.zero, () {
          Get.offAllNamed(AppRoutes.splashScreen);
        });
      }

      return Scaffold(
        appBar: AppBar(title: const Text('Mất kết nối Internet')),
        body: const Center(
          child: Text('Không có mạng 🛜, vui lòng kiểm tra lại.'),
        ),
      );
    });
  }
}
