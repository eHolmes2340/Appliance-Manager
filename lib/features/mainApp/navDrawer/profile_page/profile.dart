//File Name: profile.dart
//Programmer: Erik Holmes
//Date: Feb 19, 2025
//Description: This file will contain the profile page for the appliance manager project

import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:appliance_manager/features/mainApp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';


//Class       :Profile
//Description : This class will create the profile page for the user
class Profile extends StatefulWidget {
  final UserInformation userInfo;
  
  const Profile({Key? key, required this.userInfo}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

//Class : _ProfileState
//Description : This class will create the state for the profile page
class _ProfileState extends State<Profile> 
{
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _postalCodeController;
  late TextEditingController _countryController;
  
  
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userInfo.firstName);
    _emailController = TextEditingController(text: widget.userInfo.email);
    _postalCodeController = TextEditingController(text: widget.userInfo.postalCode);
    _countryController = TextEditingController(text: widget.userInfo.country);
  }

  @override
  void dispose()
  {
    _nameController.dispose();
    _emailController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  //Function  :_editField
  //Description : This function will allow the user to edit the fields in the profile page
  void _editField(TextEditingController controller, String label) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $label"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      drawer: NavDrawer(userInfo: widget.userInfo),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "First Name"),
                    readOnly: true,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editField(_nameController, "Name"),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Email"),
                    readOnly: true,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editField(_emailController, "Email"),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _postalCodeController,
                    decoration: InputDecoration(labelText: "Postal Code"),
                    readOnly: true,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editField(_postalCodeController, "Postal Code"),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _countryController,
                    decoration: InputDecoration(labelText: "Country"),
                    readOnly: true,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editField(_countryController, "Country"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
