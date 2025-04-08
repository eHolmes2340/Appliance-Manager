//File       : appliance_manager/lib/features/dashboard/widgets/appliance_selected_menu.dart
//Programmer : Erik Holmes
//Date       : Feb 19, 2025
//Description: This file will contain the menu that will appear when an appliance is selected


import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance_selected_dialog_boxes/manuals/manualsNotSaved.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance_selected_dialog_boxes/manuals/manualsSaved.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance_selected_dialog_boxes/askAi.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance_selected_dialog_boxes/deleteApplianceDialogBox.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/appliance_selected_dialog_boxes/searchRepairServices.dart';
import 'package:applianceCare/features/mainApp/dashboard/widgets/viewApplianceInfoDialog.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/widgets/viewApplianceInAppliancePage.dart';
import 'package:flutter/material.dart';
import '../appliance_selected_dialog_boxes/editApplianceDialogBox.dart';



//Function    : appliance_selected_menu
//Description : This function will show a menu when an appliance is selected.
// ignore: non_constant_identifier_names
void appliance_selected_menu(BuildContext context, Offset position, Appliance appliance,Future<void> Function(int)reloadList,String? postalCode,String email) async
 {
  if (!context.mounted) return;
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  final selectedOption = await showMenu(
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromPoints(position, position),
      Offset.zero & overlay.size,
    ),
    items: [
      const PopupMenuItem(value: 'View appliance details', child: Text('View appliance details')),
      const PopupMenuItem(value: 'ask', child: Text('Ask A.I for some help')),
      const PopupMenuItem(value: 'search', child: Text('Search for repair service in your area')),
      const PopupMenuItem(value: 'delete', textStyle: TextStyle(color: Colors.red), child: Text('Delete')),
    ],
  );

  if (selectedOption == null)
  {
    return;
  }
  if (selectedOption == 'View appliance details') {
    // ignore: use_build_context_synchronously
   viewApplianceDialogAppliance(appliance, context, reloadList,email);
  }
  else if (selectedOption == 'delete')
  {
    //Call delete appliance dialog box asking for confirmation
    // ignore: use_build_context_synchronously
    showDeleteConfirmationDialog(context, appliance, reloadList); 
  } 

  else if (selectedOption == 'search') 
  {
    // ignore: use_build_context_synchronously
    Navigator.push(context,
   MaterialPageRoute(builder: (context) =>RepairCompanies(postalCode: postalCode)));
  } 
  else if (selectedOption == 'ask') 
  {
   // ignore: use_build_context_synchronously
   Navigator.push(context,
   MaterialPageRoute(builder: (context) =>AskAi(appliance: appliance)));
  }
}
