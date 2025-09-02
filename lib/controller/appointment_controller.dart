
import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppointmentController extends GetxController {

  var isLoading = false.obs;

  // List to hold patient's appointments
  RxList<DocumentSnapshot> appointments = <DocumentSnapshot>[].obs;
  StreamSubscription? _appointmentSubscription;

 
  @override
  void onInit() {
    super.onInit();

    // Listen to auth changes
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        print("--- FETCH: Auth user logged in, fetching appointments");
        fetchAppointments();
      }
    });
  }

  Future<void> fetchAppointments() async {
    print("--- FETCH: starting");
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("--- FETCH ERROR: No user logged in");
      return;
    }
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('patientId', isEqualTo: user.uid)
          .orderBy('appointmentTime', descending: true)
          .get();

      print("--- FETCH: found ${snapshot.docs.length} docs");
      appointments.value = snapshot.docs;
    } catch (e) {
      print("--- FETCH ERROR: $e");
    }
  }

  Future<void> addAppointment({
    required String doctorName,
    required String doctorId,
    required DateTime appointmentDateTime, 
  }) async {
    print("--- ADD APPOINTMENT: starting");

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("--- ADD APPOINTMENT ERROR: No user logged in");
      return;
    }

    try {
      final docRef = await FirebaseFirestore.instance
          .collection('appointments')
          .add({
            'patientId': user.uid,
            'doctorId': doctorId,
            'doctorName': doctorName,
            'appointmentTime': appointmentDateTime,
            'createdAt': FieldValue.serverTimestamp(),
          });

      print("--- ADD APPOINTMENT: Appointment saved with ID ${docRef.id}");
    } catch (e, st) {
      print("--- ADD APPOINTMENT ERROR: $e");
      print(st);
    }
  }

  @override
  void onClose() {
    _appointmentSubscription?.cancel();
    super.onClose();
  }
}
