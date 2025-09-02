import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_doctor_appointment_app_new_clean/colors/app_color.dart';
import 'package:flutter_doctor_appointment_app_new_clean/controller/appointment_controller.dart';


class DoctorDetailsScreen2 extends StatelessWidget {
  // 1. Declare the final variable for the class
  final Map<String, dynamic> doctor;

  // 2. Update the constructor to initialize `this.doctor`
  const DoctorDetailsScreen2({required this.doctor, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
 
    final AppointmentController controller = Get.find<AppointmentController>();
  

    const String doctorId = 'WZmt1iUiNNTwhZimsrhvgv2bAGP2';
    const String doctorName = 'Dr. A. Zaki';
    const String imagePath = 'assets/images/doctor2.png';
    const String specialty = 'Homeopath';
    const String qualifications = 'B.H.M.S.M.D(Hom), M.Sc.(Psychology)...';
    const String aboutMe = 'Dr. A. Zaki provides expert natural healing...';
    const String workingTime = 'Mon–Sat, 11:00 AM–1:00 PM & 7 PM - 10 PM';
    final Map<String, dynamic> review = {
      'reviewerName': 'Abdul Aziz',
      'reviewerImage': 'assets/images/reviewer2.png',
      'comment':
          'Dr. Zaki provides outstanding treatment and considerate advice, under the mentorship of seasoned homeopathic specialists..',
    };
    // ---

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doctor Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
        foregroundColor: AppColor.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Info Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePath,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            specialty,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.subTextColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            qualifications,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColor.subTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(Icons.group, '25,000+', 'patients'),
                  _buildStat(Icons.medical_services, '20+', 'experience'),
                  _buildStat(Icons.star, '10', 'rating'),
                  _buildStat(Icons.chat_bubble, '1,872', 'reviews'),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                'About me',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(aboutMe, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 20),

              const Text(
                'Working Time',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(workingTime, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 20),

              const Text(
                'Reviews',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              // Review Card
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      review['reviewerImage']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review['reviewerName']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(
                            5,
                            (index) => const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          review['comment']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Book Appointment Button
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            try {
                              controller.isLoading.value = true;
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                // ADDED: This handles opening the picker on a Sunday
                                initialDate:
                                    DateTime.now().weekday == DateTime.sunday
                                    ? DateTime.now().add(
                                        const Duration(days: 1),
                                      )
                                    : DateTime.now(),
                                // firstDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                                // ADDED: This is the rule that disables all Sundays
                                selectableDayPredicate: (day) =>
                                    day.weekday != DateTime.sunday,
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Colors.cyan,
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              TimeOfDay? pickedTime;
                              if (pickedDate != null) {
                                if (!context.mounted) return;
                                pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: const TimeOfDay(
                                    hour: 11,
                                    minute: 0,
                                  ),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: Colors.cyan,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                              }

                              if (pickedDate != null && pickedTime != null) {
                                // This is your time validation logic, which is correct
                                final hour = pickedTime.hour;
                                final bool isValidTime =
                                    (hour >= 11 && hour < 13) ||
                                    (hour >= 19 && hour < 22);

                                if (isValidTime) {
                                  DateTime finalDateTime = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );

                                  await controller.addAppointment(
                                    doctorName: doctorName,
                                    doctorId: doctorId,
                                    appointmentDateTime: finalDateTime,
                                  );
                                  await controller.fetchAppointments();
                                  Get.snackbar(
                                    'Success',
                                    'Appointment booked!',
                                  );
                                  if (!context.mounted) return;
                                  Get.toNamed(
                                    '/Confirm',
                                    arguments: {
                                      'doctorName': 'Dr. Abdul Zaki',
                                      'dateTime': finalDateTime,
                                    },
                                  );
                                } else {
                                  Get.snackbar(
                                    'Invalid Time',
                                    'Timings are 11 AM - 1 PM and 7 PM - 10 PM.',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                }
                              }
                            } catch (e) {
                              Get.snackbar(
                                'Error',
                                'Could not book appointment.',
                              );
                            } finally {
                              controller.isLoading.value = false;
                            }
                          },

                    child: Text(
                      controller.isLoading.value
                          ? "Booking..."
                          : "Book Appointment",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String count, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColor.primaryColor, size: 30),
        const SizedBox(height: 4),
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: AppColor.subTextColor, fontSize: 12),
        ),
      ],
    );
  }
}
