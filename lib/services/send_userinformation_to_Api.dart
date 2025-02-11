import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../server_address.dart';

import 'package:logger/web.dart';

//Function    : sendUserInformation 
//Description : This function will send users information to the backend. 
Future<void> sendUserInformation(UserInformation userInfo) async{

  try{
    String url=ServerAddress.local_host!+ServerAddress.port_number!+ServerAddress.user_information_endpoint!;
    
    final response=await http.post(
      Uri.parse(url), //These constatnts can be found in the serverAddress.dart file 
      headers:{
        'Content-Type':'application/json'
      }
      ,body: jsonEncode(userInfo.toJson())
    );
    if(response.statusCode==201){
      Logger().i('User information sent successfully');
    }
    else{
     Logger().t('Failed to send user information');
    }
  }
  catch(e){
     Logger().e('Error: $e');
  }
}