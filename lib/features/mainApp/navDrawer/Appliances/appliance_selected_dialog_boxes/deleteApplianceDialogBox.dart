
import 'package:flutter/material.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/services/sub_menu/delete_appliance_information.dart';

//Function    : showDeleteConfirmationDialog
//Description : Displays a confirmation dialog before deleting an appliance.
void showDeleteConfirmationDialog(BuildContext context, Appliance appliance, Future<void> Function(int) reloadList) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete ${appliance.applianceName}?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancel
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close dialog
              //Delete URL from Firebase 
              await deleteImageFirebaseStorage(appliance.appilanceImageURL); //Found in the service/delete_appliance_information.dart file
              await deleteApplianceInformation(appliance); //Found in the service/delete_appliance_information.dart file
              reloadList(appliance.userId); // Refresh appliance list
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
