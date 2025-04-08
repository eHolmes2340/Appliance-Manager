class UserInformation {
  int id;
  String firstName;
  String lastName;
  String email;
  String postalCode;
  String country;
  bool freeAccount;
  bool accountVerified;
  bool notificationsEnabled; // Added notifications setting

  // Constructor
  UserInformation({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.postalCode,
    required this.country,
    required this.freeAccount,
    required this.accountVerified,
    this.notificationsEnabled = true, // Default is true (enabled)
  });

  // fromJson
  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      postalCode: json['postalCode'],
      country: json['country'],
      freeAccount: json['freeAccount'],
      accountVerified: json['accountVerified'],
      notificationsEnabled: json['notificationsEnabled'] ?? true, // Default is true
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'postalCode': postalCode,
      'country': country,
      'freeAccount': freeAccount,
      'accountVerified': accountVerified,
      'notificationsEnabled': notificationsEnabled, // Include notifications setting in JSON
    };
  }

  // Method to update notification setting
  void updateNotificationSetting(bool value) {
    notificationsEnabled = value;
  }
}
