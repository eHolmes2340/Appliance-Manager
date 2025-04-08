//File      : login.dart
//Programmer: Erik Holmes
//Date      : January 25, 2025
//Description: This file contains the login screen.

import 'dart:ui';
import 'package:applianceCare/common/theme.dart';
import 'package:applianceCare/features/auth/view/login/services/signIn.dart';
import 'package:applianceCare/features/mainApp/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import '../signup/signup_screen.dart';
import 'services/forgot_password_alerbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';



class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
   @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // 🔹 Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/entrypoint.jpeg',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Login Form with Glass Effect
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.25)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Login to Appliance Care",
                        style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 2, 2, 2),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 🔹 Email Input
                      TextField(
                        controller: emailController,
                        style: const TextStyle(color: Color.fromARGB(255, 21, 19, 19)),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Color.fromARGB(179, 15, 15, 15)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.main_colour),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 🔹 Password Input
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Color.fromARGB(255, 10, 9, 9)),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Color.fromARGB(179, 14, 12, 12)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.main_colour),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                     
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            showForgotPasswordDialog(context);
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      
                      ElevatedButton(
                        onPressed: () async {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();

                          try {
                            bool signInResult = await sign_in(auth, email, password);
                            if (!signInResult) {
                             //Logger().e("Invalid email or password");
                              showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: Colors.white.withOpacity(0.9),
                                  title: const Text(
                                    "Login Error",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  content: const Text(
                                    "Invalid email or password. Please try again.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  actionsPadding: const EdgeInsets.only(right: 12, bottom: 8),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.main_colour,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              },
                            );

                            } 
                            else {
                              Logger().i('Login successful');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(validEmail: email),
                                ),
                              );
                            }
                          } catch (e) {
                            Logger().e(e.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.main_colour,
                          foregroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 12),

                      // 🔹 Sign Up Button
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white70),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
