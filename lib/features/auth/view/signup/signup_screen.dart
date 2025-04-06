//File       : signup_screen.dart
//Programmer : Erik Holmes
//Last Edited: January 20, 2024
//Description: This file contains the code for the sign up screen. This includes email and password validation, as well as checking if the email is already in use.
import 'package:appliance_manager/features/auth/services/send_userinformation_to_Api.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import '../../model/user_information.dart';
import 'validation/password_validation.dart';
import 'validation/email_postalcode_validation.dart';
import '../signup/widgets/alert_user_about_validation.dart';
import 'widgets/alert_user_Firebase_error.dart'; 


//Class      : SignupScreen
//Description: This class is a stateful widget that displays the sign up screen
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedCountry = 'Country';
  String passwordErrorMessage = '';
  String confirmPasswordErrorMessage = '';
  bool isLoading = false; // Add a loading state

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

  final InputDecoration errorInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
  );

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
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
                        decoration: inputDecoration.copyWith(labelText: 'Enter your first name (required)'),
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
                        decoration: inputDecoration.copyWith(labelText: 'Enter your last name (required)'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          return validateEmailAddress(value!);
                        },
                        decoration: inputDecoration.copyWith(labelText: 'Enter your email (required)'),
                      ),
                    ),
                    if (passwordErrorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          passwordErrorMessage,
                          style: TextStyle(color: Colors.red),
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
                        decoration: passwordErrorMessage.isEmpty
                            ? inputDecoration.copyWith(labelText: 'Enter your password (required)')
                            : errorInputDecoration.copyWith(labelText: 'Enter your password (required)'),
                      ),
                    ),
                    if (confirmPasswordErrorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          confirmPasswordErrorMessage,
                          style: TextStyle(color: Colors.red),
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
                        decoration: confirmPasswordErrorMessage.isEmpty
                            ? inputDecoration.copyWith(labelText: 'Confirm your password (required)')
                            : errorInputDecoration.copyWith(labelText: 'Confirm your password (required)'),
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
                          setState(() {
                            selectedCountry = newValue!;
                          });
                        },
                        decoration: inputDecoration.copyWith(labelText: 'Country (required)'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: postalCodeController,
                        validator: (value) {
                          return validatePostalCode(value!);
                        },
                        decoration: inputDecoration.copyWith(labelText: 'Enter your postal code (required)'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        setState(() {
                          passwordErrorMessage = '';
                          confirmPasswordErrorMessage = '';
                          isLoading = true; // Show loading indicator
                        });
                          //Check if the password and confirm password match 
                        if (formKey.currentState!.validate()) {
                          if (passwordController.text != confirmPasswordController.text) {
                            setState(() {
                              confirmPasswordErrorMessage = 'Passwords do not match';
                            });
                            return;
                          }

                          // Validate the password length
                          if (validatePasswordLength(passwordController.text) == -1) {
                            setState(() {
                              passwordErrorMessage = 'Password must be at least 8 characters';
                            });
                            return;
                          }
                            // Validate the password for special characters
                          if (validatePasswordForSpecialCharacters(passwordController.text) == -1) {
                            setState(() {
                              passwordErrorMessage = 'Password must contain at least one uppercase letter and one special character';
                            });
                            return;
                          }
                          // Assign the user information to the user information object
                          UserInformation userInfo = UserInformation(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            postalCode: postalCodeController.text,
                            country: selectedCountry,
                            freeAccount: true, //This is a free account 
                            accountVerified: false, //The account is not verified yet
                          );

                        
                          // Proceed with further actions using userInfo
                        int validation=await sendEmailVerificationFuc(userInfo.email, passwordController.text);
                          if(validation!=-0) // return -1 <-> -5
                          {
                            validateFirebase(context, validation); 
                             setState(() {
                                isLoading = false; // Hide loading indicator
                              });// Show the error message from firebase
                            return; 
                          }
                          //Send to database
                          try{
                           
                            sendUserInformation(userInfo); //Sending the user data to 


                          }
                          catch(e)
                          {
                            Logger().e('Error sending data to the data base'); 
                          }
                          showVerfiyAlertBox(context,userInfo.email); 
                        }
                        setState(() {
                          isLoading = false; // Hide loading indicator
                        });
                      },
                      child: const Text('Create Account'), // After submitting go to the password recovery question screen
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(), // Loading indicator
            ),
        ],
      ),
    );
  }
}