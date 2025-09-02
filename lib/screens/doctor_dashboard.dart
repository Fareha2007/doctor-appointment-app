import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_doctor_appointment_app_new_clean/colors/app_color.dart';
import 'package:flutter_doctor_appointment_app_new_clean/controller/doctor_controller.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller, making it available to the UI.
    final DoctorController controller = Get.put(DoctorController());

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        foregroundColor: AppColor.primaryColor,
        title: const Text(
          "Today's Schedule",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 1,
        centerTitle: true,
      ),
      // The Obx widget makes the screen reactive to changes in the controller.
      body: Obx(() {
        // Handle the case where there are no appointments for today.
        if (controller.todaysAppointments.isEmpty) {
          return const Center(
            child: Text(
              "No appointments scheduled for today.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // If appointments exist, build the list.
        return ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: controller.todaysAppointments.length,
          itemBuilder: (context, index) {
            final doc = controller.todaysAppointments[index];
            final data = doc.data() as Map<String, dynamic>;
            return _buildAppointmentCard(data);
          },
        );
      }),
    );
  }

  // A reusable helper widget for displaying a single appointment card.
  Widget _buildAppointmentCard(Map<String, dynamic> data) {
    // final appointmentTime = (data['timestamp'] as Timestamp).toDate();
    final appointmentTime = (data['appointmentTime'] as Timestamp).toDate();

    final patientName = data['patientName'] ?? 'Unknown Patient';

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Time Column
            SizedBox(
              width: 80,
              child: Text(
                // Formats time like "11:00 AM" or "7:30 PM"
               //DateFormat.jm().format(appointmentTime),
                DateFormat('hh:mm a').format(appointmentTime),

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColor.primaryColor,
                ),
                //  overflow: TextOverflow.ellipsis, // ensures it doesn't wrap
              ),
               
            ),
            // Details Column
            Expanded(
              child: Text(
                patientName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
