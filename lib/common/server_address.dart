//File       : server_address.dart
//Programmer : Erik Holmes
//Date       : Feb 10, 2025
//Description: This file will contain the server addresses and port numbers for the appliance manager project
import 'package:flutter_dotenv/flutter_dotenv.dart'; 

//Class       :ServerAddress 
//Description : This class will hold the server address and port number.
class ServerAddress{

  //.env vars 
  static String? local_host=dotenv.env['LOCAL_HOST'];
  static String? port_number=dotenv.env['PORT_NUMBER']; 

  static String? forCheckingConnection='${ServerAddress.local_host}:${ServerAddress.port_number}/api/health';

  static String? user_information_endpoint=dotenv.env['USER_INFORMATION_END_POINT'];
  static String? get_user_information=dotenv.env['GET_USER_INFORMATION'];
  static String? send_appliance_information=dotenv.env['SEND_APPLIANCE_INFORMATION'];
  static String? get_appliance_information=dotenv.env['GET_APPLIANCE_INFORMATION'];

  //URLs 
  static String createUserProfile='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.user_information_endpoint}';
  static String getUserProfile='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.get_user_information}';

  static String sendApplianceData='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.send_appliance_information}';

  static String getApplianceData='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.get_appliance_information}?userId=';
}