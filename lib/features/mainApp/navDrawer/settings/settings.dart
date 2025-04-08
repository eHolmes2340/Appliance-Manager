import 'package:applianceCare/common/theme.dart';
import 'package:applianceCare/features/auth/model/user_information.dart';
import 'package:applianceCare/features/mainApp/navDrawer/settings/profile_page/profile.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final UserInformation userInfo;

  SettingsPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _notificationsEnabled;

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = widget.userInfo.notificationsEnabled;
  }

  // Handle toggle changes
  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
      widget.userInfo.updateNotificationSetting(value); // Update the user info
    });
  }

  // Navigate to the Profile page and get updated user info
  void _goToProfile() async {
    final updatedUserInfo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Profile(userInfo: widget.userInfo),
      ),
    );

    // If the user info was updated, reload the page
    if (updatedUserInfo != null) {
      setState(() {
        widget.userInfo.firstName = updatedUserInfo.firstName;
        widget.userInfo.lastName = updatedUserInfo.lastName;
        widget.userInfo.postalCode = updatedUserInfo.postalCode;
        widget.userInfo.country = updatedUserInfo.country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppTheme.main_colour,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${widget.userInfo.firstName} ${widget.userInfo.lastName}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${widget.userInfo.email}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            // Edit Button to navigate to Profile page
            ElevatedButton(
              onPressed: _goToProfile,
              child: Text('Edit'),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Notifications Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Enable Notifications', style: TextStyle(fontSize: 18)),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: _toggleNotifications,
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
