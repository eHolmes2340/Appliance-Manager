import 'dart:convert';
import 'package:appliance_manager/common/obj/server_address.dart';
import 'package:http/http.dart' as http;

class NotificationItem {
  final int id;
  final String type;
  final String title;
  final String message;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      isRead: json['isRead'] == 1,
    );
  }
}


Future<List<NotificationItem>> fetchNotifications(int userId,String notificationTypeUrl) async {
  final response = await http.get(Uri.parse('$notificationTypeUrl$userId')); // Use the correct URL for fetching notifications


  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => NotificationItem.fromJson(json)).toList();
  } 
  else {
    throw Exception("Failed to fetch notifications");
  }
}
