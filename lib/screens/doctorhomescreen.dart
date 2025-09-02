import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment_app_new_clean/colors/app_color.dart';
import 'package:flutter_doctor_appointment_app_new_clean/controller/appointment_controller.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/contact_us_card.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/doctor_detail_screen.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/doctor_detail_screen2.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/my_appointment_page.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/profile_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔎 Search bar
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "This is a design showcase. Search functionality is not active.",
                      ),
                    ),
                  );
                },
                child: Container(
                  height: height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],

                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: width * 0.02),
                      Text(
                        "Search doctor...",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: width * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // 🖼 Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/poster2.png",
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: height * 0.03),

              // 👨‍⚕️ Top Doctors
              Text(
                "Top Doctors",

                style: TextStyle(
                  //    fontSize: width * 0.05,
                  fontSize: MediaQuery.of(context).size.width * 0.045,

                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.015),

              // Doctor 1
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorDetailsScreen2(doctor: {}),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(width * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: width * 0.07,
                        backgroundImage: const AssetImage(
                          'assets/images/doctor2.png',
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr A. Zaki",
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Homeopath",
                            style: TextStyle(
                              fontSize: width * 0.038,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.015),

              // Doctor 2
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorDetailsScreen(
                        doctor: {
                          "id": "0XLc13fcFiVsj1d6LI6crvXNVN23",
                          "name": "Dr Samina Zaki",
                          "specialty": "Homeopath",
                          "image": "assets/images/doctor.png",
                        },
                      ),
                    ),
                  );
                },

                child: Container(
                  padding: EdgeInsets.all(width * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: width * 0.07,
                        backgroundImage: const AssetImage(
                          'assets/images/doctor.png',
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr Samina Zaki",
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Homeopath",
                            style: TextStyle(
                              fontSize: width * 0.038,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),

              const ContactUsCard(),
            ],
          ),
        ),
      ),

      //  Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.primaryColor.withOpacity(0.63),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAppointmentPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientProfileScreen()),
            );
          }
        },
      ),
    );
  }
}

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(launchUri);
}

Future<void> _launchEmail(String email) async {
  final Uri launchUri = Uri(scheme: 'mailto', path: email);
  await launchUrl(launchUri);
}

// This is the function you should call when your location button is pressed
Future<void> _requestLocationPermission(BuildContext context) async {
  // Check the current status of the location permission
  var status = await Permission.location.status;

  if (status.isGranted) {
    // Permission is already granted, you can open location services
    print("Location permission is granted.");
    // Add your code here to get the location or open maps
  } else if (status.isDenied) {
    // Permission is denied, so we need to request it
    if (await Permission.location.request().isGranted) {
      // The user granted the permission
      print("Location permission was granted.");
      // Add your code here to get the location or open maps
    } else {
      // The user denied the permission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission is required.")),
      );
    }
  } else if (status.isPermanentlyDenied) {
    // The user has permanently denied the permission.
    // We need to open app settings to let them enable it.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Location permission is permanently denied. Please enable it in app settings.",
        ),
      ),
    );
    await openAppSettings();
  }
}
