
import 'package:appliance_manager/common/obj/server_address.dart';
import 'package:appliance_manager/features/mainApp/model/appliance_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Function :deleteApplianceInformation  
//Description: This function will delete the appliance information from the database  
Future<bool> deleteApplianceInformation(Appliance appliance) async {
  try {
    final response = await http.delete(
      Uri.parse(ServerAddress.deleteApplianceInformation),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": appliance.userId,
        "applianceName": appliance.applianceName,
        "applianceType": appliance.applianceType,
        "brand": appliance.brand,
        "model": appliance.model,
      }),
    );

    if (response.statusCode == 200) {
      return true; // Successfully deleted
    } 
    else {
      Logger().e("Failed to delete appliance: ${response.body}");
      return false;
    }
  }
   catch (e) {
    Logger().e("Failed to delete appliance: $e");
    return false;
  }
}



//Function :deleteImageFirebaseStorage
//Description: This function will delete the image from Firebase Storage
Future<void> deleteImageFirebaseStorage(String url) async
{
  if(url.isEmpty)
  {
    return;
  }
  else
  {
    try
    {
      await FirebaseStorage.instance.refFromURL(url).delete();
    }
    catch(e)
    {
      Logger().e("Failed to delete image from Firebase Storage: $e");
    }
  }
  
}


