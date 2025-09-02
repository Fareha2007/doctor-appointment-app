
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/splash_screen.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/AuthGate.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/doctor_detail_screen.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/doctorhomescreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/auth_controller.dart';
import 'controller/appointment_controller.dart';

// --- SCREENS ---
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/my_appointment_page.dart';
import 'screens/profile_screen.dart';
import 'screens/doctor_dashboard.dart';
import 'screens/appointment_confirmation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  // Initialize controllers
  Get.put(AuthController());
  Get.put(AppointmentController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // Splash screen is the first screen
      home: const SplashScreen(),
      // Named routes for navigation
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/', page: () => const AuthGate()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/home', page: () => const DoctorHomeScreen()),
        GetPage(name: '/appointments', page: () => const MyAppointmentPage()),
        GetPage(name: '/profile', page: () => const PatientProfileScreen()),
        GetPage(name: '/dashboard', page: () => const DoctorDashboard()),
        GetPage(name: '/Confirm', page: () => const AppointmentConfirmationScreen()),
        GetPage(
          name: '/doctorDetail',
          page: () => const DoctorDetailsScreen(doctor: {}),
        ),
      ],
    );
  }
}
