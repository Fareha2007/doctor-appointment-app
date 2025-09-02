import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment_app_new_clean/colors/app_color.dart';
import 'package:flutter_doctor_appointment_app_new_clean/controller/login_controller.dart';
import 'package:flutter_doctor_appointment_app_new_clean/screens/signup_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());

  void _navigateToSignUp(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),

              // Logo
              Image.asset(
                'assets/images/logo.png',
                height: 90,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),

              // Titles
              const Text(
                "Hi, Welcome Back!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.backgroundColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              const Text(
                "Hope you’re doing fine",
                style: TextStyle(fontSize: 14, color: AppColor.backgroundColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Email Field
              TextField(
                controller: loginController.emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColor.subTextColor,
                  ),
                  hintText: "Your Email",
                  hintStyle: const TextStyle(color: AppColor.subTextColor),
                  filled: true,
                  fillColor: AppColor.backgroundColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Password Field
              TextField(
                controller: loginController.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColor.subTextColor,
                  ),
                  hintText: "Password",
                  hintStyle: const TextStyle(color: AppColor.subTextColor),
                  filled: true,
                  fillColor: AppColor.backgroundColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Log In Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loginController.isLoading.value
                        ? null
                        : () => loginController.loginUser(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.backgroundColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: loginController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Log in",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Forget Password
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password reset feature coming soon!"),
                    ),
                  );
                },
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(
                    color: AppColor.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Sign up Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t have an account yet?",
                    style: TextStyle(
                      color: AppColor.backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => _navigateToSignUp(context),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
