import 'dart:io';

import 'package:appliance_manager/features/mainApp/services/image_compress.dart';
import 'package:appliance_manager/features/mainApp/services/send_appliance_information_to_backend.dart';
import 'package:appliance_manager/features/mainApp/services/send_image_to_firebase.dart';
import 'package:appliance_manager/features/mainApp/services/use_image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../model/appliance_information.dart';
import '../../../common/theme.dart';
import 'camera/camera_button.dart';
import 'package:image_picker/image_picker.dart';

//Function  :_addApplianceDialog
//Description : This function 
void addApplianceDialog(BuildContext context, int userId, Function(Appliance) onApplianceAdded) {
  final appliance_name = TextEditingController();
  final brand = TextEditingController(); // New brand text field
  final model = TextEditingController();
  final warranty_expiration_date = TextEditingController();
  String selectedApplianceType = 'Kitchen'; // Default value
  XFile? applianceImage;
  bool isLoading = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Add Appliance', style: 
                    TextStyle(
                    color: AppTheme.main_colour,
                    fontSize: 20, 
                    fontWeight: FontWeight.bold)
                    ),
                    SizedBox(height: 10),
                    Text('Add the following information into the virtual home'),
                    SizedBox(height: 10),
                    Theme(
                      data: ThemeData(primaryColor: AppTheme.main_colour),
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Appliance Name',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.main_colour),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.main_colour),
                              ),
                            ),
                            controller: appliance_name,
                          ),
                          SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: selectedApplianceType,
                            decoration: InputDecoration(
                              labelText: 'Appliance Type',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.main_colour),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.main_colour),
                              ),
                            ),
                            items: <String>['Kitchen', 'Laundry', 'Cleaning', 'Living', 'Bathroom', 'Home Entertainment', 'Home Office', 'Other']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedApplianceType = newValue!;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Brand', // New brand text field
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.main_colour),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.main_colour),
                              ),
                            ),
                            controller: brand,
                          ),
                          SizedBox(height: 10),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Model',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.main_colour),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.main_colour),
                              ),
                            ),
                            controller: model,
                          ),
                          SizedBox(height: 10),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Warranty Expiration Date', //Notify user when warranty is about to expire
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.main_colour),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.main_colour),
                              ),
                            ),
                            controller: warranty_expiration_date, //YYYY-MM-DD
                          ),
                          SizedBox(height: 10),
                          if (applianceImage != null)
                            Image.file(
                              File(applianceImage!.path),
                              height: 100,
                              width: 100,
                            ),
                          SizedBox(height: 10),
                          CameraButton(
                            onPictureTaken: (XFile image) {
                              setState(() {
                                applianceImage = image;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              XFile? image = await getImageFromGallery(); //Use_image_picker.dart
                              if (image != null) {
                                setState(() {
                                  applianceImage = image;
                                });
                              }
                            },
                            child: Text('Choose out of gallery'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    if (isLoading)
                      CircularProgressIndicator(),
                    if (!isLoading)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: AppTheme.main_colour),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });

                              Appliance appliance = Appliance(
                                userId: userId,
                                applianceName: appliance_name.text,
                                applianceType: selectedApplianceType,
                                brand: brand.text,
                                model: model.text,
                                warrantyExpirationDate: warranty_expiration_date.text,
                                appilanceImage: applianceImage,
                              );

                              //Send the image to firebase storage 
                              if (appliance.appilanceImage != null) {
                                XFile firebaseFile = await compressXFile(appliance.appilanceImage!);
                                appliance.appilanceImageURL = await uploadImageToFirebaseStorage(firebaseFile);
                              }

                              setState(() {
                                isLoading = false;
                              });

                              //Send the data to the Mysql database using http post request
                              await send_appliance_information_to_backend(appliance);

                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();

                              // Call the callback function to add the appliance to the list
                              onApplianceAdded(appliance);
                            },
                            child: Text(
                              'Add Appliance',
                              style: TextStyle(color: AppTheme.main_colour),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}