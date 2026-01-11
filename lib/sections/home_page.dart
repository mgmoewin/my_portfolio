import 'package:flutter/material.dart';
import 'package:porfolio/widgets/particle_field.dart';
import 'package:porfolio/main.dart';
import 'package:porfolio/sections/hero_section.dart';
import 'package:porfolio/widgets/glass.card.dart';
import 'package:porfolio/widgets/responsive_builder.dart';
import 'package:porfolio/sections/about_section.dart';
import 'package:porfolio/sections/tech_stack_section.dart';
import 'package:porfolio/sections/project_section.dart';
import 'package:porfolio/sections/contact_section.dart';
import 'package:porfolio/sections/footer_section.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Create a GlobalKey for each section
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey stackKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  final GlobalKey footerKey = GlobalKey();

  late final Map<String, GlobalKey> navKeys;

  @override
  void initState() {
    super.initState();
    navKeys = {
      'About': aboutKey,
      'Stack': stackKey,
      'Projects': projectsKey,
      'Contact': contactKey,
      'Overview': heroKey,
    };
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check the current theme mode to apply the correct background.
    final isDark = themeModeNotifier.value == ThemeMode.dark;

    return ResponsiveBuilder(
      builder: (context, screenSize) {
        final isMobile =
            screenSize == ScreenSizeCategory.mobile ||
            screenSize == ScreenSizeCategory.smallMobile;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Header(
              isMobile: isMobile,
              onNavItemTap: _scrollToSection,
              navKeys: navKeys,
            ),
          ),
          drawer: isMobile
              ? MobileDrawer(onNavItemTap: _scrollToSection, navKeys: navKeys)
              : null,
          body: Stack(
            children: [
              // fixed background gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: isDark
                        ? LinearGradient(
                            colors: [
                              Colors.purple.shade900,
                              Colors.black,
                              Colors.blue.shade900,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : const LinearGradient(
                            colors: [
                              Color(0xFFE0E0FF),
                              Color(0xFFF9F9F9),
                              Color(0xFFE0E0FF),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                  ),
                ),
              ),
              // fixed particle field
              const Positioned.fill(child: ParticleField()),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 100),
                    HeroSection(
                      key: heroKey,
                      contactKey: contactKey,
                      onContactMeTap: _scrollToSection,
                    ),
                    AboutSection(key: aboutKey),
                    TechnologyStackSection(key: stackKey),
                    ProjectSection(key: projectsKey),
                    ContactSection(key: contactKey),
                    FooterSection(key: footerKey),
                  ],
                ),
              ),
              if (!isMobile) const _VerticalPhoneNumber(),
            ],
          ),
        );
      },
    );
  }
}

class _VerticalPhoneNumber extends StatelessWidget {
  const _VerticalPhoneNumber();

  void _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+1234567890');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0, // Adjust this value to control the distance from the edge
      top: 0,
      bottom: 40,
      child: Center(
        child: RotatedBox(
          quarterTurns: 1,
          child: TextButton.icon(
            onPressed: _launchPhone,
            icon: const Icon(Icons.phone_in_talk, size: 16),
            label: const Text(
              '+959 766 187 984',
              style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w600),
            ),
          ), // Closes TextButton.icon
        ), // Closes RotatedBox
      ), // Closes Center
    );
  }
}

class Header extends StatelessWidget {
  final bool isMobile;
  final void Function(GlobalKey) onNavItemTap;
  final Map<String, GlobalKey> navKeys;

  const Header({
    super.key,
    required this.isMobile,
    required this.onNavItemTap,
    required this.navKeys,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeModeNotifier.value == ThemeMode.dark;
    final theme = Theme.of(context);

    if (isMobile) {
      // Mobile Header
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Text(
                'MW',
                style: theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: <Color>[Colors.purpleAccent, Colors.blueAccent],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: theme.colorScheme.onSurface,
              ),
              onPressed: () {
                themeModeNotifier.value = isDark
                    ? ThemeMode.light
                    : ThemeMode.dark;
              },
            ),
          ],
        ),
      );
    }
    // Desktop/Tablet Header
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // This is the glass card with the nav items
          GlassCard(
            child: Row(
              children: [
                Text(
                  'MW',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    foreground: Paint()
                      ..shader =
                          const LinearGradient(
                            colors: <Color>[
                              Colors.purpleAccent,
                              Colors.blueAccent,
                            ],
                          ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                          ),
                  ),
                ),
                const SizedBox(width: 30),
                ..._buildNavItems(context, onNavItemTap),
                IconButton(
                  icon: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    color: theme.colorScheme.onSurface,
                  ),
                  onPressed: () {
                    themeModeNotifier.value = isDark
                        ? ThemeMode.light
                        : ThemeMode.dark;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(
    BuildContext context,
    void Function(GlobalKey) onNavItemTap,
  ) {
    final navItems = ['Overview', 'About', 'Stack', 'Projects', 'Contact'];
    final theme = Theme.of(context);
    return navItems.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextButton(
          onPressed: () => onNavItemTap(navKeys[item]!),
          child: Text(
            item,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }).toList();
  }
}

// Drawer design for Mobile view
class MobileDrawer extends StatelessWidget {
  final void Function(GlobalKey) onNavItemTap;
  final Map<String, GlobalKey> navKeys;
  const MobileDrawer({
    super.key,
    required this.onNavItemTap,
    required this.navKeys,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navItems = ['Overview', 'About', 'Stack', 'Projects', 'Contact'];

    return Drawer(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: navItems.map((item) {
            return ListTile(
              title: Text(item, style: theme.textTheme.bodyLarge),
              onTap: () {
                onNavItemTap(navKeys[item]!);
                Navigator.of(context).pop(); // Close the drawer
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
