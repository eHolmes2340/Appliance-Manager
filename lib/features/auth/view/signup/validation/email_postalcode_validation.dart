//File: email_postalcode_validation.dart
//Programmer: Erik Holmes
//Date: Jan 17, 2025
//Description: This file contains the email and postal code validation functions for the signup screen.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/web.dart';



//Function validateEmailAddress
//Description: This function is used to validate the email address
validateEmailAddress(String email)
{
  //Check if the email is empty
  if(email.isEmpty)
  {
    return 'Email is required';
  }
  //Check if the email is valid
  else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email))
  {
    return 'Please enter a valid email address';
  }
  return null;
}


//Function validatePostalCode
//Description: This function is used to validate the postal code
//ex N0B 2T0,
validatePostalCode(String postalCode)
{
  //Check if the postal code is empty
  if(postalCode.isEmpty)
  {
    return 'Postal code is required';
  }
  //Check if the postal code is valid
  else if(!RegExp(r'^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$').hasMatch(postalCode))
  {
    return 'Please enter a valid postal code';
  }
  return null;
}

//Function   :createUser
//Description: This function is used to create a new user for our application. 
Future<User> createUser(String email,String password) async
{
 UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    User? user= userCredential.user;
  return Future.value(user);
}

//Function sendEmailVerification
//Description: This function is used to send an email verification
Future<int> sendEmailVerificationFuc(String email,String password) async
{
 try
 {
   //Creater a new user. 
    User? user=await createUser(email,password);
    
    if(user!=null)
    {
      await user.sendEmailVerification(); 
      Logger().i('Email verification sent to ${user.email}');
      return 0; 
    }
 }
 catch (e){
 if (e is FirebaseAuthException) {
      // Detailed FirebaseAuth exception handling
      if (e.code == 'weak-password') {
        Logger().e('The password is too weak.');
        return -1; 
      } 
      else if (e.code == 'email-already-in-use') {
        Logger().e('The email address is already in use.');
        return -2; 
      }
       else if (e.code == 'invalid-email') {
        Logger().e('The email address is invalid.');
        return -3; 
      } 
      else {
        Logger().e('Error: ${e.message}');
        return -4; 
      }
    } 
    else {
      Logger().e('Unknown error: $e');
      return -5; 
    } 
 }
 return 0; 
}