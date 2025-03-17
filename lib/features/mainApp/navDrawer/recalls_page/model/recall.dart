//File        : recall.dart
//Programmer  : Erik Holmes
//Last Updated: 03/15/2025
//Description : Model for recall data

//Class      : Recall 
//Description: Model 
class Recall
{

  final String recall_date; 
  final String saftey_warning_date;
  final String recall_heading;
  final String product_name; 
  final String hazard_description; 
  final String consumer_action; 

  

  Recall({
    // ignore: non_constant_identifier_names
    required this.recall_date,
    required this.saftey_warning_date,
    required this.recall_heading,
    required this.product_name,
    required this.hazard_description,
    required this.consumer_action,
  });


  factory Recall.fromJson(Map<String, dynamic> json)
  {
    return Recall(
      saftey_warning_date: json['saftey_warning_date'],
      recall_date: json['recall_date'],
      recall_heading: json['recall_heading'],
      product_name: json['product_name'],
      hazard_description: json['hazard_description'],
      consumer_action: json['consumer_action'],
    );
  }
}