import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/api_repo.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final sheetTop = 210.0; // where the rounded sheet starts

    return Scaffold(
      backgroundColor: primary, // so gaps show primary behind
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Stack(
        children: [
          // 1) Purple header content
          // _Header(primary: primary),
          Container(
            color: primary,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // const SizedBox(height: 12),
                  const Text(
                    'Support',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'if you are a professional or a service provider and would like to join our network, write to us at support@kaamwalibais.com.',
                    style: TextStyle(color: Colors.white, height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  InkWell(
                    onTap: () => launchUrl(Uri.parse('tel:+918767078888')),
                    child: Row(
                      children: [
                        const Text(
                          'Call Us - +91 8767078888',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.call, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2) Rounded sheet with the form
          Positioned.fill(
            top: sheetTop,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Enquiry title + tiny underline
                    Text(
                      'Enquiry Here',
                      style: TextStyle(
                        color: primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 110,
                      height: 3,
                      decoration: BoxDecoration(
                        color: primary.withOpacity(.45),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 18),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _field(_nameController, 'Enter Your Name'),
                          const SizedBox(height: 12),
                          _field(
                            _phoneController,
                            'Enter Mobile contact_phone',
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 12),
                          _field(
                            _emailController,
                            'Enter Your Email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 12),
                          _field(
                            _queryController,
                            'Enter Your Query',
                            maxLines: 4,
                          ),
                          const SizedBox(height: 20),

                          // Submit button (white pill as in screenshot)
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // TODO: submit to backend

                                  final data = await contactUsApi(
                                    _nameController.text,
                                    _phoneController.text,
                                    _emailController.text,
                                    _queryController.text,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Your request is summited please wait, out team will contact you soon!',
                                      ),
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Submit',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(Icons.arrow_forward_ios, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TextField builder matching the white rounded inputs in the screenshot
  Widget _field(
    TextEditingController c,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: c,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator:
          (v) => (v == null || v.trim().isEmpty) ? 'Please enter $hint' : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFDBEAFE),
          ), // light blue like screenshot
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFBFDBFE)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
