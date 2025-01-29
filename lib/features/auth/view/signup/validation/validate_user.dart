import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:flutter/material.dart';

void showVerificationDialog(BuildContext context, UserInformation userInformation) {
  final TextEditingController verificationCodeController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Email Verification'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: verificationCodeController,
            decoration: InputDecoration(
              labelText: 'Enter verification code',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Verify'),
            onPressed: () {
              // Handle verification logic here
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}