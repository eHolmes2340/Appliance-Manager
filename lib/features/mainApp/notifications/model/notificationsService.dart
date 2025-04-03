import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  // Singleton pattern
  static final NotificationsService _instance = NotificationsService._internal();
  factory NotificationsService() => _instance;
  NotificationsService._internal();

  // Declare the plugin as a class field
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Android initialization settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
 
    // iOS initialization settings
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    // Initialization settings for both platforms
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tapped logic here if needed.
      },
    );
  }

  /// Show a local notification with given title and body.
  Future<void> showNotifiacation({
    required String title,
    required String body,
    int notificationId = 0,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'your_channel_id', // Channel ID
      'Your Channel Name', // Channel Name
      channelDescription: 'Your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Show the notificatio
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      details,
      payload: 'Custom_Payload',
    );
  }
}
