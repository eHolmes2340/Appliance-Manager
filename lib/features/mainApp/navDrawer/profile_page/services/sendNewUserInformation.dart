//File       : sendNewUserInformation.dart
//Programmer : Erik Holmes
//Date       : Mar 19, 2025 
//Description: This file contains a function to send updated user data to the server
import 'package:appliance_manager/common/obj/server_address.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:logger/logger.dart';

//Function   : sendNewUserInformation
//Description: Send updated user data to the 
Future<bool> sendNewUserInformation(UserInformation newInfo) async
{
  try
  {
    final response = await http.put(
      Uri.parse(ServerAddress.updateUserInformation),
      headers:{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(newInfo.toJson()),
    );

    if(response.statusCode != 200)
    {
      Logger().e('Error sending new user information: ${response.body}');
      return false; 
    }
    else
    {
      Logger().i('User information updated successfully');
      return true; 
    }
  }
  catch(e){
    Logger().e('Error sending new user information: $e');
    return false; 
  }

  
}