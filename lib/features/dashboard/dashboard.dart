//File       : dashboard.dart
//Programmer : Erik Holmes
//Date       : Feb 2, 2025 
//Description: This file will contain the dashboard for the appliance manager project

import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:flutter/material.dart';

//Class       :Dashboard
//Description : This will create a stateful wisget. 
class Dashboard extends StatelessWidget{

  final String validEmail;

  const Dashboard({super.key, required this.validEmail}); 

  @override
  Widget build(BuildContext context)
  {
    return PopScope
    (
      canPop: false,
      child: Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        automaticallyImplyLeading: false,
      ),
    )
    ); 
  }

}




//Dashboard screen steps 
// Need to retreive some data from the backend now.
// Sign information 
// Will need to see if the users email address was verfied. 
// Will need to add a hidden slider where the user can sign out of there account and see there virtual home appliances 

