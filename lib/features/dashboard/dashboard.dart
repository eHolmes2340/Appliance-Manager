//File       : dashboard.dart
//Programmer : Erik Holmes
//Date       : Feb 2, 2025 
//Description: This file will contain the dashboard for the appliance manager project

import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:appliance_manager/features/dashboard/model/appliance_information.dart';
import 'package:flutter/material.dart';
import 'package:appliance_manager/services/get_userInformation.dart';
import 'widgets/add_appliance.dart'; 
import '../../common/theme.dart';
import 'services/get_appliance_information.dart';

//Class       :Dashboard
//Description : This will create a stateful wisget. 
class Dashboard extends StatefulWidget {
  final String validEmail; //This will hold the user email address from the login screen.
  const Dashboard({super.key, required this.validEmail});

  @override
  _DashboardState createState() => _DashboardState();
}
//Class       :_DashboardState
//Description : This class will create the state for the dashboard widget
class _DashboardState extends State<Dashboard> {
  
  UserInformation? userInfo;
  List<Appliance> appliances = [];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }
  
  //Function  :_loadUserInfo
  //Description : This function will load the user information from the backend
  Future<void> _loadUserInfo() async {
  UserInformation? info = await retrieveUserProfile(widget.validEmail);
  setState(() {
    userInfo = info;
  });

  if (userInfo == null) {
    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error Code: 404'),
          content: Text('Servers are currently down'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog first
                Navigator.of(context).pop(); 

                // Go back to the previous screen
                Navigator.of(context).pop(); // This pops the current screen (Dashboard)
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    if (userInfo?.id != null) {
      _loadAppliances(userInfo!.id!);
    }
  }
  
}

  //Function  :_loadAppliances
  //Description : This function will load the appliances information from the backend
  Future<void> _loadAppliances(int userId) async {
    List<Appliance> applianceList = await getApplianceInformation(userId);
    setState(() {
      appliances = applianceList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          automaticallyImplyLeading: false, //Get rid of the back button
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              
            ],
          )

        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (appliances.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: appliances.length,
                    itemBuilder: (context, index) {
                     return InkWell(
                      onTap: () {
                        // Handle the tap event here
                        print('Tapped on ${appliances[index].applianceName}');
                        // You can navigate to another screen or perform any action you need
                      },
                      child: ListTile(
                        title: Text(appliances[index].applianceName),
                        subtitle: Text(appliances[index].applianceType),
                      ),
                     );
                    },
                  ),
                )
              else
                Text('No appliances found'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.main_colour,
          onPressed: () {
            //This is a dialog box 
            addApplianceDialog(context,userInfo!.id); //Found in the add_appliance.dart file
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

//Register New Appliance:Done 
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