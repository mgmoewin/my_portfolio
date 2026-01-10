import 'dart:convert';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:porfolio/config/emailjs_config.dart';
import 'package:porfolio/widgets/gradient_button.dart';
import 'package:porfolio/widgets/responsive_builder.dart';
import 'package:porfolio/widgets/section_description.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:porfolio/widgets/section_header.dart';
import 'package:porfolio/widgets/section_title_gradient.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      child: Column(
        children: [
          const SectionHeader(text: 'Get In Touch', icon: Icons.email_outlined),

          const SizedBox(height: 30),
          const SectionTitleGradient(title: 'Contact Me'),
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
          const SectionDescription(
            text:
                'I\'m always open to discussing new projects, creative ideas, \n or opportunities to be part of your visions.',
          ),
          const SizedBox(height: 50),
          ResponsiveBuilder(
            builder: (context, screenSize) {
              bool isSmall =
                  screenSize == ScreenSizeCategory.smallMobile ||
                  screenSize == ScreenSizeCategory.mobile;
              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isSmall ? 400 : 800),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name and Email fields
                      if (isSmall) ...[
                        _buildTextField(
                          context,
                          controller: _nameController,
                          label: 'Name *',
                          hint: 'Your full name',
                        ),
                        const SizedBox(height: 24),
                        _buildTextField(
                          context,
                          controller: _emailController,
                          label: 'Email *',
                          hint: 'your.email@example.com',
                          isEmail: true,
                        ),
                      ] else
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                context,
                                controller: _nameController,
                                label: 'Name *',
                                hint: 'Your full name',
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildTextField(
                                context,
                                controller: _emailController,
                                label: 'Email *',
                                hint: 'your.email@example.com',
                                isEmail: true,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 26),

                      // Message field
                      _buildTextField(
                        context,
                        controller: _messageController,
                        label: 'Message *',
                        hint: 'Tell me about your project or idea...',
                        maxLines: 5,
                      ),
                      const SizedBox(height: 32),

                      // Send Message button
                      Center(
                        child: SizedBox(
                          width: 250, // Constraining the width of the button
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF812DFF), Color(0xFF5A44FF)],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                            child: _HoverableButton(
                              onPressed: _isSending ? null : () => _sendEmail(),
                              child: _isSending
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 18),
                                        Text(
                                          'Sending...',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mail_outline_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 18),
                                        Text(
                                          'Send Message',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // "Or reach out directly" text
                      Center(
                        child: SelectableText(
                          'Or reach out directly:',
                          style: const TextStyle(color: Color(0xFF6B6B6B)),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Bottom buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _HoverableOutlinedButton(
                            // This button can still open the mail client directly
                            onPressed: () => _sendEmail(isDirect: true),
                            icon: const Icon(Icons.mail),
                            label: 'Send Email',
                          ),
                          const SizedBox(width: 16),
                          GradientButton(
                            onPressed: () {
                              // This points to the CV file you added in the web/cv/ directory.
                              const String cvUrl =
                                  'cv/Moe Win_Flutter_Developer_Resume.pdf';
                              launchUrl(
                                Uri.parse(cvUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            icon: Icons.download,
                            text: 'Download CV',
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 11,
                            ),
                            fontSize: 13,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _sendEmail({bool isDirect = false}) async {
    if (isDirect) {
      // This part remains the same for the "Send Email" button
      const String myEmail = 'moewin4070@gmail.com';
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: myEmail,
        query: 'subject=${Uri.encodeComponent('Contact from Portfolio')}',
      );

      try {
        await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
      } catch (e) {
        if (mounted) {
          _showNotification(
            'Could not open email client. Please check if an email app is installed.',
            isError: true,
          );
        }
      }
      return;
    }

    // Logic for sending email directly via EmailJS
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSending = true;
    });

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    try {
      final response = await http.post(
        url,
        headers: {
          // EmailJS requires the 'origin' header to be present for CORS checks,
          // even on mobile. For web, Uri.base.origin provides the correct value.
          // For mobile, we can use a placeholder or the intended web domain.
          'origin': kIsWeb ? Uri.base.origin : 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': EmailJSConfig.serviceId,
          'template_id': EmailJSConfig.templateId,
          'user_id': EmailJSConfig.userId,
          'template_params': {
            'user_name': _nameController.text,
            'user_email': _emailController.text,
            'message': _messageController.text,
            // Add the current time to match the '{{time}}' field in your template
            'time': DateTime.now().toUtc().toIso8601String(),
          },
        }),
      );

      if (response.statusCode == 200) {
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        _showNotification('Message sent successfully!');
      } else {
        // Log the error for debugging and show a generic message.
        debugPrint('EmailJS Error: ${response.statusCode} - ${response.body}');
        _showNotification(
          'Failed to send message. Server returned an error.',
          isError: true,
        );
      }
    } catch (e) {
      // This handles network errors or other exceptions
      debugPrint('Network or other exception: $e');
      _showNotification(
        'Failed to send message. Please check your network connection.',
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _showNotification(String message, {bool isError = false}) {
    if (!mounted) return;

    final notification = isError
        ? ElegantNotification.error(
            title: const Text('Error'),
            description: Text(message),
            animationDuration: const Duration(milliseconds: 600),
          )
        : ElegantNotification.success(
            title: const Text('Success'),
            description: Text(message),
            animationDuration: const Duration(milliseconds: 600),
          );

    notification.show(context);
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    bool isEmail = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : TextInputType.text,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your $label';
            }
            if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : const Color(0xFFF0F0F0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2.0,
              ),
            ),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade900.withOpacity(0.5)
                : const Color(0xFFF0F0F0),
          ),
        ),
      ],
    );
  }
}

class _HoverableButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const _HoverableButton({required this.onPressed, required this.child});

  @override
  _HoverableButtonState createState() => _HoverableButtonState();
}

class _HoverableButtonState extends State<_HoverableButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: Colors.white54,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        ),
        child: AnimatedScale(
          scale: _isHovering && widget.onPressed != null ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: widget.child,
        ),
      ),
    );
  }
}

class _HoverableOutlinedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;

  const _HoverableOutlinedButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  _HoverableOutlinedButtonState createState() =>
      _HoverableOutlinedButtonState();
}

class _HoverableOutlinedButtonState extends State<_HoverableOutlinedButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: OutlinedButton.icon(
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          side: const BorderSide(color: Color(0xFFD3D3D3)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          backgroundColor: _isHovering
              ? Colors.grey.withOpacity(0.1)
              : Colors.transparent,
        ),
        icon: AnimatedScale(
          scale: _isHovering ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: widget.icon,
        ),
        label: Text(widget.label),
      ),
    );
  }
}
