import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/AuthGate.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter email & password');
      return;
    }

    try {
      isLoading.value = true;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    //  Get.offAllNamed('/home'); 
      Get.offAll(() => const AuthGate()); 
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Error', e.message ?? 'Unknown error');
    } finally {
      isLoading.value = false;
    }
  }
}
