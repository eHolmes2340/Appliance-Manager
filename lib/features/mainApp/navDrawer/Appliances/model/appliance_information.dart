//File       : appliance_information.dart 
//Programmer : Erik Holmes
//Date       : Feb 10, 2025
//Description: This file will contain the appliance information for the appliance manager project 


//class:  Appliance
//Description: This class will contain the information for the appliance 
import 'package:camera/camera.dart';

//Class       :Appliance
//Description : This class will contain the information for the appliances
class Appliance 
{
  final int userId;
  int applianceId = 0; //This is not stored in the database.
  String applianceName;
  String applianceType;
  String brand;
  String model;
  String? warrantyExpirationDate;
  String appilanceImageURL; 
  XFile? appilanceImage; //This is not stored in the database. 
  String manualURL; 

  
  //Constructor: Appliance
  //Description: This constructor is used to create a new Appliance object
  Appliance({
    required this.userId,
    required this.applianceName,
    required this.applianceType,
    required this.brand,
    required this.model,
    required this.warrantyExpirationDate,
    this.appilanceImageURL='',
    this.appilanceImage,
    this.manualURL='',
  });

  //Method: toJson
  //Description: This method is used to convert the Appliance object to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'applianceName': applianceName,
      'applianceType': applianceType,
      'brand': brand,
      'model': model,
     'warrantyExpirationDate': warrantyExpirationDate?.isEmpty ?? true ? null : warrantyExpirationDate,
      'applianceImageURL':appilanceImageURL,
      'manualURL':manualURL,
    };
  }

  //Method: fromJson
  //Description: This method is used to create an Appliance object from a JSON object.
  factory Appliance.fromJson(Map<String, dynamic> json) {
    return Appliance(
      userId: json['userId'] ?? 0,  // Default to 0 if null
      applianceName: json['applianceName'] ?? '',  // Default to empty string if null
      applianceType: json['applianceType'] ?? '',  // Default to empty string if null
      brand: json['brand'] ?? '',  // Default to empty string if null
      model: json['model'] ?? '',  // Default to empty string if null
      warrantyExpirationDate: json['warrantyExpirationDate'] ?? '',  // Default to empty string if null
      appilanceImageURL: json['applianceImageURL'] ?? ' ',  // Default to empty string if null
      manualURL: json['manualURL'] ?? '',  // Default to empty string if null

    );
  }

}