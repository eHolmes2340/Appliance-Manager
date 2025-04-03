  import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
  import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/widgets/viewApplianceInfoDialog.dart';
  import 'package:appliance_manager/features/mainApp/navDrawer/recalls_page/model/recallClass.dart';
  import 'package:appliance_manager/features/mainApp/navDrawer/recalls_page/widgets/recallDetailDialog.dart';

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

//Class: DashboardState
//Description: This class will create the state for the dashboard widget
class DashboardState extends State<Dashboard> 
{
  UserInformation? userInfo;
  bool isLoadingUser = true;
  List<Appliance> applianceList = [];
  List<Recall> recallList = [];

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
    }

    //Notification
    //ksetupFirebaseMessaging(); 

    setState(() {}); // Refresh UI after loading
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
      appBar: AppBar(title: const Text('Dashboard'),
      actions: [
        IconButton(icon: const Icon(Icons.notifications),
        onPressed: (){

        },)
      ],),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Section: Recalled Products
                           
                  const Text(
                    "Recently Recalled Products",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  recallList.isEmpty
                      ? const Text("No recalled products found.")
                      : Expanded( // Wrap the list in Expanded so it takes only the necessary space
                          child: ListView.builder(
                            itemCount: recallList.length, // Show all recalls
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(recallList[index].product_name),
                                  subtitle: Text("Tap to view details"),
                                  trailing: const Icon(Icons.info_outline),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  applianceList.isEmpty
                      ? const Text("No appliances found.")
                      : Expanded(
                          child: ListView.builder(
                            itemCount: applianceList.length,
                            itemBuilder: (context, index) {
                              return Card(
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
                                  onTap: (){
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
