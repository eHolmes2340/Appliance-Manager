//File    : get_userInformation.dart
//Programmer : Erik Holmes
//Date    : Feb 9, 2025

import 'dart:convert';
import 'package:appliance_manager/common/obj/server_address.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:appliance_manager/features/auth/model/user_information.dart';

//Function    : getUserInformation 
//Description : This function will send the email address to the backend and then retreive the user information. 
Future<UserInformation?> retrieveUserProfile(String email) async {
  try {

    final response = await http.post(
      Uri.parse(ServerAddress.getUserProfile), //Found in serverAddress.dart 
      headers: {
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return UserInformation.fromJson(data); 
    }
    //This should really not be ever called. 
    else if(response.statusCode == 404){
      Logger().e('User not found');
      return null;
    }
    else 
    {
      Logger().e('Failed to retrieve user information: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    Logger().e(e.toString());
    return null;
  }
}