import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

 
  Future<void> bookAppointment({
    required String doctorId,
    DateTime? dateTime, 
  }) async {
    if (_currentUser == null) {
      throw Exception("No user logged in!");
    }

    final data = {
      'patientId': _currentUser!.uid,
      'doctorId': doctorId,
      'timestamp': dateTime != null
          ? Timestamp.fromDate(dateTime)
          : Timestamp.now(),
      'status': 'pending',
    };

    try {
      await _firestore.collection('appointments').add(data);
      print("Appointment booked for UID=${_currentUser!.uid}");
    } catch (e) {
      print("Error booking appointment: $e");
      rethrow;
    }
  }

  // Get appointments stream for current user
  Stream<QuerySnapshot> getAppointmentsStream() {
    if (_currentUser == null) {
      throw Exception("No user logged in!");
    }

    return _firestore
        .collection('appointments')
        .where('patientId', isEqualTo: _currentUser!.uid)
        .orderBy('timestamp', descending: false)
        .snapshots();
  }


  Future<void> cancelAppointment(String appointmentId) async {
    try {
      await _firestore.collection('appointments').doc(appointmentId).delete();
      print("Appointment $appointmentId cancelled");
    } catch (e) {
      print("Error cancelling appointment: $e");
      rethrow;
    }
  }
}
