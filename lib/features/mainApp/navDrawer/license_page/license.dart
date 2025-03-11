//File    : license.dart
//Programmer : Erik Holmes
//Date: Feb 19, 2025
//Description: This file will contain the license page for the application
import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:appliance_manager/features/mainApp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

//Class       :LicenseP
//Description : This class will create
//              the license page for the application
class LicenseP extends StatelessWidget
{
  final UserInformation userInfo;

  const LicenseP({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About App"),
      ),
      drawer: NavDrawer(userInfo: userInfo), // Add the drawer to the page
      body: Builder(
        builder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Author and version text
                const Text(
                  "Author: Erik Holmes\nVersion: 1.0",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                ),

                const SizedBox(height: 10), // Spacing between text and button

                ElevatedButton(
                  onPressed: () {
                    // When button is pressed, show license page
                    showLicensePage(context: context);
                  },
                  child: const Text("Show Licenses"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
