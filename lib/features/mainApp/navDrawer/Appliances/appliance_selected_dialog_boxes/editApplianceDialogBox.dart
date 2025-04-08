//File: editApplianceDialogBox.dart
//Programmer: Erik Holmes
//Date: Feb 19, 2025
//Description: This file will contain the dialog box to edit the oldApplianceInformation information.

import 'package:applianceCare/common/theme.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance_selected_dialog_boxes/manuals/manualsNotSaved.dart';
import 'package:flutter/material.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/services/send_image_to_firebase.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/services/sub_menu/delete_appliance_information.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/services/sub_menu/update_appliance_information.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/services/use_image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:logger/logger.dart';
import '../camera/camera_button.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';



Widget showEditApplianceDialog(
  BuildContext context, 
  Appliance appliance, 
  String email,
  Future<void> Function(int) reloadList
) {
  Appliance newApplianceInformation = Appliance(
    userId: appliance.userId,
    applianceName: appliance.applianceName,
    applianceType: appliance.applianceType,
    brand: appliance.brand,
    model: appliance.model,
    warrantyExpirationDate: appliance.warrantyExpirationDate,
    appilanceImageURL: appliance.appilanceImageURL,
    manualURL: appliance.manualURL,
  );

  XFile? newImageSaved;
  final TextEditingController applianceNameController = TextEditingController(text: appliance.applianceName);
  final TextEditingController brandController = TextEditingController(text: appliance.brand);
  final TextEditingController modelController = TextEditingController(text: appliance.model);
  final TextEditingController warrantyExpirationDateController = TextEditingController(text: appliance.warrantyExpirationDate);

  final List<String> applianceTypes = [
    'Kitchen', 'Laundry', 'Cleaning', 'Living', 'Bathroom', 'Home Entertainment', 'Home Office', 'Other'
  ];

  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: const Text('Edit Appliance', style: TextStyle(fontWeight: FontWeight.bold)),
    contentPadding: EdgeInsets.all(16),
    backgroundColor: const Color.fromARGB(255, 206, 206, 206),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTextField(controller: applianceNameController, label: 'Appliance Name'),
          _buildDropdownButton(
            value: appliance.applianceType.isNotEmpty ? appliance.applianceType : null,
            items: applianceTypes,
            onChanged: (value) {
              if (value != null) {
                newApplianceInformation.applianceType = value;
              }
            },
          ),
          _buildTextField(controller: brandController, label: 'Brand'),
          _buildTextField(controller: modelController, label: 'Model'),
          _buildTextField(controller: warrantyExpirationDateController, label: 'Warranty Expiration Date'),
          CameraButton(
            onPictureTaken: (XFile? image) {
              if (image == null) {
                Logger().w("No image captured.");
                return;
              }
              Logger().i("Image captured successfully");
              newImageSaved = image;
              newApplianceInformation.appilanceImage = image; // Ensure valid assignment
            },
          ),
          SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () async {
              newImageSaved = await getImageFromGallery();
              if (newImageSaved != null) {
                newApplianceInformation.appilanceImage = newImageSaved;
              }
            },
            icon: Icon(Icons.photo_library, color: Colors.white),
            label: Text('Choose from Gallery'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: const Color.fromARGB(255, 32, 134, 230),
              foregroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () async {
              if (appliance.manualURL.isNotEmpty) {
                newApplianceInformation.manualURL = appliance.manualURL;
              }
              final manualUrl = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (context) => ManualNotSavedWebView(appliance: newApplianceInformation, reloadList: reloadList),
                ),
              );

              // If user saved a manual, update it here:
              if (manualUrl != null) {
                newApplianceInformation.manualURL = manualUrl;
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No manual URL provided')),
                );
              }
            },
            icon: Icon(Icons.menu_book_rounded, color: Colors.white),
            label: Text('Update Online Manual'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: const Color.fromARGB(255, 32, 134, 230),
              foregroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
      ),
      ElevatedButton(
        onPressed: () async {
          String manualURL= newApplianceInformation.manualURL;
          newApplianceInformation.applianceName = applianceNameController.text;
          newApplianceInformation.brand = brandController.text;
          newApplianceInformation.model = modelController.text;
          newApplianceInformation.warrantyExpirationDate = warrantyExpirationDateController.text;

          

          if (newImageSaved == null) {
            Logger().w("No new image was selected.");

            newApplianceInformation.manualURL = manualURL;
            await updateApplianceInformation(newApplianceInformation, appliance);

          } else {
            await deleteImageFirebaseStorage(appliance.appilanceImageURL);
            newApplianceInformation.appilanceImage = newImageSaved;
            newApplianceInformation.appilanceImageURL = await uploadImageToFirebaseStorage(newApplianceInformation.appilanceImage!);
            if (await updateApplianceInformation(newApplianceInformation, appliance) == false) {
              Logger().e("Failed to update appliance information");
            } else {
              Logger().i("Appliance information updated successfully");
            }
          }

          if (context.mounted) {
            Logger().i('Reloading appliance list after update');
            reloadList(newApplianceInformation.userId);
          } else {
            Logger().w('Context is no longer mounted, cannot reload list');
          }

          // This pops the current screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Appliances(validEmail: email), // Pass the validEmail to the Appliances widget
            ),
          );
          
        },
        child: const Text('Save'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.main_colour,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ],
  );
}




// Helper widget for building text fields
Widget _buildTextField({
  required TextEditingController controller,
  required String label,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),
    ),
  );
}

// Helper widget for building dropdown buttons
Widget _buildDropdownButton({
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: 'Appliance Type',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),
      items: items.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}
