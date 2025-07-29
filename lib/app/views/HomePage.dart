import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/app/controllers/HomeController.dart';
import 'package:portfolio_website/app/widgets/CustomNavigationBar.dart';

import '../widgets/footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/projects_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: Get.find<HomeController>().scrollController,
        child: const Column(
          children: [
            CustomNavigationBar(),
            HeroSection(),
            ProjectsCarousel(),
            Footer(),
          ],
        ),
      ),
    );
  }
}