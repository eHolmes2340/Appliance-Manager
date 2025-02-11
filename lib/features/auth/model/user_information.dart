//File       : user_information.dart
//Programmer : Erik Holmes
//Date       : January 21, 2024
//Description: This file contains the user information object


//Class      : UserInformation
//Description: This class is used to store user information
class UserInformation {
  int id; 
  String firstName;
  String lastName; 
  String email;
  String postalCode; 
  String country;
  bool freeAccount;
  bool accountVerified;
    //Constructor: UserInformation
    //Description: This constructor is used to create a new UserInformation object
    UserInformation({
      this.id=0, //The database will assign the value for the id 
      required this.firstName,
      required this.lastName,
      required this.email,  
      required this.postalCode,
      required this.country,
      required this.freeAccount,
      required this.accountVerified
    });

    //Method: fromJson
    //Description: This method is used to create a UserInformation object from a JSON object
    factory UserInformation.fromJson(Map<String, dynamic> json) {
      return UserInformation(
        id: json['id'],  //Will be assigned by the database 
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        postalCode: json['postalCode'],
        country: json['country'],
        freeAccount: json['freeAccount'],
        accountVerified: json['accountVerified'],
      );
    }
    
    Map<String, dynamic> toJson() {
      return {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'postalCode': postalCode,
        'country': country,
        'freeAccount': freeAccount,
        'accountVerified': accountVerified,
      };
    }

}