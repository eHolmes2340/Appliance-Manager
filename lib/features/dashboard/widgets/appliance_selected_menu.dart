//File    : 
//Programmer : Erik Holmes

// ignore_for_file: non_constant_identifier_names

import 'package:appliance_manager/features/dashboard/model/appliance_information.dart';import 'package:appliance_manager/features/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'appliance_selected_dialog_boxes/editApplianceDialogBox.dart';
import 'package:logger/logger.dart';
 



//Function    : appliance_selected_menu
//Description : This function will show a menu when an appliance is selected.
void appliance_selected_menu(BuildContext context, Offset position, Appliance appliance,Future<void> Function(int)reloadList) async {
  if (!context.mounted) return;
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  final selectedOption = await showMenu(
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromPoints(position, position),
      Offset.zero & overlay.size,
    ),
    items: [
      const PopupMenuItem(value: 'edit', child: Text('Edit')),
      const PopupMenuItem(value: 'ask', child: Text('Ask A.I for some help')),
      const PopupMenuItem(value: 'search', child: Text('Search for repair service in your area')),
      const PopupMenuItem(value: 'delete', textStyle: TextStyle(color: Colors.red), child: Text('Delete')),
    ],
  );

  if (selectedOption == null)
  {
    return;
  }
if (selectedOption == 'edit') {
  editApplianceDialogBox(context, appliance, () {
    if (context.mounted) {
      Logger().i('Reloading appliance list');
      reloadList(appliance.userId);
    }
  });
}
 else if (selectedOption == 'delete')
  {
    // Bring up a dialog box to confirm the deletion of the appliance
  } 
  else if (selectedOption == 'search') 
  {
    print('search: ${appliance.applianceName}');
  } 
  else if (selectedOption == 'ask') 
  {
    // Ask AI for help using AI 
    print('ask: ${appliance.applianceName}');
  }
}
