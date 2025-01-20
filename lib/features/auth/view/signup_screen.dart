//File       : signup_screen.dart
//Programmer : Erik Holmes
//Last Edited: January 20, 2024
//Description: This file contains the code for the sign up screen. This includes email and password validation, as well as checking if the email is already in use.
import 'package:flutter/material.dart';

//Class      : SignupScreen
//Description: This class is a stateless widget that displays the sign up screen
class SignupScreen extends StatelessWidget{
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _selectedCountry = 'Canada';

    final InputDecoration inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Sign up'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration.copyWith(labelText: 'Enter your first name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration.copyWith(labelText: 'Enter your last name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Country',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedCountry,
                      items: <String>['Canada', 'USA'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        _selectedCountry = newValue!;
                      },
                      decoration: inputDecoration,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration.copyWith(labelText: 'Enter your postal code'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration.copyWith(labelText: 'Enter your email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: inputDecoration.copyWith(labelText: 'Enter your password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: inputDecoration.copyWith(labelText: 'Confirm your password'),
                ),
              ),
              ElevatedButton( 
                onPressed: (){
                  if (passwordController.text != confirmPasswordController.text) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')),
                    );
                    return;
                  }
                  //Check and see if the email is valid 
                  //Check and see if the email is already used
                  //Validate password 
                  //
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}