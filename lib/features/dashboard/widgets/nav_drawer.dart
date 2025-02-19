import 'package:flutter/material.dart';

//Class      :NavDrawer
//Description: This class will create
class NavDrawer extends StatelessWidget
{

  
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Appliance Manager'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            title: Text('Add Appliance'),
            onTap: () {
              Navigator.pushNamed(context, '/add_appliance');
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}