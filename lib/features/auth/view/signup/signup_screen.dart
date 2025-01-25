//File       : signup_screen.dart
//Programmer : Erik Holmes
//Last Edited: January 20, 2024
//Description: This file contains the code for the sign up screen. This includes email and password validation, as well as checking if the email is already in use.
import 'package:flutter/material.dart';
import '../../model/user_information.dart';

//Class      : SignupScreen
//Description: This class is a stateless widget that displays the sign up screen
class SignupScreen extends StatelessWidget{
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final TextEditingController postalCodeController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String selectedCountry = 'Country';

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
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  decoration: inputDecoration.copyWith(labelText: 'Enter your first name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  decoration: inputDecoration.copyWith(labelText: 'Enter your last name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: inputDecoration.copyWith(labelText: 'Enter your email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: inputDecoration.copyWith(labelText: 'Enter your password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: inputDecoration.copyWith(labelText: 'Confirm your password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  value: selectedCountry,
                  validator: (value) {
                    if (value == 'Country') {
                      return 'Please select a country';
                    }
                    return null;
                  },
                  items: <String>['Country', 'Canada', 'USA'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    selectedCountry = newValue!;
                  },
                  decoration: inputDecoration.copyWith(labelText: 'Country'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: postalCodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your postal code';
                    }
                    return null;
                  },
                  decoration: inputDecoration.copyWith(labelText: 'Enter your postal code'),
                ),
              ),
              ElevatedButton( 
                onPressed: (){
                  if(formKey.currentState!.validate()){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }

                  if (passwordController.text != confirmPasswordController.text) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')),
                    );
                    return;
                  }

                  // Assign the user information to the user information object
                  UserInformation userInfo = UserInformation(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    postalCode: postalCodeController.text,
                    country: selectedCountry,
                     // Assuming address is not collected in the form
                  );

                  //Send to the express.js server 
                 
                  // Proceed with further actions using userInfo
                },
                child: const Text('Submit'), //After submiting go to the password recovery question screen
              ),
            ],
          ),
        ),
      ),
    );
  }
}