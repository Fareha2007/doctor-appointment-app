
import 'package:flutter_doctor_appointment_app_new_clean/screens/AuthGate.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthController extends GetxController {
  final Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});

  @override
  void onInit() {
    super.onInit();
    print("--- AuthController Initialized ---");
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print("--- AuthController: Auth state changed. User is: ${user?.uid}");
      if (user != null) {
        fetchUserData(user.uid);
      } else {
        userData.value = {};
      }
    });
  }

  Future<void> fetchUserData(String uid) async {
    print("--- AuthController: Fetching user data for UID: $uid");
    try {
      final userDoc = await FirebaseFirestore.instance.collection('patients').doc(uid).get();
      if (userDoc.exists) {
        userData.value = userDoc.data()!;
        print("--- AuthController: User data fetched successfully.");
      } else {
        print("--- AuthController ERROR: User document not found for UID: $uid");
      }
    } catch (e) {
      print("--- AuthController ERROR fetching user data: $e");
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const AuthGate());
  }
}
