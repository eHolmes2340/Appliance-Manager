//File       : get_appliance_information.dart 
//Programmer : Erik Holmes 
//Date       : Feb 12, 2025
//Description: This file will contain the function to get the appliance information from the backend

import 'package:appliance_manager/common/server_address.dart';
import 'package:logger/logger.dart';
import '../model/appliance_information.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


//Function  :getApplianceInformation
//Description : This function will get the appliance information from the backend 
Future<List<Appliance>> getApplianceInformation(int userId) async {
  List<Appliance> applianceList = [];
  final response = await http.get(
    Uri.parse(ServerAddress.getApplianceData+userId.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  Logger().i(error: response.statusCode, response.body);

  if (response.statusCode == 200) {
    List<dynamic> appliancesJson = jsonDecode(response.body);
    for (var applianceJson in appliancesJson) {
      applianceList.add(Appliance.fromJson(applianceJson));
    }
  } else {
    throw Exception('Failed to load appliance information');
  }

  return applianceList;
}