import 'dart:convert';

import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance_selected_dialog_boxes/editApplianceDialogBox.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance_selected_dialog_boxes/manuals/manualsSaved.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:flutter/material.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance_selected_dialog_boxes/editApplianceDialogBox.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance_selected_dialog_boxes/editApplianceDialogBox.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';


void viewApplianceDialogAppliance(Appliance appliance, BuildContext context, Future<void> Function(int) reloadList, String email) {
  reloadList(appliance.userId);
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(appliance.applianceName, style: TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Appliance Image
                Image.network(
                  appliance.appilanceImageURL,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image, size: 100, color: Colors.grey);
                  },
                ),
                SizedBox(height: 10),
                Text("Type: ${appliance.applianceType}"),
                Text("Brand: ${appliance.brand}"),
                Text("Model: ${appliance.model}"),
                Text("Warranty Expiry: ${appliance.warrantyExpirationDate ?? 'N/A'}"),
                SizedBox(height: 10),

                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    // Close the current dialog and open the ManualSavedWebView

                    if(appliance.manualURL == null || appliance.manualURL == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No manual URL available.')),
                      );
                      return;
                    }
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManualSavedWebView(appliance: appliance),
                      ),
                    );
                  }, 
                  child: Text("View Appliance Manual"),
                ),
             
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
              TextButton(
                onPressed: () async {
                  // Show the edit dialog
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return showEditApplianceDialog(context, appliance,email, reloadList);
                    },
                  );
                  // Reopen the updated view dialog with the updated appliance data
                  Navigator.pop(context);
                  viewApplianceDialogAppliance(appliance, context, reloadList,email);
                }, 
                child: Text("Edit Appliance"),
              ),
            ],
          );
        },
      );
    },
  );
}





//