//File  : forgot_password_alerbox.dart
//Programmer: Erik Holmes
//Date      : January 30, 2025
//Description: This file contains the alert dialog for the forgot password feature.

//create an alert dialog for forgot password
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


//Class   : ForgotPasswordAlertBox
//Description: This class contains the stateless widget that will be the alert dialog for the forgot password.
class ForgotPasswordAlertBox extends StatefulWidget {
  const ForgotPasswordAlertBox({Key? key}) : super(key: key);

  @override
  _ForgotPasswordAlertBoxState createState() => _ForgotPasswordAlertBoxState();
}

class _ForgotPasswordAlertBoxState extends State<ForgotPasswordAlertBox> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Forgot Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Enter your email to reset your password'),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
              controller: _emailController,
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
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            FirebaseAuth auth = FirebaseAuth.instance;
            auth.sendPasswordResetEmail(email: _emailController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

//Function   : showForgotPasswordDialog
//Description: This function will show the forgot password dialog.
void showForgotPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const ForgotPasswordAlertBox();
    },
  );
}
