import 'package:appliance_manager/common/obj/server_address.dart';
import '../model/recall.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


//Function    : getRecalls
//Description : Get recalls from the backend API. 
Future<List<Recall>> getRecalls({ 
  String search='',
  String hazard='',
  String startDate='',
  String endDate='',
  int page=1,
  int limit=10,}) async 
{

  try
  {
    final Uri url=Uri.parse(
      '${ServerAddress.fetchRecalls}?search=$search&hazard=$hazard&startDate=$startDate&endDate=$endDate&page=$page&limit=$limit'
      );
    final response=await http.get(url, headers: {'Content-Type': 'application/json'});
    
    if(response.statusCode==200)
    {
      final List<dynamic> recalls=jsonDecode(response.body);
      return recalls.map((item) => Recall.fromJson(item)).toList();
    }
    else
    {
      throw Exception('Failed to get recalls');
    }
  }
  catch (e)
  {
    print('Error in getRecalls: $e');
    return [];
  }

}
