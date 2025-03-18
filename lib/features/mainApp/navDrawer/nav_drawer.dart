import 'package:appliance_manager/common/theme.dart';
import 'package:appliance_manager/entrypoint.dart';
import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:appliance_manager/features/mainApp/dashboard/dashboard.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/Appliances/appliance.dart';

import 'package:appliance_manager/features/mainApp/navDrawer/license_page/license.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/profile_page/profile.dart';
import 'package:appliance_manager/features/mainApp/navDrawer/recalls_page/recall.dart';
import 'package:flutter/material.dart';
//import 'package:logger/logger.dart';

import 'recalls_page/model/recallClass.dart';


//Class      :NavDrawer
//Description: This class will create a navigation drawer for the appliance manager app
class NavDrawer extends StatelessWidget 
{
  final UserInformation userInfo; 

  const NavDrawer({Key? key, required this.userInfo}) : super(key: key);
  
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
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(userInfo: userInfo,))); //Passing the user information to the backend
            },
          ),

          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(validEmail: userInfo.email,)));
            },
          ),

          ListTile(
            leading:Icon(Icons.local_laundry_service),
            title: Text('Appliances'),
            onTap:()
            {
               Navigator.push(context, MaterialPageRoute(builder: (context) => Appliances(validEmail: userInfo.email,)));
            }
          ),
          
          // 
          ListTile(
            leading: Icon(Icons.warning),
            title: Text('Recalled Item'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RecallPage()));
            },
          ),

          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LicenseP(userInfo: userInfo,))); //Passing the user information to the backend
            },
          ),
          
          Align(
            alignment: Alignment.bottomLeft,
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {

                //Create a alert box asking if there are sure they want to logout. Then logout
                Navigator.push(context, MaterialPageRoute(builder: (context) => Entrypoint()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
