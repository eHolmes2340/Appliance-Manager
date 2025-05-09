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
   //Dashboard 
  static String? get_recall_information_for_dashboard=dotenv.env['DASHBOARD_RECALLS'];




  static String? forCheckingConnection='${ServerAddress.local_host}:${ServerAddress.port_number}/api/health';

  static String? user_information_endpoint=dotenv.env['USER_INFORMATION_END_POINT'];
  static String? get_user_information=dotenv.env['GET_USER_INFORMATION'];
  static String? send_appliance_information=dotenv.env['SEND_APPLIANCE_INFORMATION'];
  static String? get_appliance_information=dotenv.env['GET_APPLIANCE_INFORMATION'];

  static String? update_user_information=dotenv.env['UPDATE_USER_INFORMATION'];


  static String? update_appliance_information=dotenv.env['UPDATE_APPLIANCE_INFORMATION'];

  static String? delete_appliance_information=dotenv.env['DELETE_APPLIANCE_INFORMATION'];

  //Reacalled appliances
  static String? recalled_appliances=dotenv.env['GET_RECALLS_FROM_BACKEND'];

  static String? recalled_notifications=dotenv.env['RECALL_NOTIFICATIONS'];

  //URLs 
  static String createUserProfile='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.user_information_endpoint}';
  
  static String getUserProfile='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.get_user_information}';

  static String sendApplianceData='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.send_appliance_information}';

  static String getApplianceData='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.get_appliance_information}?userId=';

  //Update
  static String updateApplianceInformation='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.update_appliance_information}';
  
  //Delete
  static String deleteApplianceInformation='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.delete_appliance_information}';


  //Recall list applications 
  static String fetchRecalls='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.recalled_appliances}';

  //Update user information
  static String updateUserInformation='${ServerAddress.local_host}:${ServerAddress.port_number}/api/${ServerAddress.update_user_information}';


  static String saveManual='${ServerAddress.local_host}:${ServerAddress.port_number}/api/saveManual';


  static String dashboardRecall='${ServerAddress.local_host}:${ServerAddress.port_number}/api/getRecallInformationForDashboard';

  static String dashboardAppliances='${ServerAddress.local_host}:${ServerAddress.port_number}/api/getApplianceInformationForDashboard/';


  static String getRecallNotifications='${ServerAddress.local_host}:${ServerAddress.port_number}/api//recall/notifications/';


}


///working