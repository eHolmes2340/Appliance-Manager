import 'package:applianceCare/common/obj/server_address.dart';
import 'package:applianceCare/common/theme.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:applianceCare/features/mainApp/dashboard/widgets/viewApplianceInfoDialog.dart';
import 'package:applianceCare/features/mainApp/navDrawer/recalls_page/model/recallClass.dart';
import 'package:applianceCare/features/mainApp/navDrawer/recalls_page/widgets/recallDetailDialog.dart';
import 'package:applianceCare/features/mainApp/notifications/model/notificationsService.dart';
import 'package:applianceCare/features/mainApp/notifications/services/notificationTab.dart';

import 'package:flutter/material.dart';
import 'package:applianceCare/features/auth/model/user_information.dart';
import 'package:applianceCare/features/mainApp/navDrawer/nav_drawer.dart';
import 'package:applianceCare/features/auth/services/get_userInformation.dart';
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
  List<NotificationItem> notificationsList = [];

  @override
  void initState() {
    super.initState();
    _loadDashboardInfo();
  }

  // Function to load all dashboard info
  Future<void> _loadDashboardInfo() async {
    setState(() {
      isLoadingUser = true; // Show loading indicator
    });
    await _loadUserInfo(); // Get user info

    if (userInfo != null) {
      applianceList = await dashboardAppliance(userInfo!.id);
      recallList = await dashboardRecalls();
      await _loadNotifications(); // Load notifications
    }

    setState(() {}); // Refresh UI after loading
  }

  Future<void> _loadNotifications() async {
    if (userInfo == null) return; // Ensure userInfo is loaded

    try {
      List<NotificationItem> fetchedNotifications = await fetchNotifications(userInfo!.id, ServerAddress.getRecallNotifications);
      setState(() {
        notificationsList = fetchedNotifications;
      });
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
    }
  }

  // Function to load user info
  Future<void> _loadUserInfo() async {
    try {
      userInfo = await retrieveUserProfile(widget.validEmail);
      debugPrint("User info loaded: $userInfo");

      if (userInfo == null) {
        debugPrint("User info is null");
      } else {
        debugPrint("User ID: ${userInfo!.id}");
      }
    } catch (e) {
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
            title: const Text('Error Code: 500'),
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
      appBar: AppBar(
       
        backgroundColor:AppTheme.main_colour, // Modern, customizable color
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon tap
              showNotificationsPopup(context);
            },
          ),
        ],
      ),
      drawer: userInfo != null ? NavDrawer(userInfo: userInfo!) : null,
      body: isLoadingUser
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87), // Clean and modern
                  ),
                  const SizedBox(height: 16),

                  // Section: Recalled Products
                  const Text(
                    "Recently Recalled Products",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87), // Modern section header
                  ),
                  const SizedBox(height: 8),

                  recallList.isEmpty
                      ? const Text("No recalled products found.")
                      : Expanded(
                          child: ListView.builder(
                            itemCount: recallList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 4,
                                color: Colors.grey.shade100, // Light modern card color
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  title: Text(recallList[index].product_name),
                                  subtitle: const Text("Tap to view details"),
                                  trailing: const Icon(Icons.info_outline, color:AppTheme.main_colour),
                                  onTap: () {
                                    showRecallDetailsDialog(recallList[index], context);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 20),

                  // Section: Appliances
                  const Text(
                    "Your Appliances",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87), // Modern section header
                  ),
                  const SizedBox(height: 8),
                  applianceList.isEmpty
                      ? const Text("No appliances found.")
                      : Expanded(
                          child: ListView.builder(
                            itemCount: applianceList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 4,
                                color: Colors.grey.shade100, // Light modern card color
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  title: Text(applianceList[index].applianceName),
                                  subtitle: Text("Brand: ${applianceList[index].brand}"),
                                  trailing: applianceList[index].appilanceImageURL != null && applianceList[index].appilanceImageURL.isNotEmpty
                                      ? Image.network(
                                          applianceList[index].appilanceImageURL,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                                        )
                                      : null, // No widget if imageUrl is null
                                  onTap: () {
                                    viewApplianceDialog(applianceList[index], context);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
