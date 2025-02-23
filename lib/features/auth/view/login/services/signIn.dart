
import 'package:firebase_auth/firebase_auth.dart';

//Function    : sign_in
//Description: This function will allow the user to sign in to the application.
sign_in(FirebaseAuth auth,String email, String password)async
{
  
  //Check if the email and password are empty
  if(email.isEmpty || password.isEmpty)
  {
    return false;
  }

  try{
    if(await auth.signInWithEmailAndPassword(email: email, password: password)==null)
    {
      return false;
    }
    else{
      return true;
    }
   
  }
  catch(e)
  {
    return false;
  }
}