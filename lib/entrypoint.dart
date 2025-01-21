//File       : entrypoint.dart
//Programmer : Erik Holmes
//Last Edited: January 20, 2024
//Description: This file contains the entry point for the application. This is where the app is initialized and the first screen is displayed.

import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:flutter/material.dart';
import 'features/auth/view/signup/signup_screen.dart'; 

class Entrypoint extends StatelessWidget{
  const Entrypoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
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

//Class: entryPageState
//Description: This class will 
class EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Login button pressed
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
    );
  }
}