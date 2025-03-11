


//Class      : Recall 
//Description: Model 
class Recall{

  final String productName; 
  final String hazard; 
  final String date; 

  Recall({
    required this.productName,
    required this.hazard,
    required this.date,
  });

  factory Recall.fromJson(Map<String, dynamic> json) {
    return Recall(
      productName: json['name'] ?? 'Unknown Product',
      hazard: json['hazard'] ?? 'No Hazard Description',
      date: json['date'] ?? 'No Date',
    );
  }
}