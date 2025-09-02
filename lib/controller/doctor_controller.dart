import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorController extends GetxController {
  // A reactive list to hold today's appointments.
  RxList<DocumentSnapshot> todaysAppointments = <DocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenForTodaysAppointments();
  }

  void _listenForTodaysAppointments() {
    final doctorId = FirebaseAuth.instance.currentUser?.uid;
    print("DEBUG: Querying for doctorId: $doctorId");
    if (doctorId == null) return;

    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    // FirebaseFirestore.instance
    // .collection('appointments')
    // .where('doctorId', isEqualTo: doctorId)
    // .where(
    //   'appointmentTime',
    //   isGreaterThanOrEqualTo: Timestamp.fromDate(startOfToday),
    // )
    // .where(
    //   'appointmentTime',
    //   isLessThanOrEqualTo: Timestamp.fromDate(endOfToday),
    // )
    // .orderBy('appointmentTime')
    // .snapshots()
    // .listen((snapshot) {
    //   todaysAppointments.value = snapshot.docs;
    // });
    FirebaseFirestore.instance
        .collection('appointments')
        .where('doctorId', isEqualTo: doctorId)
        .orderBy('appointmentTime')
        .snapshots()
        .listen((snapshot) {
          todaysAppointments.value = snapshot.docs.where((doc) {
            final date = (doc['appointmentTime'] as Timestamp).toDate();
            return date.year == now.year &&
                date.month == now.month &&
                date.day == now.day;
          }).toList();
        });
  }
}
