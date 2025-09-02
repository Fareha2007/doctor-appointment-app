import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends StatelessWidget {
  const SplashController({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 80),

            const SizedBox(height: 20),
            const Text(
              "Doctor Appointment App",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
