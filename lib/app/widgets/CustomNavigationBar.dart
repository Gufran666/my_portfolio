import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/app/views/HomePage.dart';
import '../controllers/HomeController.dart';
import '../repository/Database_repo.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF0F0F0F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            onEnter: (_) => Get.find<HomeController>().hoverLogo.value = true,
            onExit: (_) => Get.find<HomeController>().hoverLogo.value = false,
            child: Obx(() => Text(
              "PORTFOLIO",
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 28,
                color: Get.find<HomeController>().hoverLogo.value ? const Color(0xFF00FFFF) : Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            )),
          ),

          Row(
            children: [
              NavigationLink(
                text: "Home",
                onTap: () => Get.offAll(() => HomePage()),
              ),
              const SizedBox(width: 40),
              // NavigationLink(text: "About", onTap: () => Get.offAll(() => AboutScreen())),
              // const SizedBox(width: 40),
              // NavigationLink(text: "Projects", onTap: () => Get.offAll(() => ProjectsScreen())),
              // const SizedBox(width: 40),
              // NavigationLink(text: "Contact", onTap: () => Get.offAll(() => ContactScreen())),
            ],
          ),

          CustomAnimatedButton(
            text: "Download Resume",
            icon: Icons.download,
            onPressed: () async {
              final databaseService = Get.find<DatabaseService>();
              await databaseService.downloadResume();
              Get.snackbar(
                "Download Initiated",
                "Your resume is being downloaded!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF00FFFF).withOpacity(0.8),
                colorText: Colors.black,
                icon: const Icon(Icons.check_circle_outline, color: Colors.black),
                margin: const EdgeInsets.all(20),
                borderRadius: 10,
              );
            },
          ),
        ],
      ),
    );
  }
}

class NavigationLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isActive;

  const NavigationLink({
    super.key,
    required this.text,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return InkWell(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => controller.setHoveredLink(text),
        onExit: (_) => controller.setHoveredLink(''),
        child: Obx(() {
          final isHovered = controller.hoveredLink.value == text;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: isHovered || isActive ? const Color(0xFF8A2BE2).withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border(
                bottom: BorderSide(
                  color: isHovered || isActive ? const Color(0xFF00FFFF) : Colors.transparent,
                  width: 3.0,
                ),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isHovered || isActive ? const Color(0xFF00FFFF) : Colors.white70,
                fontSize: 17,
                fontWeight: isHovered || isActive ? FontWeight.bold : FontWeight.normal,
                letterSpacing: 0.5,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CustomAnimatedButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  const CustomAnimatedButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
  });

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: BorderRadius.circular(10),
        hoverColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFF00FFFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered ? const Color(0xFF00FFFF) : const Color(0xFF8A2BE2),
              width: 2,
            ),
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: const Color(0xFF00FFFF).withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 3,
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: _isHovered ? Colors.black : const Color(0xFF8A2BE2),
                  size: 20,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  color: _isHovered ? Colors.black : const Color(0xFF8A2BE2),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}