import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../colors/app_color.dart';
import 'package:flutter_doctor_appointment_app_new_clean/controller/profileController.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: AppColor.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.patientData.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.patientData.isEmpty) {
          return const Center(child: Text("No profile data found."));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: screenWidth * 0.15,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: controller.imageFile.value != null
                            ? FileImage(controller.imageFile.value!)
                            : (controller.patientData['profileImage'] != null &&
                                          controller
                                              .patientData['profileImage']
                                              .isNotEmpty
                                      ? NetworkImage(
                                          controller
                                              .patientData['profileImage'],
                                        )
                                      : const AssetImage(
                                          'assets/images/default.png',
                                        ))
                                  as ImageProvider,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColor.primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
            
                 
                    Obx(() {
                      // Use a simple, indeterminate spinner based on isLoading
                      if (controller.isLoading.value) {
                        return const CircularProgressIndicator();
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04), // 4% of screen height
              Obx(
                () => Column(
                  children: [
                    _buildReadOnlyField("Name", controller.fullName),
                    _buildReadOnlyField("Email", controller.email),
                    _buildReadOnlyField("Phone", controller.phone),
                    _buildReadOnlyField("Address", controller.address),
                    _buildReadOnlyField("Birth Date", controller.birthDate),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.offAllNamed('/login');
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.primaryColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.primaryColor,
              width: 2,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
