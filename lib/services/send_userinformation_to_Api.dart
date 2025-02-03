import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<void> sendUserInformation(UserInformation userInfo) async{

  try{
    final response=await http.post(
      Uri.parse('http://localhost:3000/userInformation'), 
      headers:{
        'Content-Type':'application/json'
      }
      ,body: jsonEncode(userInfo.toJson())
    );
    if(response.statusCode==200){
      print('User information sent successfully');
    }
    else{
      print('Failed to send user information');
    }
  }
  catch(e){
    print('Error: $e');
  }

  
}