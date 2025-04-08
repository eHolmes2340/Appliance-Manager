import 'package:applianceCare/common/theme.dart';
import 'package:applianceCare/entrypoint.dart';
import 'package:applianceCare/features/auth/model/user_information.dart';
import 'package:applianceCare/features/mainApp/dashboard/dashboard.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance.dart';
import 'package:applianceCare/features/mainApp/navDrawer/license_page/license.dart';

import 'package:applianceCare/features/mainApp/navDrawer/recalls_page/recall.dart';
import 'package:applianceCare/features/mainApp/navDrawer/settings/settings.dart';
import 'package:flutter/material.dart';
import '../notifications/notification.dart';

class NavDrawer extends StatelessWidget {
  final UserInformation userInfo;

  const NavDrawer({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header with Text and Background Color
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appliance Care',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 3, 3, 3),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userInfo.firstName + ' ' + userInfo.lastName,  // Display user's name
                  style: TextStyle(
                    color: const Color.fromARGB(255, 22, 18, 18),
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  userInfo.email,  // Display user's email
                  style: TextStyle(
                    color: const Color.fromARGB(179, 9, 8, 8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: AppTheme.main_colour, // Use your main color for the header
            ),
          ),

          

          // ListTile for Dashboard
          _buildDrawerItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard(validEmail: userInfo.email)),
              );
            },
          ),


           // ListTile for Appliances
          _buildDrawerItem(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            },
          ),


          // ListTile for Appliances
          _buildDrawerItem(
            icon: Icons.local_laundry_service,
            title: 'Appliances',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Appliances(validEmail: userInfo.email)),
              );
            },
          ),

          // ListTile for Recalled Items
          _buildDrawerItem(
            icon: Icons.warning,
            title: 'Recalled Item',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecallPage()),
              );
            },
          ),

          // ListTile for About
          _buildDrawerItem(
            icon: Icons.info,
            title: 'About',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LicenseP(userInfo: userInfo)),
              );
            },
          ),


          // ListTile for Profile
          _buildDrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
             
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage(userInfo: userInfo)),
              );
            },
          ),


          // Logout Button with Confirmation Dialog
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildDrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build drawer items
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required void Function() onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppTheme.main_colour.withOpacity(0.1),
        child: Icon(
          icon,
          color: const Color.fromARGB(255, 9, 12, 10),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: const Color.fromARGB(255, 7, 8, 7),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  // Show Logout Confirmation Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Entrypoint()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
