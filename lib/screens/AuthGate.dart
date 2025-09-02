import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/doctorhomescreen.dart';
import 'login_screen.dart';
import 'doctor_dashboard.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<String> _getUserRole(String uid) async {
    print("--- AUTHGATE: Checking role for UID: $uid");
    try {
      final userDoc = await FirebaseFirestore.instance.collection('patients').doc(uid).get();
      if (userDoc.exists) {
        final role = userDoc.data()?['role'] ?? 'patient';
        print("--- AUTHGATE: Found role in database: '$role'");
        return role;
      } else {
        print("--- AUTHGATE ERROR: User document NOT found in 'patients' collection for UID: $uid");
        return 'patient'; 
      }
    } catch (e) {
      print("--- AUTHGATE ERROR fetching role: $e");
    }
    return 'patient';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          print("--- AUTHGATE: User is LOGGED IN. Checking role...");
          return FutureBuilder<String>(
            future: _getUserRole(snapshot.data!.uid),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              print("--- AUTHGATE: Role received: '${roleSnapshot.data}'");
              if (roleSnapshot.data?.trim().toLowerCase() == 'doctor') {
                print("--- AUTHGATE: --> Navigating to DoctorDashboard.");
                return const DoctorDashboard();
              } else {
                print("--- AUTHGATE: --> Navigating to HomeScreen (Patient).");
                return const DoctorHomeScreen();
              }
            },
          );
        }
        print("--- AUTHGATE: No user is logged in. Navigating to LoginScreen.");
        return LoginScreen();
      },
    );
  }
}