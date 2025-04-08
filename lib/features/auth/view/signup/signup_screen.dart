import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:applianceCare/common/theme.dart';
import 'package:applianceCare/features/auth/services/send_userinformation_to_Api.dart';
import '../../model/user_information.dart';
import 'validation/password_validation.dart';
import 'validation/email_postalcode_validation.dart';
import '../signup/widgets/alert_user_about_validation.dart';
import 'widgets/alert_user_Firebase_error.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final postalCodeController = TextEditingController();

  String selectedCountry = 'Country';
  String passwordError = '';
  String confirmPasswordError = '';
  bool isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, {bool isError = false}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: isError ? Colors.red : AppTheme.main_colour),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: isError ? Colors.red : AppTheme.main_colour, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Create Your Account'),
        backgroundColor: AppTheme.main_colour,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/entrypoint.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, // Align the form at the top
                    children: [
                      _buildTextField(
                        'Enter your first name (required)',
                        firstNameController,
                        (val) => val!.isEmpty ? 'Please enter your first name' : null,
                      ),
                      _buildTextField(
                        'Enter your last name (required)',
                        lastNameController,
                        (val) => val!.isEmpty ? 'Please enter your last name' : null,
                      ),
                      _buildTextField(
                        'Enter your email (required)',
                        emailController,
                        (val) => validateEmailAddress(val!),
                      ),
                      if (passwordError.isNotEmpty) _buildErrorText(passwordError),
                      _buildTextField(
                        'Enter your password (required)',
                        passwordController,
                        (val) => val!.isEmpty ? 'Please enter your password' : null,
                        obscure: true,
                        isError: passwordError.isNotEmpty,
                      ),
                      if (confirmPasswordError.isNotEmpty) _buildErrorText(confirmPasswordError),
                      _buildTextField(
                        'Confirm your password (required)',
                        confirmPasswordController,
                        (val) => val!.isEmpty ? 'Please confirm your password' : null,
                        obscure: true,
                        isError: confirmPasswordError.isNotEmpty,
                      ),
                      const SizedBox(height: 8),
                      // Country field inside the box with proper error handling
                      _buildDropdownField(),
                      const SizedBox(height: 16),
                      _buildTextField(
                        'Enter your postal code (required)',
                        postalCodeController,
                        (val) => validatePostalCode(val!),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _onSignUpPressed,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.main_colour,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  // Dropdown for country
  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedCountry == 'Country' ? null : selectedCountry, // Use null for default
        validator: (val) => val == null || val == 'Country' ? 'Please select a country' : null,
        onChanged: (val) => setState(() => selectedCountry = val!),
        items: const ['Country', 'Canada', 'USA']
            .map((country) => DropdownMenuItem(value: country, child: Text(country)))
            .toList(),
        hint: const Text('Country (required)', style: TextStyle(color: Colors.black)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12), // Optional padding
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.main_colour),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.main_colour, width: 1.5),
          ),
        ),
      ),
    );
  }

  // TextField with error handling
  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String? Function(String?) validator, {
    bool obscure = false,
    bool isError = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscure,
        decoration: _inputDecoration(label, isError: isError),
      ),
    );
  }

  // Error message for invalid input
  Widget _buildErrorText(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Text(message, style: const TextStyle(color: Colors.red)),
    );
  }

  // Sign up logic
  Future<void> _onSignUpPressed() async {
    setState(() {
      passwordError = '';
      confirmPasswordError = '';
      isLoading = true;
    });

    if (!formKey.currentState!.validate()) {
      setState(() => isLoading = false);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        confirmPasswordError = 'Passwords do not match';
        isLoading = false;
      });
      return;
    }

    if (validatePasswordLength(passwordController.text) == -1) {
      setState(() {
        passwordError = 'Password must be at least 8 characters';
        isLoading = false;
      });
      return;
    }

    if (validatePasswordForSpecialCharacters(passwordController.text) == -1) {
      setState(() {
        passwordError = 'Password must contain an uppercase letter and a special character';
        isLoading = false;
      });
      return;
    }

    final userInfo = UserInformation(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      postalCode: postalCodeController.text,
      country: selectedCountry,
      freeAccount: true,
      accountVerified: false,
    );

    final validation = await sendEmailVerificationFuc(userInfo.email, passwordController.text);

    if (validation != -0) {
      validateFirebase(context, validation);
      setState(() => isLoading = false);
      return;
    }

    try {
      sendUserInformation(userInfo);
    } catch (e) {
      Logger().e('Error sending data to the database: $e');
    }

   showVerfiyAlertBox(context, userInfo.email);
    setState(() => isLoading = false);
  }
}
