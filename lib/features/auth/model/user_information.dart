//File       : user_information.dart
//Programmer : Erik Holmes
//Date       : January 21, 2024
//Description: This file contains the user information object


//Class      : UserInformation
//Description: This class is used to store user information
class UserInformation {
  String firstName;
  String lastName; 
  String email;
  String postalCode; 
  String country;
  
    //Constructor: UserInformation
    //Description: This constructor is used to create a new UserInformation object
    UserInformation({
      required this.firstName,
      required this.lastName,
      required this.email,  
      required this.postalCode,
      required this.country,
    });

    Map<String, dynamic> toJson() {
      return {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'postalCode': postalCode,
        'country': country,
      };
    }

}