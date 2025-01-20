import 'package:flutter/material.dart';

//Class SignupScreen
//Description: This class is a stateless widget that displays the sign up screen
class SignupScreen extends StatelessWidget{
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your email',
                ),
              ),
              
            ),
            ElevatedButton( 
              onPressed: (){
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
    );
  }
}