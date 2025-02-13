//File       : appliance_information.dart 
//Programmer : Erik Holmes
//Date       : Feb 10, 2025
//Description: This file will contain the appliance information for the appliance manager project 


//class:  Appliance
//Description: This class will contain the information for the appliance 
import 'package:camera/camera.dart';

//Class       :Appliance
//Description : This class will contain the information for the appliances
class Appliance {
  final String applianceName;
  final String applianceType;
  final String brand;
  final String model;
  final String warrantyExpirationDate;
  String appilanceImageURL; 
  final XFile? appilanceImage; //This is not stored in the database. 

  
  //Constructor: Appliance
  //Description: This constructor is used to create a new Appliance object
  Appliance({
    required this.applianceName,
    required this.applianceType,
    required this.brand,
    required this.model,
    required this.warrantyExpirationDate,
    this.appilanceImageURL='',
    this.appilanceImage,
  });

  //Method: toJson
  //Description: This method is used to convert the Appliance object to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'applianceName': applianceName,
      'applianceType': applianceType,
      'brand': brand,
      'model': model,
      'warrantyExpirationDate': warrantyExpirationDate,
      'applianceImageURL':appilanceImageURL,
    };
  }

  //Method: fromJson
  //Description: This method is used to create an Appliance object from a JSON object.
  factory Appliance.fromJson(Map<String, dynamic> json) {
    return Appliance(
      applianceName: json['applianceName'],
      applianceType: json['applianceType'],
      brand: json['brand'],
      model: json['model'],
      warrantyExpirationDate: json['warrantyExpirationDate'],
      appilanceImageURL: json['applianceImageURL'],
    );
  }
}