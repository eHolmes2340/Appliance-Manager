import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/recalls_page/model/recallClass.dart';
import 'package:flutter/material.dart';
import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/nav_drawer.dart';
import 'package:appliance_manager/services/get_userInformation.dart';
import 'services/dashboard_information.dart';

class Dashboard extends StatefulWidget {
  final String validEmail; // Holds the user email from the login screen.
  const Dashboard({super.key, required this.validEmail});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  UserInformation? userInfo;
  bool isLoadingUser = true;
  List<Appliance> applianceList = [];
  List<Recall> recallList = [];
  

  @override
  void initState() {
    super.initState();
    // Initialize the camera and load user information
    _loadUserInfo();
    _loadDashboardInfo();

  }

  //Function     : _loadDashboardInfo
  //Description  : This function will load the dashboard information from the database
  Future<void> _loadDashboardInfo() async {
    // Load user information from the database
    applianceList=await dashboardAppliance(userInfo?.id);
    recallList=await dashboardRecalls();
  }
  
  

  //Function      : _loadUserInfo
  //Description   : This function will load the user information from the database
  Future<void> _loadUserInfo() async {
    try {
      userInfo = await retrieveUserProfile(widget.validEmail);
      debugPrint("User info loaded: $userInfo");
    } 
    catch (e) {
      debugPrint("Error fetching user info: $e");
    }

    setState(() {
      isLoadingUser = false;
    });

    if (userInfo == null) {
      _showErrorDialog();
    }
  }

  // Displays an error dialog if user info is null
  void _showErrorDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error Code: 404'),
            content: const Text('Servers are currently down'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Return to previous screen
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
    drawer: userInfo != null ? NavDrawer(userInfo: userInfo!) : null,
     
    );
  }
}
