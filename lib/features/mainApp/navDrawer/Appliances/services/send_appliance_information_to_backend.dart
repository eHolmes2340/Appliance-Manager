//File: send_appliance_information_to_backend.dart
//Programmer: Erik Holmes
//Date: Feb 10, 2025
//Description: This file will send the appliance information to the backend server
import 'package:appliance_manager/common/obj/server_address.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

// Function: send_appliance_information_to_backend
// Description: Sends the appliance information to the backend server
Future<void> send_appliance_information_to_backend(Appliance appliance) async
 {
  try {
    Uri url = Uri.parse(ServerAddress.sendApplianceData); // Or use your environment variable
    Map<String, dynamic> applianceData = appliance.toJson();
   
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(applianceData),
    );

    if (response.statusCode == 201) {
      Logger().i('Appliance information sent to the backend');
    } 
    else {
      Logger().e('Failed to send appliance information to the backend. Status code: ${response.statusCode}');
      
    }
  } catch (e) {
    Logger().e('Error: $e');
  }
}
