//File       : dashboard.dart
//Programmer : Erik Holmes
//Date       : Feb 2, 2025 
//Description: This file will contain the dashboard for the appliance manager project

import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:flutter/material.dart';

//Class       :Dashboard
//Description : This will create a stateful wisget. 
class Dashboard extends StatelessWidget{

<<<<<<< HEAD
  final String validEmail; //This will hold the user email address from the login screen. 
=======
  final String validEmail;

>>>>>>> 7f8b6b329b0fe385ca6b0a6f7c59e1a75b4e9f16
  const Dashboard({super.key, required this.validEmail}); 

  @override
  Widget build(BuildContext context)
  {
<<<<<<< HEAD
    final bool isVisible = true;
    final bool isElevated=true; 
=======
>>>>>>> 7f8b6b329b0fe385ca6b0a6f7c59e1a75b4e9f16
    return PopScope
    (
      canPop: false,
      child: Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
<<<<<<< HEAD
        automaticallyImplyLeading: false, //Get rid of the back button 
      ),
      )
    
    ); 
  }
}


void doSomething(bool value)
{

=======
        automaticallyImplyLeading: false,
      ),
    )
    ); 
  }
>>>>>>> 7f8b6b329b0fe385ca6b0a6f7c59e1a75b4e9f16

}




//Dashboard screen steps 
// Need to retreive some data from the backend now.
// Sign information 
// Will need to see if the users email address was verfied. 
// Will need to add a hidden slider where the user can sign out of there account and see there virtual home appliances 

<<<<<<< HEAD



//Appliance Recall Alerts 
// -- ListView
// -- Card + List title 
// -- Badge Alert Recalls 
// -- Nofitication Alert

//Register New Appliance
// -- Grid view : Display the appiance 
// -- card Each card will show an image an appliance, name and warranty information if any 
// -- Floating Action Button 
// -- Progress Indicator

// Warranty Receipt Storage Register Appliance 
// Expansion Tile : Show appliance warranty details 
// ImagePicker: 
// PDF Viewer: view the warranty receipt 

// Maintenance Reminders 

//Troubling shooting AI assitance 
// -- Text Field : Describe issue 
// -- Elevated Button : Start AI 
// Animated Container

//Parts and Repair Service Finder 
//-- Goole Maps API 
// List view : Display recommended repair services
// Button : Call or book services 

//User reviews and Rating for appliances 
// Yelp API. 
=======
>>>>>>> 7f8b6b329b0fe385ca6b0a6f7c59e1a75b4e9f16
