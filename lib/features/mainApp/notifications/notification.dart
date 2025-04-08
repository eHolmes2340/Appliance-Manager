//File: notification.dart
//Programmer: Erik Holmes
//Date: Feb 19, 2025
//Description: This file will contain the notification page for the app.
import 'package:applianceCare/common/theme.dart';
import 'package:flutter/material.dart';

//Class: Notification
//Description: This class is used to create a notification page in the app.
class NotificationPage  extends StatefulWidget {
  const NotificationPage ({super.key});

  @override
  State<NotificationPage > createState() => _NotificationState();
}

//Class: _NotificationState
//Description: This class is used to create a notification page in the app.
class _NotificationState extends State<NotificationPage > {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.main_colour,
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text('No notifications available.'),
      ),
    );
  }
}

