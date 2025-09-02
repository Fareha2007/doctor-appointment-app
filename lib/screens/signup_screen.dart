
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/signup_controller.dart';
import '../colors/app_color.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  // It's better to initialize the controller and form key once.
  final SignupController controller = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Form(
            // 1. Form widget added for validation
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildTextField(
                  controller: controller.firstNameController,
                  label: "First name",
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your first name" : null,
                ),
                _buildTextField(
                  controller: controller.lastNameController,
                  label: "Last name",
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your last name" : null,
                ),
                _buildTextField(
                  controller: controller.emailController,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty || !value.isEmail
                      ? "Please enter a valid email"
                      : null,
                ),
                _buildTextField(
                  controller: controller.addressController,
                  label: "Address",
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your address" : null,
                ),
                // 2. Birth Date field with Date Picker
                _buildDateField(context),
                _buildTextField(
                  controller: controller.phoneController,
                  label: "Phone number",
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your phone number" : null,
                ),
                // 3. Password field with visibility toggle
                Obx(
                  () => _buildTextField(
                    controller: controller.passwordController,
                    label: "Password",
                    isPassword: controller.isPasswordObscured.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordObscured.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: (value) => value!.length < 6
                        ? "Password must be at least 6 characters"
                        : null,
                  ),
                ),
                Obx(
                  () => _buildTextField(
                    controller: controller.confirmPasswordController,
                    label: "Confirm password",
                    isPassword: controller.isConfirmPasswordObscured.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmPasswordObscured.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                    validator: (value) {
                      if (value != controller.passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              // Validate the form before trying to sign up
                              if (_formKey.currentState!.validate()) {
                                controller.signUpUser();
                              }
                            },
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // --- Login Link ---
                Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.black54),
                    children: [
                      TextSpan(
                        text: "Log in",
                        style: const TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed('/login'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper for text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        // Changed to TextFormField for validation
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        decoration: _inputDecoration(label, suffixIcon: suffixIcon),
      ),
    );
  }

  
  InputDecoration _inputDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
    );
  }

  // Helper for the birth date field
  Widget _buildDateField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller.birthDateController,
        readOnly: true, // Makes the field not editable directly
        validator: (value) =>
            value!.isEmpty ? "Please select your birth date" : null,
        decoration: _inputDecoration(
          "Birth date",
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          // Hide keyboard
          FocusScope.of(context).requestFocus(FocusNode());
          // Show Date Picker
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),

            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: AppColor
                        .primaryColor, // Header background & selected day color
                    onPrimary:
                        Colors.white, // Header text & selected day text color
                    onSurface:
                        Colors.black, // Color of other dates in the calendar
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          AppColor.primaryColor, // Color for OK/CANCEL buttons
                    ),
                  ),
                ),
                child: child!,
              );
            },
         
          );
          if (pickedDate != null) {
            // Format the date and update the controller
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            controller.birthDateController.text = formattedDate;
          }
        },
      ),
    );
  }
}
