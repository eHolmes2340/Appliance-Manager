
import 'package:flutter/material.dart';
import 'package:appliance_manager/features/auth/view/login/login.dart';

Future<void> showVerfiyAlertBox(context,String email) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Verfication'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Account created'),
              Text('Email has been sent to $email for verification'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Login'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Login_Screen()));
            },
          ),
        ],
      );
    },
  );
}