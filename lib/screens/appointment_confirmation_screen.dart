
import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment_app_new_clean/colors/app_color.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; 

class AppointmentConfirmationScreen extends StatelessWidget {
  const AppointmentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Receive the arguments passed during navigation. This is the reliable way.
    final Map<String, dynamic> arguments = Get.arguments;

    // 2. Safely extract the data from the arguments.
    final String doctorName = arguments['doctorName'] ?? 'N/A';
    final DateTime? dateTime = arguments['dateTime'];

    // 3. Format the data for clean display.
    final String formattedDate = dateTime != null
        ? DateFormat('EEEE, MMMM d, yyyy').format(dateTime)
        : 'N/A';
    final String formattedTime =
        dateTime != null ? DateFormat('h:mm a').format(dateTime) : 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Confirmation",
          style: TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.primaryColor),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                "🎉 Congratulations!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your appointment is booked.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
   
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Doctor: $doctorName", style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text("Date: $formattedDate", style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text("Time: $formattedTime", style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                
                onPressed: () => Get.offAllNamed('/appointments'),
                child: const Text("Done"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}