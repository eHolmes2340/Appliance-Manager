//File      : entrypoint.dart
//Programmer: Erik Holmes
//Date      : January 25, 2025
//Description: This file contains the login screen.



import 'package:appliance_manager/features/auth/view/login/services/signIn.dart';
import 'package:flutter/material.dart';
import '../signup/signup_screen.dart'; 
import 'services/forgot_password_alerbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

//Class   : Login_Screen
//Description: This class contains the stateless widget that will be the login page for the application.
class Login_Screen extends StatelessWidget{
  const Login_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // Dispose controllers to avoid memory leaks
    void disposeControllers() {
      emailController.dispose();
      passwordController.dispose();
      
    }

    return WillPopScope(
      onWillPop: () async {
        disposeControllers();
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
                  controller: emailController,
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
                  controller: passwordController,
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
                onPressed: () async {
                  // Login firebase 
                  FirebaseAuth auth = FirebaseAuth.instance; 
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();

                  try {
                    bool signInResult = await sign_in(auth, email, password);
                    if (!signInResult) {
                      // Show error dialog if sign-in fails

                      Logger().e("Invalid email or password"); 
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text("Invalid email or password"),
                            actions: [
                              TextButton(
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
                    else //Send to dashboard 
                    {
                      //Check and see if the 
                    }
                  } 
                  catch (e) {
                    // Handle error
                    Logger().e(e.toString());
            
                  }
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