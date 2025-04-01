//File        : recall.dart
//Programmer  : Erik Holmes
//Last Updated: 03/15/2025
//Description : Model for recall data

//Class      : Recall 
//Description: Model 
class Recall {
  final String recall_date;
  final String safety_warning_date;  // Corrected typo here
  final String recall_heading;
  final String product_name;
  final String hazard_description;
  final String consumer_action;

  Recall({
    required this.recall_date,
    required this.safety_warning_date,  // Corrected typo here
    required this.recall_heading,
    required this.product_name,
    required this.hazard_description,
    required this.consumer_action,
  });

  factory Recall.fromJson(Map<String, dynamic> json) {
    return Recall(
      safety_warning_date: json['safety_warning_date'] ?? '',  // Corrected key name here
      recall_date: json['recall_date'] ?? '',
      recall_heading: json['recall_heading'] ?? '',
      product_name: json['product_name'] ?? '',
      hazard_description: json['hazard_description'] ?? '',
      consumer_action: json['consumer_action'] ?? '',
    );
  }

  // Optionally, add toJson() method if you need to convert back to JSON
  Map<String, dynamic> toJson() {
    return {
      'recall_date': recall_date,
      'safety_warning_date': safety_warning_date,  // Corrected key name here
      'recall_heading': recall_heading,
      'product_name': product_name,
      'hazard_description': hazard_description,
      'consumer_action': consumer_action,
    };
  }
}
