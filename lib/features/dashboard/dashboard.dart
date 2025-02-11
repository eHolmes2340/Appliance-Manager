//File       : dashboard.dart
//Programmer : Erik Holmes
//Date       : Feb 2, 2025 
//Description: This file will contain the dashboard for the appliance manager project

import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:flutter/material.dart';
import 'package:appliance_manager/services/get_userInformation.dart';
import 'widgets/add_appliance.dart'; 
import '../../common/theme.dart';

//Class       :Dashboard
//Description : This will create a stateful wisget. 
class Dashboard extends StatefulWidget {
  final String validEmail; //This will hold the user email address from the login screen.
  const Dashboard({super.key, required this.validEmail});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  UserInformation? userInfo;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    UserInformation? info = await retrieveUserProfile(widget.validEmail);
    setState(() {
      userInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isVisible = true;
    final bool isElevated = true;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          automaticallyImplyLeading: false, //Get rid of the back button
        ),
        body: userInfo == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Text('Welcome, ${userInfo!.firstName} ${userInfo!.lastName}'),
                  Text('${userInfo!.email}')
                  // ...additional widgets to display user information...
                ],
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.main_colour,
          onPressed: () {
            addApplianceDialog(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

//Dashboard screen steps 
// Need to retreive some data from the backend now.
// Sign information 
// Will need to see if the users email address was verfied. 
// Will need to add a hidden slider where the user can sign out of there account and see there virtual home appliances 




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