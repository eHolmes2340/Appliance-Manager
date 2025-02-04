//I want to send the email address to the backend
import 'dart:convert';
import 'package:appliance_manager/features/auth/model/server_address.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:appliance_manager/features/auth/model/server_address.dart';

//Function    : getUserInformation 
//Description : This function will send the email address to the backend and then retreive the user information. 
Future <void> sendEmailToBackend(String email) async
{
  try{
    final response=await http.post(
      Uri.parse('$LOCAL_HOST:$PORTNUMBER/$GET_USER_INFORMATION'), //Found in serverAddress.dart 
      headers:{
        'Content-Type':'application/json'
      }
      ,body: jsonEncode(email)
    );
    
  }
  catch(e) {
    Logger().e(e.toString()); 
  }
}