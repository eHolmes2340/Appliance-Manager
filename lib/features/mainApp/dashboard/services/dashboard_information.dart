import 'package:appliance_manager/common/obj/server_address.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/recalls_page/model/recallClass.dart';
import 'package:logger/logger.dart';


Future<List<Appliance>> dashboardAppliance(int? userID)async
{
  List<Appliance> applianceList = [];
  if(userID==null)
  {
    return applianceList;
  }

  try
  {
    final response=await http.get(Uri.parse('${ServerAddress.dashboardAppliances}?userID=$userID')); 
    
    if(response.statusCode==200)
    {
      final List<dynamic> jsonData=json.decode(response.body);
      for(var item in jsonData)
      {
        applianceList.add(Appliance.fromJson(item));
      }
     
    }
    else
    {
      return []; 
    }
  }
  catch(e)
  {
    Logger().e("Error fetching appliance data: $e");
    return []; 
  }
  Logger().d('appliance data: ${applianceList.map((e) => e.toJson()).toList()}');
  return applianceList;
}


//Function     : dashboardRecalls
//Description  : This function will load the recall information from the backend. 
Future<List<Recall>> dashboardRecalls()async
{
  List<Recall> recallList = [];

  try
  {
    final response= await http.get(Uri.parse(ServerAddress.dashboardRecall));

    if(response.statusCode==200)
    {
      final List<dynamic> jsonData=json.decode(response.body);
      for(var item in jsonData)
      {
        recallList.add(Recall.fromJson(item));
      }
    }
    else
    {
      return []; 
    } 

  }
  catch(e)
  {
   Logger().e("Error fetching recall data: $e");
   return []; 
  }
  
 //  Logger().d('recall data: ${recallList.map((e) => e.toJson()).toList()}');
  return recallList;
}


