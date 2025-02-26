//File        : update_appliance_information.dart 
//Programmer  : Erik Holmes
//Date        : Feb 15 2025
//Description : This file will update the appliance information


import 'dart:convert';

import 'package:appliance_manager/common/server_address.dart';
import 'package:appliance_manager/features/dashboard/model/appliance_information.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; 

//Function  :updateApplianceInformation
//Return    : bool
//Description : This function will update the appliance information
//OldApplainceInformation should have a userID. 
Future<bool> updateApplianceInformation(Appliance newApplianceInformation, Appliance oldApplianceInformation) async {
  try {
    Map<String, dynamic> requestBody = {
      "userID": oldApplianceInformation.userId,
      "oldApplianceInformation": oldApplianceInformation.toJson(),
      "newApplianceInformation": newApplianceInformation.toJson(),
    };

    final response = await http.put(
      Uri.parse('http://10.0.0.248:3000/api/updateApplianceInformation'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    Logger().i("Response Status: ${response.statusCode}");
    Logger().i("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Logger().i('Appliance information updated successfully');
      return true;
    } else {
      Logger().e('Failed to update appliance information');
      return false;
    }
  } catch (e) {
    Logger().e('Error updating appliance information: $e');
    return false;
  }
}
