
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {

  final String _cloudName = "dhehmopnk";
  final String _uploadPreset = "unsigned_uploads";


  final User? user = FirebaseAuth.instance.currentUser;

  var isLoading = true.obs;
  var patientData = <String, dynamic>{}.obs;
  var imageFile = Rx<File?>(null); 

  String get fullName =>
      "${patientData['firstName'] ?? ''} ${patientData['lastName'] ?? ''}";
  String get email => patientData['email'] ?? '';
  String get phone => patientData['phone'] ?? '';
  String get address => patientData['address'] ?? '';
  String get birthDate => patientData['birthDate'] ?? '';

  @override
  void onInit() {
    super.onInit();
    fetchPatientProfile();
  }


  Future<void> fetchPatientProfile() async {
    isLoading.value = true;
    if (user == null) {
      isLoading.value = false;
      return;
    }
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('patients')
          .doc(user!.uid)
          .get();

      if (docSnapshot.exists) {
        patientData.value = docSnapshot.data()!;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch profile: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return; // User cancelled

    imageFile.value = File(pickedFile.path); // Show preview
    isLoading.value = true; // Show loading spinner

    try {
      // 
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
      );
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = _uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', pickedFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final String secureUrl = jsonMap['secure_url'];

 
        await FirebaseFirestore.instance
            .collection('patients')
            .doc(user!.uid)
            .update({'profileImage': secureUrl});

      
        patientData['profileImage'] = secureUrl;
        Get.snackbar("Success", "Profile image updated!");
      } else {
        throw Exception(
          'Cloudinary upload failed. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e");
    } finally {
      imageFile.value = null; // Clear the preview
      isLoading.value = false; // Hide loading spinner
    }
  }
  
}
