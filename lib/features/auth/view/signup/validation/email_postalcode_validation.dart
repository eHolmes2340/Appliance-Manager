import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/web.dart';


var logger=Logger(); 
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

//Function sendEmailVerification
//Description: This function is used to send an email verification
Future<void> sendEmailVerification(String email,String password) async {
 
 try
 {
    UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    User? user= userCredential.user;
    
    if(user!=null)
    {
      await user.sendEmailVerification(); 
      logger.i('Email verification sent to ${user.email}');
    }
 }
 catch (e){
 if (e is FirebaseAuthException) {
      // Detailed FirebaseAuth exception handling
      if (e.code == 'weak-password') {
        logger.e('The password is too weak.');
      } 
      else if (e.code == 'email-already-in-use') {
        logger.i('The email address is already in use.');
      }
       else if (e.code == 'invalid-email') {
        logger.e('The email address is invalid.');
      } 
      else {
        logger.e('Error: ${e.message}');
      }
    } 
    else {
      logger.e('Unknown error: $e');
    } 
 }
 
}