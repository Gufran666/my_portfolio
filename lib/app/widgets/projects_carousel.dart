import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/HomeController.dart';
import '../models/models.dart';

class ProjectsCarousel extends StatelessWidget {
  const ProjectsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40, bottom: 20, top: 40),
          child: Text(
            "MY PROJECTS",
            style: GoogleFonts.orbitron(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: const Color(0xFF8A2BE2).withOpacity(0.7),
                  offset: const Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 420,
          child: Obx(
                () => controller.projects.isEmpty
                ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00FFFF)),
              ),
            )
                : ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              itemCount: controller.projects.length,
              itemBuilder: (context, index) {
                final project = controller.projects[index];
                return ProjectCard(project: project);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutQuad,
        width: _isHovered ? 320 : 300,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[900],
          boxShadow: _isHovered
              ? [
            BoxShadow(
              color: const Color(0xFF00FFFF).withOpacity(0.8),
              spreadRadius: 6,
              blurRadius: 25,
              offset: const Offset(0, 8),
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: _isHovered ? const Color(0xFF00FFFF) : Colors.transparent,
            width: _isHovered ? 3 : 0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedScale(
                  scale: _isHovered ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutQuad,
                  child: Image.network(
                    widget.project.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[800],
                      child: Center(
                        child: Icon(Icons.image_not_supported, color: Colors.grey[600], size: 50),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: GoogleFonts.poppins(
                          color: _isHovered ? const Color(0xFF00FFFF) : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: _isHovered ? 22 : 20,
                        ),
                        child: Text(
                          widget.project.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedOpacity(
                        opacity: _isHovered ? 1.0 : 0.8,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          widget.project.description,
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 8,
                        runSpacing: 5,
                        children: widget.project.technologies.map((tech) {
                          return Chip(
                            label: Text(
                              tech,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF00FFFF),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            backgroundColor: const Color(0xFF00FFFF).withOpacity(0.15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: const Color(0xFF00FFFF).withOpacity(0.4), width: 1),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      AnimatedOpacity(
                        opacity: _isHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: _isHovered
                            ? Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: const Icon(Icons.launch, size: 30, color: Color(0xFF8A2BE2)),
                            onPressed: () {
                              Get.snackbar(
                                widget.project.title,
                                "Opening project details...",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: const Color(0xFF8A2BE2).withOpacity(0.8),
                                colorText: Colors.white,
                                icon: const Icon(Icons.info_outline, color: Colors.white),
                                margin: const EdgeInsets.all(20),
                                borderRadius: 10,
                              );
                            },
                            tooltip: "View Project",
                          ),
                        )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}