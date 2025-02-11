import 'package:flutter/material.dart';
import '../model/appliance_information.dart';
import '../../../common/theme.dart';

//Function  :_addApplianceDialog
//Description : This function 
void addApplianceDialog(BuildContext context) {
  final appliance_name = TextEditingController();
  final appliance_type = TextEditingController();
  final model = TextEditingController();
  final warranty_expiration_date = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
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
                    TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Appliance Type',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.main_colour),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.main_colour),
                        ),
                      ),
                      controller: appliance_type,
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
                    onPressed: () {
                      Appliance appliance = Appliance(
                        applianceName: appliance_name.text,
                        applianceType: appliance_type.text,
                        model: model.text,
                        warrantyExpirationDate: warranty_expiration_date.text,
                      );
                      // Perform the action to add the appliance

                      //add to database. 
                      

                      Navigator.of(context).pop();
                    },
                    child: Text('Add Appliance'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}