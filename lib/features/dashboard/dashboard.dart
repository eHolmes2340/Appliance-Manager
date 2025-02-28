//File       : dashboard.dart
//Programmer : Erik Holmes
//Date       : Feb 2, 2025 
//Description: This file will contain the dashboard for the appliance manager project

  import 'package:appliance_manager/features/auth/model/user_information.dart';
  import 'package:appliance_manager/features/dashboard/model/appliance_information.dart';
  import 'package:appliance_manager/features/dashboard/services/sub_menu/delete_appliance_information.dart';
  import 'package:appliance_manager/features/dashboard/widgets/appliance_selected_menu.dart';
  import 'package:appliance_manager/features/dashboard/widgets/nav_drawer.dart';
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
    DashboardState createState() => DashboardState();
  }
  //Class       :_DashboardState
  //Description : This class will create the state for the dashboard widget
  class DashboardState extends State<Dashboard> {
    @override
    void initState() {
      super.initState();
      _loadUserInfo();
    }

     //Function  :_reloadApplianceList
    //Description : This function will load the appliances information from the backend
    Future<void> _reloadApplianceList(int userId) async {
      List<Appliance> applianceList = await getApplianceInformation(userId);
      
      // Limit the appliance list to the first 5 items
      setState(() {
        appliances = applianceList.take(5).toList(); // Only take the first 5 appliances
      });
    }


    
    //Function  :deleteAppliance
    //Description : This function will delete the appliance from the list
    Future<void> deleteAppliance(Appliance appliance) async {
      try {
        bool isDeleted = await deleteApplianceInformation(appliance);
        if (isDeleted) {
          setState(() {
            appliances.removeWhere((item) => item.applianceName == appliance.applianceName);
          });
          ScaffoldMessenger.of(context).showSnackBar
          (
            SnackBar(content: Text('${appliance.applianceName} has been deleted')),
          );
        } 
        else
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete the appliance')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting appliance: $e')),
        );
      }
    }

    UserInformation? userInfo;
    List<Appliance> appliances = [];

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
        _reloadApplianceList(userInfo!.id!);
      }
    }
    
  }

    //Function  :_addApplianceToList
    //Description : This function will add a new appliance to the list without refreshing the whole page
    void _addApplianceToList(Appliance appliance) {
      setState(() {
        appliances.add(appliance);
      });
    }

    @override
Widget build(BuildContext context) {
  return PopScope(
    canPop: false,
    child: Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        automaticallyImplyLeading: false, // Removes the back button
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu), // Menu icon to open drawer
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer manually
            },
          ),
        ),
      ),
      drawer: userInfo != null ? NavDrawer(userInfo: userInfo!) : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (appliances.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: appliances.length, // This will only count up to 5 appliances
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTapDown: (TapDownDetails details) {
                        appliance_selected_menu(context, details.globalPosition, appliances[index], _reloadApplianceList); //found in the widgets/appliance_selected_menu.dart
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
          if (userInfo != null && userInfo!.id != null) {
            addApplianceDialog(context, userInfo!.id!, _addApplianceToList);
          } 
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