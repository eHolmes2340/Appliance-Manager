import 'package:appliance_manager/features/dashboard/model/appliance_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';


Future<void> send_appliance_information_to_backend(Appliance appliance) async {
  try {
    Uri url = Uri.parse('http://10.0.0.105:3000/applianceInformation'); // Or use your environment variable
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
