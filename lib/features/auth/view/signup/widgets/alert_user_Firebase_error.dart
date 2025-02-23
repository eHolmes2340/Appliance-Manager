
import 'package:flutter/material.dart';

void showSignUpAlertError(BuildContext context, String errorMessage) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Firebase Authentication Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(errorMessage),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}

//Function validateFirebase 
//Description: This function is used to validate the firebase authentication
void validateFirebase(BuildContext context, var validation)
{
  if(validation==-1)
   {
      showSignUpAlertError(context,'The password is too weak.'); 
      return; 
    }
    else if(validation==-2)
    {
      showSignUpAlertError(context,'The email is already in use.'); 
      return; 
    }
    else if(validation==-3)
    {
      showSignUpAlertError(context,'An error occured while sending the email verification.'); 
      return; 
    }
    else if(validation==-4)
    {
     showSignUpAlertError(context,'An error occured while sending the email verification.'); 
     return; 
    }
    else if(validation==-5)
    {
      showSignUpAlertError(context,'An unknown error occured while sending the email verification.'); 
      return; 
    }
}
