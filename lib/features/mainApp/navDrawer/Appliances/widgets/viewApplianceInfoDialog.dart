//File        : viewApplianceInfoDialog.dart
//Programmer  : Erik Holmes
//Date        : January 20, 2024
//Description: This file contains the function to show the appliance details dialog when an appliance is clicked.

import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:flutter/material.dart';

// Function: viewApplianceDialog
// Description: This function shows a dialog with appliance details when an appliance is clicked.
void viewApplianceDialog(Appliance appliance, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(appliance.applianceName, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Appliance Image
           Image.network(
              appliance.appilanceImageURL, // Your Firebase Storage URL
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator()); // Show loading indicator
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 100, color: Colors.grey); // Show error icon if URL is invalid
              },
            ),
            SizedBox(height: 10),
            
            // Appliance Details
            Text("Type: ${appliance.applianceType}"),
            Text("Brand: ${appliance.brand}"),
            Text("Model: ${appliance.model}"),
            Text("Warranty Expiry: ${appliance.warrantyExpirationDate ?? 'N/A'}"),

            SizedBox(height: 15),

            // View Manual Button (if available)

          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}