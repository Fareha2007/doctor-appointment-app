import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/doctorhomescreen.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_doctor_appointment_app_new_clean/colors/app_color.dart';
import 'package:flutter_doctor_appointment_app_new_clean/controller/appointment_controller.dart';

class MyAppointmentPage extends StatelessWidget {
  const MyAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the controller that is already fetching the data.
    final AppointmentController controller = Get.find<AppointmentController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Appointments",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.primaryColor),
          onPressed: () {
            Get.offAll(() => DoctorHomeScreen());
          },
        ),
      ),

      backgroundColor: AppColor.backgroundColor,
      //  to make the list automatically update when the data changes in the controller.
      body: Obx(() {
        print("Appointments list length: ${controller.appointments.length}");

        if (controller.appointments.isEmpty) {
          return const Center(
            child: Text(
              "You have no appointments booked.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // If appointments exist, build the list.
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.appointments.length,
          itemBuilder: (context, index) {
            final doc = controller.appointments[index];
            final data = doc.data() as Map<String, dynamic>;

            final doctorName = data['doctorName'] ?? 'N/A';

            // safely get appointmentTime
            Timestamp? appointmentTimestamp = data['appointmentTime'];
            DateTime? appointmentTime = appointmentTimestamp != null
                ? appointmentTimestamp.toDate()
                : null;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColor.primaryColor.withOpacity(0.1),
                  child: const Icon(
                    Icons.medical_services_outlined,
                    color: AppColor.primaryColor,
                  ),
                ),
                title: Text(
                  doctorName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  // Format the date and time nicely (e.g., "Sun, Aug 31, 2025  9:45 PM")
                  appointmentTime != null
                      ? DateFormat(
                          'EEE, MMM d, yyyy',
                        ).add_jm().format(appointmentTime)
                      : "No appointment time",
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
