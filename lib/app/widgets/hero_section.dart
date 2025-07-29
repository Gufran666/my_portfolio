import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/HomeController.dart';
import 'BinaryCodeBackground.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    final screenHeight = MediaQuery.sizeOf(context).height;
    final heroSectionHeight = screenHeight * 0.9;

    return Container(
      height: heroSectionHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F0F0F),
            Color(0xFF1A1A2E),
          ],
        ),
      ),
      child: Stack(
        children: [
          Obx(() {
            return Opacity(
              opacity: controller.animationValue.value * 0.7 + 0.3,
              child: const BinaryCodeBackground(),
            );
          }),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  final scale = 1.0 + (controller.animationValue.value * 0.05);
                  final opacity = controller.animationValue.value * 0.8 + 0.2;
                  return Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: opacity,
                      child: Text(
                        "FLUTTER DEVELOPER",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.orbitron(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 15.0,
                              color: const Color(0xFF00FFFF).withOpacity(0.8),
                              offset: const Offset(0, 0),
                            ),
                            Shadow(
                              blurRadius: 25.0,
                              color: const Color(0xFF00FFFF).withOpacity(0.4),
                              offset: const Offset(0, 0),
                            ),
                          ],
                          letterSpacing: 3.0,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),

                Obx(() {
                  return Text(
                    controller.currentTagline.value,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaCode(
                      color: const Color(0xFF8A2BE2),
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: const Color(0xFF8A2BE2).withOpacity(0.5),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 50),

                Obx(() {
                  final opacity = controller.animationValue.value;
                  return AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 500),
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - opacity)),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.snackbar(
                            "Explore More",
                            "Navigating to projects section...",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color(0xFF00FFFF).withOpacity(0.8),
                            colorText: Colors.black,
                            icon: const Icon(Icons.code, color: Colors.black),
                            margin: const EdgeInsets.all(20),
                            borderRadius: 10,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                        label: Text(
                          "Explore My Work",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00FFFF),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 10,
                          shadowColor: const Color(0xFF00FFFF).withOpacity(0.6),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}