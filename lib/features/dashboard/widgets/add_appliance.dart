import 'package:flutter/material.dart';
import '../model/appliance_information.dart';
import '../../../common/theme.dart';
import '../../../services/send_appliance_information.dart';

//Function  :_addApplianceDialog
//Description : This function 
void addApplianceDialog(BuildContext context) {
  final appliance_name = TextEditingController();
  final model = TextEditingController();
  final warranty_expiration_date = TextEditingController();
  String selectedApplianceType = 'Kitchen'; // Default value

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Add Appliance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Appliance appliance = Appliance(
                            applianceName: appliance_name.text,
                            applianceType: selectedApplianceType,
                            model: model.text,
                            warrantyExpirationDate: warranty_expiration_date.text,
                          );
                          bool success = await sendApplianceInformation(appliance);
                          if (success) {
                            // Handle success
                          } else {
                            // Handle failure
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text('Add Appliance'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}