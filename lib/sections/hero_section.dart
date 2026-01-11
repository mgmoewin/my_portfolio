import 'package:flutter/material.dart';

import 'package:porfolio/widgets/social_button.dart';
import 'package:porfolio/widgets/available_for_project.dart';
import 'package:porfolio/widgets/typing_text.dart';
import 'package:porfolio/widgets/scroll_for_more.dart';

import 'package:porfolio/widgets/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final GlobalKey contactKey;
  final void Function(GlobalKey) onContactMeTap;

  const HeroSection({
    super.key,
    required this.contactKey,
    required this.onContactMeTap,
  });
  @override
  _HeroSectionState createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // If launching fails, show a snackbar.
      // This can happen if there's no email client installed.
      _showErrorSnackBar(
        'Could not open email client. Please check if an email app is installed.',
      );
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenSize) {
        double titleFontSize = 62;
        double descriptionWidth = 600;
        MainAxisAlignment columnAlignment = MainAxisAlignment.center;
        CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
        TextAlign textAlign = TextAlign.center;

        if (screenSize == ScreenSizeCategory.smallMobile) {
          titleFontSize = 32;
          descriptionWidth = MediaQuery.of(context).size.width * 0.9;
        } else if (screenSize == ScreenSizeCategory.mobile) {
          titleFontSize = 42;
          descriptionWidth = MediaQuery.of(context).size.width * 0.8;
        } else if (screenSize == ScreenSizeCategory.tablet) {
          titleFontSize = 52;
          descriptionWidth = 600;
        }

        return Container(
          height: MediaQuery.of(context).size.height - 80,
          alignment: Alignment.center,
          // Decoration moved to Homepage for full-screen background
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: columnAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      ' Moe Win ( Mazhai ) ',
                      softWrap: false,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // The button in the image is "Full Stack Developer"
                  const TypingText(
                    texts: [
                      'Junior Flutter Developer',
                      '   Flutter Enthusiast',
                      '  Mobile App Developer',
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: descriptionWidth,
                    child: Text(
                      'Crafting exceptional digital experiences with clean code and thoughtful design',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: textAlign,
                    ),
                  ),
                  const SizedBox(height: 40),
                  if (screenSize == ScreenSizeCategory.smallMobile ||
                      screenSize == ScreenSizeCategory.mobile)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SocialButton(
                                icon: const Icon(Icons.code),
                                text: 'GitHub',
                                onPressed: () =>
                                    _launchURL('https://github.com/mgmoewin'),
                              ),
                            ),
                            Expanded(
                              child: SocialButton(
                                icon: const Icon(Icons.group),
                                text: 'LinkedIn',
                                onPressed: () => _launchURL(
                                  'https://www.linkedin.com/in/moe-win-3910411ab/',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SocialButton(
                          icon: const Icon(Icons.email),
                          text: 'Email',
                          onPressed: () => _launchURL(
                            'mailto:moewin4070@gmail.com?subject=Portfolio Contact',
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(
                          icon: const Icon(Icons.code),
                          text: 'GitHub',
                          onPressed: () =>
                              _launchURL('https://github.com/mgmoewin'),
                        ),
                        SocialButton(
                          icon: const Icon(Icons.group),
                          text: 'LinkedIn',
                          onPressed: () => _launchURL(
                            'https://www.linkedin.com/in/moe-win-3910411ab/',
                          ),
                        ),
                        SocialButton(
                          icon: const Icon(Icons.email),
                          text:
                              'Email', // This is the button you wanted to change
                          onPressed: () => _launchURL(
                            'mailto:moewin4070@gmail.com?subject=Portfolio Contact',
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 40),
                  AvailableForProjectsWidget(
                    onTap: () => widget.onContactMeTap(widget.contactKey),
                  ),
                  const SizedBox(height: 20),
                  const ScrollForMore(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
