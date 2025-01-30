//File      : entrypoint.dart
//Programmer: Erik Holmes
//Date      : January 25, 2025
//Description: This file contains the login screen.



import 'package:flutter/material.dart';
import '../signup/signup_screen.dart'; 
import 'services/forgot_password_alerbox.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Class   : Login_Screen
//Description: This class contains the stateless widget that will be the login page for the application.
class Login_Screen extends StatelessWidget{
  const Login_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Login Screen'),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: (){
                    showForgotPasswordDialog(context); // Call the function directly
                  },
                  child: const Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the signup screen
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ),
                  // );
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the signup screen
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
    );
  }
}