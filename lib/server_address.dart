import 'package:flutter_dotenv/flutter_dotenv.dart'; 

//Class       :ServerAddress 
//Description : This class will hold the server address and port number.
class ServerAddress{
  static String? local_host=dotenv.env['LOCAL_HOST'];
  static String? port_number=dotenv.env['PORT_NUMBER']; 

  static String? user_information_endpoint=dotenv.env['USER_INFORMATION_END_POINT'];
  static String? get_user_information=dotenv.env['GET_USER_INFORMATION'];


  static String createUserProfile='${ServerAddress.local_host}:${ServerAddress.port_number}/${ServerAddress.user_information_endpoint}';
  
  static String getUserProfile='${ServerAddress.local_host}:${ServerAddress.port_number}/${ServerAddress.get_user_information}';
}