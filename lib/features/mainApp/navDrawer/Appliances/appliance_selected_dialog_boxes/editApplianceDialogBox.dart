// ignore: file_names
//File    : editApplianceDialogBox.dart
//Programmer : Erik Holmes
//Date: Feb 19, 2025
//Description: This file will contain the dialog box to edit the oldApplianceInformation information
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/services/send_image_to_firebase.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/services/sub_menu/delete_appliance_information.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/services/sub_menu/update_appliance_information.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/services/use_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:logger/logger.dart';
import '../camera/camera_button.dart'; 

//Function    : editApplianceDialogBox
//Description : Displays a dialog box to edit the appliance information.
void editApplianceDialogBox(BuildContext context, Appliance oldApplianceInformation, Function(int) reloadList) {
  Appliance newApplianceInformation = Appliance(
    userId: oldApplianceInformation.userId,
    applianceName: oldApplianceInformation.applianceName,
    applianceType: oldApplianceInformation.applianceType,
    brand: oldApplianceInformation.brand,
    model: oldApplianceInformation.model,
    warrantyExpirationDate: oldApplianceInformation.warrantyExpirationDate,
    appilanceImageURL: oldApplianceInformation.appilanceImageURL,
    manualURL: oldApplianceInformation.manualURL,
  );

  XFile? newImageSaved; 
  final TextEditingController applianceNameController = TextEditingController(text: oldApplianceInformation.applianceName);
  final TextEditingController brandController = TextEditingController(text: oldApplianceInformation.brand);
  final TextEditingController modelController = TextEditingController(text: oldApplianceInformation.model);
  final TextEditingController warrantyExpirationDateController = TextEditingController(text: oldApplianceInformation.warrantyExpirationDate);

  // List of appliance types
  final List<String> applianceTypes = [
    'Kitchen', 'Laundry', 'Cleaning', 'Living', 'Bathroom', 'Home Entertainment', 'Home Office', 'Other'
  ];

  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Appliance'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(controller: applianceNameController, decoration: const InputDecoration(labelText: 'Appliance Name')),
            
            // Dropdown for Appliance Type
            DropdownButtonFormField<String>(
              value: oldApplianceInformation.applianceType.isNotEmpty 
                  ? oldApplianceInformation.applianceType 
                  : null,
              decoration: const InputDecoration(labelText: 'Appliance Type'),
              items: applianceTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  newApplianceInformation.applianceType = value;
                }
              },
            ),

            TextField(controller: brandController, decoration: const InputDecoration(labelText: 'Brand')),
            TextField(controller: modelController, decoration: const InputDecoration(labelText: 'Model')),
            TextField(controller: warrantyExpirationDateController, decoration: const InputDecoration(labelText: 'Warranty Expiration Date')),
          ],
        ),
        actions: <Widget>[

       CameraButton(
          onPictureTaken: (XFile? image) {
            if (image == null) {
              Logger().w("No image captured.");
              return;
            }
            Logger().i("Image captured successfully");
            newImageSaved = image;
            newApplianceInformation.appilanceImage = image; // Ensure valid assignment
        
          }
        ),


        ElevatedButton(
          onPressed: ()async{
           newImageSaved=(await getImageFromGallery())!; 
            newApplianceInformation.appilanceImage=newImageSaved; 
            },
            child: Text('Choose out of gallery')
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),


          //Start here and edit it so if there is no image saved then we will not upload the image to firebase storage
          //Mar 26 2025
          
          TextButton(
            onPressed: () async {
              newApplianceInformation.applianceName = applianceNameController.text;
              newApplianceInformation.brand = brandController.text;
              newApplianceInformation.model = modelController.text;
              newApplianceInformation.warrantyExpirationDate = warrantyExpirationDateController.text;

              //Set the old manual URL to the new appliance information manual URL
              newApplianceInformation.manualURL = oldApplianceInformation.manualURL;

                 // Ensure an image exists before uploading
              if (newImageSaved == null) 
              {
                Logger().w("No new image was selected.");
                await updateApplianceInformation(newApplianceInformation, oldApplianceInformation);
              } 
              else 
              {
                
                await deleteImageFirebaseStorage(oldApplianceInformation.appilanceImageURL);
                // Compress the image before uploading
                newApplianceInformation.appilanceImage = newImageSaved;
                newApplianceInformation.appilanceImageURL = await uploadImageToFirebaseStorage(newApplianceInformation.appilanceImage!);
                if(await updateApplianceInformation(newApplianceInformation, oldApplianceInformation)==false)
                {
                  Logger().e("Failed to update appliance information");
                }
                else
                {
                  Logger().i("Appliance information updated successfully");
                }
              }
          
              // Reload the appliance list after updating
              if (context.mounted) {
                Logger().i('Reloading appli ance list after update');
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

