// ignore: file_names
//File    : editApplianceDialogBox.dart
//Programmer : Erik Holmes
//Date: Feb 19, 2025
//Description: This file will contain the dialog box to edit the appliance information
import 'package:flutter/material.dart';
import 'package:appliance_manager/features/dashboard/model/appliance_information.dart';
import 'package:logger/logger.dart';
// import 'package:logger/logger.dart';



//Function    : editApplianceDialogBox
//Description : This function will bring up a dialog box to edit thiance information
void editApplianceDialogBox(BuildContext context, Appliance appliance)
{
  // Appliance applianceCopy=appliance;
  final TextEditingController applianceNameController=TextEditingController(text: appliance.applianceName);
  final TextEditingController applianceTypeController=TextEditingController(text: appliance.applianceType);
  final TextEditingController brandController=TextEditingController(text: appliance.brand);
  final TextEditingController modelController=TextEditingController(text: appliance.model);
  final TextEditingController warrantyExpirationDateController=TextEditingController(text: appliance.warrantyExpirationDate);

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
            // applianceCopy.applianceName=applianceNameController.text;
            // applianceCopy.applianceType=applianceTypeController.text;
            // applianceCopy.brand=brandController.text;
            // applianceCopy.model=modelController.text;
            // applianceCopy.warrantyExpirationDate=warrantyExpirationDateController.text;

            //Save this database now 

            //update the dashboard 

            //Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  });
}