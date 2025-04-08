//File       : Appliance.dart
//Programmer : Erik Holmes
//Date       : Feb 2, 2025 
//Description: This file will contain the dashboard for the appliance manager project


//File       : Appliance.dart
//Programmer : Erik Holmes
//Date       : Feb 2, 2025 
//Description: This file will contain the dashboard for the appliance manager project

import 'package:applianceCare/features/auth/model/user_information.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/services/sub_menu/delete_appliance_information.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/widgets/appliance_selected_menu.dart';
import 'package:applianceCare/features/mainApp/navDrawer/nav_drawer.dart';
import 'package:applianceCare/features/mainApp/notifications/services/notificationTab.dart';
import 'package:flutter/material.dart';
import 'package:applianceCare/features/auth/services/get_userInformation.dart';
import 'widgets/add_appliance.dart'; 
import '../../../../common/theme.dart';
import 'services/get_appliance_information.dart';

//Class       : Appliances
//Description : This will create a stateful widget. 
class Appliances extends StatefulWidget {
  final String validEmail; //This will hold the user email address from the login screen.
  const Appliances({super.key, required this.validEmail});

  @override
  ApplianceState createState() => ApplianceState();
}

//Class       : ApplianceState
//Description : This class will create the state for the dashboard widget
class ApplianceState extends State<Appliances> {
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Function to delete the appliance from the list
  Future<void> deleteAppliance(Appliance appliance) async {
    try {
      bool isDeleted = await deleteApplianceInformation(appliance);
      if (isDeleted) {
        setState(() {
          appliances.removeWhere((item) => item.applianceName == appliance.applianceName);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${appliance.applianceName} has been deleted')),
        );
      } else {
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

  // Function to load the user information from the backend
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
                  Navigator.of(context).pop(); // This pops the current screen (Appliances)
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      if (userInfo?.id != null) {
        reloadApplianceList(userInfo!.id!);
      }
    }
  }

  // Function to add a new appliance to the list without refreshing the whole page
  void _addApplianceToList(Appliance appliance) {
    setState(() {
      appliances.add(appliance);
    });
  }

  Future<void> reloadApplianceList(int userId) async {
    List<Appliance> applianceList = await getApplianceInformation(userId);
    setState(() {
      appliances = applianceList; // Only take the first 5 appliances
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Appliances'),
          backgroundColor: AppTheme.main_colour,
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
                onPressed: () {
                  // Handle notification button press
                  showNotificationsPopup(context);
                },
            ),
          ],
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (appliances.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: appliances.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTapDown: (TapDownDetails details) {
                          appliance_selected_menu(
                            context,
                            details.globalPosition,
                            appliances[index],
                            reloadApplianceList,
                            userInfo?.postalCode,
                            userInfo!.email,
                          );
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            title: Text(
                            appliances[index].applianceName,
                            style: TextStyle(
                              fontSize: 18, // Adjust the font size as needed
                              fontWeight: FontWeight.bold, // You can customize the weight as well
                              color: Colors.black, // Color can be adjusted as needed
                            ),
                          ),

                            subtitle: Text(
                              appliances[index].applianceType,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            trailing: appliances[index].appilanceImageURL != null &&
                                    appliances[index].appilanceImageURL.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      appliances[index].appilanceImageURL,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                Center(child: Text('No appliances found')),
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
