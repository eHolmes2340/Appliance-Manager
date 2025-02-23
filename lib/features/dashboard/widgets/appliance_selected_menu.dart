//File    : 
//Programmer : Erik Holmes

// ignore_for_file: non_constant_identifier_names

import 'package:appliance_manager/features/dashboard/model/appliance_information.dart';
import 'package:flutter/material.dart';
import 'appliance_selected_dialog_boxes/editApplianceDialogBox.dart';

//Functin    : appliance_selected_menu
//Description : This function will show a menu when an appliance is selected.
void appliance_selected_menu(BuildContext context, Offset position,Appliance appliance) async {

  final RenderBox overlay=Overlay.of(context).context.findRenderObject()as RenderBox; 

  final selectedOption=await showMenu(context: context, 
  position: RelativeRect.fromRect(Rect.fromPoints(position, position)
  ,Offset.zero&overlay.size), 
  items: [
    PopupMenuItem(value:'edit', child: Text('Edit')),
    PopupMenuItem(value: 'ask', child: Text('Ask-A.I for some help.')),
    PopupMenuItem(value: 'search', child :Text('Search for repair service in your area')),
    PopupMenuItem(value:'delete', textStyle: TextStyle(color: Colors.red), child: Text('Delete')),
  ]);
  // ignore: avoid_print
  if(selectedOption==null)
  {
    return;
  }
  //edit the appliance. 
  if(selectedOption=='edit')
  {
    //Bring up a dialog to edit the appliance  information 
    //Pass the appliance to the dialog box 
    editApplianceDialogBox(context, appliance); //appliance_selected_dialog_boxes/editApplianceDialogBox.dart
  }
  else if(selectedOption=='delete')
  {
    //Bring up a dialog box to confirm the deletion of the appliance
  }
  else if(selectedOption=='search')
  {
    print('search: ${appliance.applianceName}'); 
  }
  else
  if(selectedOption=='ask')
  {
    //Ask AI for help using A.I 
    print('ask: ${appliance.applianceName}'); 
  }
}