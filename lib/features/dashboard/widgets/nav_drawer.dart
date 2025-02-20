import 'package:appliance_manager/common/theme.dart';
import 'package:flutter/material.dart';
import '../../auth/view/login/login.dart';

//Class      :NavDrawer
//Description: This class will create a navigation drawer for the appliance manager app
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Appliance Manager',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            decoration: BoxDecoration(
              color: AppTheme.main_colour,
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Appliance'),
            onTap: () {
              Navigator.pushNamed(context, '/add_appliance');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Screen()));
            },
          ),
        ],
      ),
    );
  }
}
