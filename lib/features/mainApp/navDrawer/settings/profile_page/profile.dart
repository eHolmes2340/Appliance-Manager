import 'package:applianceCare/common/theme.dart';
import 'package:applianceCare/features/auth/model/user_information.dart';
import 'package:flutter/material.dart';
import 'services/sendNewUserInformation.dart';

class Profile extends StatefulWidget {
  final UserInformation userInfo;

  const Profile({Key? key, required this.userInfo}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _postalCodeController;
  late TextEditingController _countryController;
  bool _isEditing = false;

  late UserInformation updatedUserInfo;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.userInfo.firstName);
    _lastNameController = TextEditingController(text: widget.userInfo.lastName);
    _postalCodeController = TextEditingController(text: widget.userInfo.postalCode);
    _countryController = TextEditingController(text: widget.userInfo.country);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  // Function to save profile and return updated information
  void _saveProfile() async {
    setState(() {
      _isEditing = false;
    });

    // Prepare updated user information
    updatedUserInfo = UserInformation(
      id: widget.userInfo.id,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: widget.userInfo.email, // Keep the existing email
      postalCode: _postalCodeController.text,
      country: _countryController.text,
      freeAccount: widget.userInfo.freeAccount,
      accountVerified: widget.userInfo.accountVerified,
    );

    // Send user information to the backend
    bool changeStatus = await sendNewUserInformation(updatedUserInfo);

    if (changeStatus == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error updating profile")));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile updated successfully!")));

    // Return the updated user info back to SettingsPage
    Navigator.pop(context, updatedUserInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        foregroundColor: const Color.fromARGB(255, 14, 7, 7),
        backgroundColor: AppTheme.main_colour,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: _isEditing ? _saveProfile : _toggleEdit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_firstNameController, "First Name", _isEditing),
            SizedBox(height: 16),
            _buildTextField(_lastNameController, "Last Name", _isEditing),
            SizedBox(height: 16),
            _buildTextField(_postalCodeController, "Postal Code", _isEditing),
            SizedBox(height: 16),
            _buildTextField(_countryController, "Country", _isEditing),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool enabled) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey[200],
      ),
    );
  }
}
