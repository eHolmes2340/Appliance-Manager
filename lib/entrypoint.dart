import 'package:applianceCare/common/theme.dart';
import 'package:applianceCare/features/auth/view/login/login.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'features/auth/view/signup/signup_screen.dart';

class Entrypoint extends StatelessWidget {
  const Entrypoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appliance Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1935C1)),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const EntryPage(
        title: 'Appliance Care',
      ),
    );
  }
}

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<EntryPage> createState() => EntryPageState();
}

class EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true, // For transparency effect
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/entrypoint.jpeg',
              fit: BoxFit.cover,
            ),
          ),

          // Blurred glassmorphism card
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/appicon/ApplianceManagerIcon.png',
                        height: 200,
                        width: 400,
                        fit: BoxFit.cover
                      ),
                      const SizedBox(height: 40),

                      Text("Welcome to Appliance Care", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: const Color.fromARGB(255, 247, 245, 245), fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Text("Manage your appliances with ease", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color.fromARGB(255, 246, 243, 243), fontSize: 16, fontWeight: FontWeight.normal)),
                      const SizedBox(height: 16),
                      // Divider
                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                        height: 20,
                      ),
                      

                      // Login Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  AppTheme.main_colour,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Login_Screen()),
                          );
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 16),

                      // Sign Up Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 64, 186, 64),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupScreen()),
                          );
                        },
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
