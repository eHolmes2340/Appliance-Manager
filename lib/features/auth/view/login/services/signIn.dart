
import 'package:firebase_auth/firebase_auth.dart';

//Function    : sign_in
//Description: This function will allow the user to sign in to the application.
sign_in(FirebaseAuth auth,String email, String password)async
{
  try{
    await auth.signInWithEmailAndPassword(email: email, password: password);
    return true;
  }
  catch(e)
  {
    return false;
  }
}