
import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment_app_new_clean/colors/app_color.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigateUser() async {
    await Future.delayed(const Duration(seconds: 3)); // splash delay

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final email = user.email ?? "";

      // Example: check doctor by email domain or custom rule
      if (email.endsWith("@hospital.com")) {
        Get.offAllNamed('/dashboard'); // Doctor
      } else {
        Get.offAllNamed('/home'); // Patient
      }
    } else {
      Get.offAllNamed('/login'); // Not logged in
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateUser());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Your logo
            Image.asset(
              'assets/images/logo.png',
              width: screenWidth * 0.4,
              fit: BoxFit.contain,
            ),

            SizedBox(height: screenHeight * 0.02),

            const Text(
              'Yaseen Clinic',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
