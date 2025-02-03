//File       : entrypoint.dart
//Programmer : Erik Holmes
//Last Edited: January 20, 2024
//Description: This file contains the entry point for the application. This is where the app is initialized and the first screen is displayed.

import 'package:appliance_manager/features/auth/view/login/login.dart';
import 'package:flutter/material.dart';
import 'features/auth/view/signup/signup_screen.dart'; 


//Class   : Entrypoint
//Description: This class contains the stateless widget that will be the entry point for the application 
class Entrypoint extends StatelessWidget{
  const Entrypoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Appliance Manager', 
      theme:ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color.fromARGB(255, 25, 53, 193)),
        useMaterial3: true,
      ),
      home: const EntryPage(title: 'Appliance Manager'),
    );
  }
}

//Class   : entryPage
//Description: This class will display the
class EntryPage extends StatefulWidget{
  const EntryPage({Key? key, required this.title}) : super(key: key);
  final String title;
  //UserInformation userInfo;  
  @override
  State<EntryPage> createState() => EntryPageState();
}

//Class      : entryPageState
//Description: This class will contain the buttons used 
class EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/entrypoint.jpeg', // Corrected path
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Login button pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login_Screen()),
                    );
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Sign up button pressed 
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
        ],
      ),
    );
  }
}