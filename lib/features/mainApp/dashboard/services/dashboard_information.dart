import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/recalls_page/model/recallClass.dart';


Future<List<Appliance>> dashboardAppliance(int? userID)async
{
  List<Appliance> applianceList = [];
  if(userID==null)
  {
    return applianceList;
  }

  try
  {

  }
  catch(e)
  {
    print("Error fetching appliance data: $e");
  }
 
  return applianceList;
}


Future<List<Recall>> dashboardRecalls()async
{
  List<Recall> recallList = [];
  return recallList;
}


