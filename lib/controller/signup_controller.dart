
import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/AuthGate.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignupController extends GetxController {
 
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordObscured = true.obs;
  var isConfirmPasswordObscured = true.obs;

  // --- Methods ---

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured.value = !isConfirmPasswordObscured.value;
  }
  
  /// Signs up a new user, creates their account, and saves their details to Firestore.
  Future<void> signUpUser() async {
    isLoading.value = true;
    try {
      // First, check if passwords match.
      if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
        Get.snackbar("Error", "Passwords do not match.");
        isLoading.value = false; // Stop loading
        return;
      }
      
      // Create the user in Firebase Authentication.
      final UserCredential userCredential = 
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Create the user's profile document in the 'patients' collection.
        await FirebaseFirestore.instance.collection('patients').doc(firebaseUser.uid).set({
          'uid': firebaseUser.uid,
          'firstName': firstNameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'email': emailController.text.trim(),
          'address': addressController.text.trim(),
          'birthDate': birthDateController.text.trim(),
          'phone': phoneController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
          'role': 'patient', // Automatically assign the 'patient' role.
        });
        
        // Navigate to the AuthGate, which will direct the user to the home screen.
        Get.offAll(() => const AuthGate());
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase errors (e.g., email already in use).
      Get.snackbar("Signup Failed", e.message ?? "An unknown error occurred.");
    } catch (e) {
      // Handle any other unexpected errors.
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    } finally {
      // Ensure the loading indicator is always turned off.
      isLoading.value = false;
    }
  }

  // Dispose all controllers when the screen is closed to prevent memory leaks.
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    birthDateController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}