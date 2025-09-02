import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../colors/app_color.dart';

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({super.key});

  // A single, robust function to handle all URL launching.
  // It includes error handling and user feedback.
  Future<void> _launchURL(Uri uri, BuildContext context) async {
    try {
      // Use external application mode for maps to ensure it opens in the Google Maps app.
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open ${uri.scheme}.')),
        );
      }
    } catch (e) {
      print('Failed to launch URL: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define contact details as constants for easy management.
    const String phoneNumber = '+919822857037';
    const String email = 'drzaki01@gmail.com';
    const String mapsQuery = 'Yaseen Homeopathic Clinic, Deglour Naka';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        Text(
          "Contact Us",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        // Using a helper widget with InkWell for the material ripple effect on tap.
        _buildActionRow(
          context: context,
          icon: Icons.phone_outlined,
          text: "Call",
          onTap: () {
            final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
            _launchURL(phoneUri, context);
          },
        ),
        _buildActionRow(
          context: context,
          icon: Icons.email_outlined,
          text: "Email",
          onTap: () {
            final Uri emailUri = Uri(scheme: 'mailto', path: email);
            _launchURL(emailUri, context);
          },
        ),
        _buildActionRow(
          context: context,
          icon: Icons.location_on_outlined,
          text: "Location",
          onTap: () {
            // URL-encodes the query to handle spaces and special characters.
            final Uri mapsUri = Uri.parse(
              'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(mapsQuery)}',
            );
            _launchURL(mapsUri, context);
          },
        ),
      ],
    );
  }

  // Reusable row for call/email/location buttons with improved styling.
  Widget _buildActionRow({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.025),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: AppColor.primaryColor, size: 24),
                    SizedBox(width: screenWidth * 0.04),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
