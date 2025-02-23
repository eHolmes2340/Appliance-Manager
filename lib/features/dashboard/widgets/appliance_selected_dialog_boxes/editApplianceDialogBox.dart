// ignore: file_names
//File    : editApplianceDialogBox.dart
//Programmer : Erik Holmes
//Date: Feb 19, 2025
//Description: This file will contain the dialog box to edit the oldApplianceInformation information
import 'package:appliance_manager/features/dashboard/services/update_appliance_information.dart';
import 'package:flutter/material.dart';
import 'package:appliance_manager/features/dashboard/model/appliance_information.dart';
import 'package:logger/logger.dart';
// import 'package:logger/logger.dart';

//Function    : editApplianceDialogBox
//Description : This function will bring up a dialog box to edit thiance information
void editApplianceDialogBox(BuildContext context, Appliance oldApplianceInformation)
{
  //Create a new object that contains the new appliance information. 
  Appliance newApplianceInformation=Appliance(
    userId: oldApplianceInformation.userId,
    applianceName: oldApplianceInformation.applianceName,
    applianceType: oldApplianceInformation.applianceType,
    brand: oldApplianceInformation.brand,
    model: oldApplianceInformation.model,
    warrantyExpirationDate: oldApplianceInformation.warrantyExpirationDate
  );

  final TextEditingController applianceNameController=TextEditingController(text: oldApplianceInformation.applianceName);
  final TextEditingController applianceTypeController=TextEditingController(text: oldApplianceInformation.applianceType);
  final TextEditingController brandController=TextEditingController(text: oldApplianceInformation.brand);
  final TextEditingController modelController=TextEditingController(text: oldApplianceInformation.model);
  final TextEditingController warrantyExpirationDateController=TextEditingController(text: oldApplianceInformation.warrantyExpirationDate);




  //Re-enter the information for the appliances. 
  showDialog(context: context, builder: (context)
  {
    return AlertDialog(
      title: const Text('Edit Appliance'),
      content: Column(
        children: <Widget>[
          TextField(
            controller: applianceNameController,
            decoration: const InputDecoration(labelText: 'Appliance Name'),
          ),
          TextField(
            controller: applianceTypeController,
            decoration: const InputDecoration(labelText: 'Appliance Type'),
          ),
          TextField(
            controller: brandController,
            decoration: const InputDecoration(labelText: 'Brand'),
          ),
          TextField(
            controller: modelController,
            decoration: const InputDecoration(labelText: 'Model'),
          ),
          TextField(
            controller: warrantyExpirationDateController,
            decoration: const InputDecoration(labelText: 'Warranty Expiration Date'),
          ),
          
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
          onPressed: () {
           
              //Update the old oldApplianceInformation information with the new information
              newApplianceInformation.applianceName=applianceNameController.text;
              newApplianceInformation.applianceType=applianceTypeController.text;
              newApplianceInformation.brand=brandController.text;
              newApplianceInformation.model=modelController.text;
              newApplianceInformation.warrantyExpirationDate=warrantyExpirationDateController.text;


            //Save this database now 


            Logger().i('Old Appliance: ${oldApplianceInformation.applianceName}'); 
            Logger().i('New Appliance : ${newApplianceInformation.applianceName}');

            //update the dashboard 
            updateApplianceInformation(newApplianceInformation, oldApplianceInformation, oldApplianceInformation.userId);  //From services/update_appliance_information.dart

            //Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  });
}