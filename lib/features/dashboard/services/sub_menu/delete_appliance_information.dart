
import 'package:appliance_manager/common/server_address.dart';
import 'package:appliance_manager/features/dashboard/model/appliance_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

//Function :deleteApplianceInformation  
//Description: This function will delete the appliance information from the database  
Future<bool> deleteApplianceInformation(Appliance appliance) async {
  try {
    final response = await http.delete(
      Uri.parse(ServerAddress.deleteApplianceInformation),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": appliance.userId,
        "applianceName": appliance.applianceName,
        "applianceType": appliance.applianceType,
        "brand": appliance.brand,
        "model": appliance.model,
      }),
    );

    if (response.statusCode == 200) {
      return true; // Successfully deleted
    } 
    else {
      Logger().e("Failed to delete appliance: ${response.body}");
      return false;
    }
  }
   catch (e) {
    Logger().e("Failed to delete appliance: $e");
    return false;
  }
}


