import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/HomeController.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0F0F0F),
            Color(0xFF1A1A2E),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "© 2023 [Your Name/Company Name]. All rights reserved.",
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialMediaIcon(
                icon: FontAwesomeIcons.github,
                url: "https://github.com/yourusername",
                tooltip: "GitHub",
              ),
              const SizedBox(width: 30),
              SocialMediaIcon(
                icon: FontAwesomeIcons.linkedinIn,
                url: "https://linkedin.com/in/yourprofile",
                tooltip: "LinkedIn",
              ),
              const SizedBox(width: 30),
              SocialMediaIcon(
                icon: Icons.email,
                url: "mailto:youremail@example.com",
                tooltip: "Email",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SocialMediaIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final String tooltip;

  const SocialMediaIcon({
    super.key,
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  State<SocialMediaIcon> createState() => _SocialMediaIconState();
}

class _SocialMediaIconState extends State<SocialMediaIcon> {
  bool _isHovered = false;

   Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
       Get.snackbar(
         "Error",
         "Could not launch ${widget.tooltip} link.",
        snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.redAccent.withOpacity(0.8),
         colorText: Colors.white,
         icon: const Icon(Icons.error_outline, color: Colors.white),
         margin: const EdgeInsets.all(20),
         borderRadius: 10,
       );
     }
   }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // _launchURL(widget.url);
          Get.snackbar(
            widget.tooltip,
            "Opening ${widget.tooltip} link...",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF00FFFF).withOpacity(0.8),
            colorText: Colors.black,
            icon: Icon(widget.icon, color: Colors.black),
            margin: const EdgeInsets.all(20),
            borderRadius: 10,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFF00FFFF).withOpacity(0.2) : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered ? const Color(0xFF00FFFF) : Colors.transparent,
              width: 2,
            ),
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: const Color(0xFF00FFFF).withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
            ]
                : [],
          ),
          child: Tooltip(
            message: widget.tooltip,
            child: Icon(
              widget.icon,
              size: 28,
              color: _isHovered ? const Color(0xFF00FFFF) : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}