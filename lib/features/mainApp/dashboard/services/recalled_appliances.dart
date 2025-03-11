import 'dart:convert';
import 'package:appliance_manager/common/obj/server_address.dart';
import 'package:http/http.dart' as http;
import '../model/recall.dart'; 

//Function    : fetchRecalls 
//Description : Fetches the recalls data from the server 
Future<List<Recall>> fetchRecalls() async {
  final String url = ServerAddress.fetchRecalls;
  try
  {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      List<dynamic> jsonData=json.decode(response.body);

      return jsonData.map((item) => Recall.fromJson(item)).toList(); 
    }
    else{
      throw Exception('Failed to load recalls');
    }
  }
  catch(e){
    print('Error fetching recalls: $e');
    return [];
  }
}

