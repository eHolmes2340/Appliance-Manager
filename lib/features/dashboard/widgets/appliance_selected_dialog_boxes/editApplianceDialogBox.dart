// ignore: file_names
//File    : editApplianceDialogBox.dart
//Programmer : Erik Holmes
//Date: Feb 19, 2025
//Description: This file will contain the dialog box to edit the oldApplianceInformation information
import 'package:appliance_manager/features/dashboard/services/sub_menu/update_appliance_information.dart';
import 'package:flutter/material.dart';
import 'package:appliance_manager/features/dashboard/model/appliance_information.dart';
import 'package:logger/logger.dart';



void editApplianceDialogBox(BuildContext context, Appliance oldApplianceInformation, Function(int) reloadList) {
  Appliance newApplianceInformation = Appliance(
    userId: oldApplianceInformation.userId,
    applianceName: oldApplianceInformation.applianceName,
    applianceType: oldApplianceInformation.applianceType,
    brand: oldApplianceInformation.brand,
    model: oldApplianceInformation.model,
    warrantyExpirationDate: oldApplianceInformation.warrantyExpirationDate,
  );

  final TextEditingController applianceNameController = TextEditingController(text: oldApplianceInformation.applianceName);
  final TextEditingController applianceTypeController = TextEditingController(text: oldApplianceInformation.applianceType);
  final TextEditingController brandController = TextEditingController(text: oldApplianceInformation.brand);
  final TextEditingController modelController = TextEditingController(text: oldApplianceInformation.model);
  final TextEditingController warrantyExpirationDateController = TextEditingController(text: oldApplianceInformation.warrantyExpirationDate);

  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Appliance'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(controller: applianceNameController, decoration: const InputDecoration(labelText: 'Appliance Name')),
            TextField(controller: applianceTypeController, decoration: const InputDecoration(labelText: 'Appliance Type')),
            TextField(controller: brandController, decoration: const InputDecoration(labelText: 'Brand')),
            TextField(controller: modelController, decoration: const InputDecoration(labelText: 'Model')),
            TextField(controller: warrantyExpirationDateController, decoration: const InputDecoration(labelText: 'Warranty Expiration Date')),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              newApplianceInformation.applianceName = applianceNameController.text;
              newApplianceInformation.applianceType = applianceTypeController.text;
              newApplianceInformation.brand = brandController.text;
              newApplianceInformation.model = modelController.text;
              newApplianceInformation.warrantyExpirationDate = warrantyExpirationDateController.text;

              // Update appliance in the database
              await updateApplianceInformation(newApplianceInformation, oldApplianceInformation);

              // Reload the appliance list after updating
              if (context.mounted) {
                Logger().i('Reloading appliance list after update');
                reloadList(newApplianceInformation.userId);
              } else {
                Logger().w('Context is no longer mounted, cannot reload list');
              }

              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    }
  );
}

