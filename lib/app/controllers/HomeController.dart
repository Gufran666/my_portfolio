import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/app/models/models.dart';
import 'package:portfolio_website/app/repository/Database_repo.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late final AnimationController animationController;
  late final AnimationController typeAnimationController;
  final RxDouble animationValue = 0.0.obs;
  final RxString currentTagline = ''.obs;
  final RxList<Project> projects = <Project>[].obs;

  final RxString hoveredLink = ''.obs;
  final RxBool hoverLogo = false.obs;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    typeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    setupAnimations();
    fetchProjects();
    super.onInit();
  }

  void setupAnimations() {
    animationController.addListener(() {
      animationValue.value = animationController.value;
    });

    const taglines = [
      'CRAFTING DIGITAL EXPERIENCES',
      'BUILDING FOR THE FUTURE',
      'INNOVATIVE SOLUTIONS',
    ];

    int currentTaglineIndex = 0;
    typeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          currentTaglineIndex = (currentTaglineIndex + 1) % taglines.length;
          typeAnimationController.reset();
          typeAnimationController.forward();
        });
      }
    });

    typeAnimationController.addListener(() {
      final progress = typeAnimationController.value;
      final fullText = taglines[currentTaglineIndex];
      final charactersToShow = (fullText.length * progress).floor();
      currentTagline.value = fullText.substring(0, charactersToShow);
    });

    typeAnimationController.forward();
    animationController.repeat(reverse: true);
  }

  void setHoveredLink(String linkText) {
    hoveredLink.value = linkText;
  }

  Future<void> fetchProjects() async {
    final databaseService = Get.find<DatabaseService>();
    projects.value = await databaseService.fetchProjects();
  }

  @override
  void onClose() {
    animationController.dispose();
    typeAnimationController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}