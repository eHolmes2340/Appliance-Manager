//File       : appliance_information.dart 
//Programmer : Erik Holmes
//Date       : Feb 10, 2025
//Description: This file will contain the appliance information for the appliance manager project 


//class:  Appliance
//Description: This class will contain the information for the appliance 
class Appliance {
  final String applianceName;
  final String applianceType;
  final String model;
  final String warrantyExpirationDate;

  Appliance({
    required this.applianceName,
    required this.applianceType,
    required this.model,
    required this.warrantyExpirationDate,
  });
}