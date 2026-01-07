import 'dart:async';

import 'package:flutter/material.dart';
import 'package:porfolio/widgets/section_description.dart';
import 'package:porfolio/widgets/section_header.dart';
import 'package:porfolio/widgets/section_title_gradient.dart';
import 'package:porfolio/widgets/skill_card.dart';

class TechnologyStackSection extends StatefulWidget {
  const TechnologyStackSection({super.key});

  @override
  State<TechnologyStackSection> createState() => _TechnologyStackSectionState();
}

class _TechnologyStackSectionState extends State<TechnologyStackSection>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // The auto-scroll will start after the initial staggered animation
      _startAutoScroll();
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        _scrollController.jumpTo(
          currentScroll + 1.5 > maxScroll ? 0 : currentScroll + 1.5,
        );
      }
    });
  }

  Widget _buildAnimatedSkillCard(Widget child, int index) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        // A simple animation that triggers based on scroll position.
        // This can be made more sophisticated with VisibilityDetector if needed.
        // For a horizontal list, we can animate based on the card's position.
        final cardPosition = index * 180.0; // 150 width + 30 margin
        final currentScroll = _scrollController.hasClients
            ? _scrollController.position.pixels
            : 0.0;
        final screenWidth = MediaQuery.of(context).size.width;

        // Check if the card is within the viewport
        bool isVisible =
            (cardPosition >= currentScroll &&
            cardPosition < currentScroll + screenWidth);

        return AnimatedOpacity(
          duration: Duration(milliseconds: 500 + (index * 100)),
          opacity: isVisible ? 1.0 : 0.0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400 + (index * 100)),
            transform: Matrix4.translationValues(0, isVisible ? 0 : 30, 0),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with your actual data
    const String title = 'Technology Stack';
    const String description =
        'The tools and technologies I use to bring ideas to life.';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          const SectionHeader(text: 'Tech Arsenal', icon: Icons.code),
          const SizedBox(height: 30),
          const SectionTitleGradient(title: title),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                colors: [Colors.purple.shade500, Colors.blue.shade500],
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SectionDescription(text: description),
          const SizedBox(height: 50),
          SizedBox(
            height: 250,
            child: MouseRegion(
              onEnter: (_) => _stopAutoScroll(),
              onExit: (_) => _startAutoScroll(),
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 20), // Initial padding
                  ...List.generate(
                    _skills.length,
                    (index) => _buildAnimatedSkillCard(
                      SkillCard(
                        label: _skills[index]['label']!,
                        imagePath: _skills[index]['imagePath']!,
                        isSelected: _skills[index]['isSelected'] == 'true',
                      ),
                      index,
                    ),
                  ),
                  const SizedBox(width: 20), // Final padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Data for the skill cards
  final List<Map<String, String>> _skills = const [
    {'label': 'Flutter', 'imagePath': 'assets/images/flutter.png'},
    {
      'label': 'Dart',
      'imagePath': 'assets/images/dart.png',
      'isSelected': 'true',
    },
    {'label': 'Firebase', 'imagePath': 'assets/images/firebase.png'},
    {'label': 'MySQL', 'imagePath': 'assets/images/mysql.png'},
    {'label': 'Figma', 'imagePath': 'assets/images/figma.png'},
    {'label': 'Java', 'imagePath': 'assets/images/java.png'},
    {'label': 'AWS', 'imagePath': 'assets/images/aws.png'},
    {'label': 'Git', 'imagePath': 'assets/images/git.png'},
    {'label': 'HTML', 'imagePath': 'assets/images/html.png'},
    {'label': 'CSS', 'imagePath': 'assets/images/css.png'},
    {'label': 'JavaScript', 'imagePath': 'assets/images/js.png'},
    {'label': 'Python', 'imagePath': 'assets/images/python.png'},
    {'label': 'Supabase', 'imagePath': 'assets/images/supabase.png'},
    {'label': 'BootStrap', 'imagePath': 'assets/images/bootstrap.png'},
  ];

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }
}
