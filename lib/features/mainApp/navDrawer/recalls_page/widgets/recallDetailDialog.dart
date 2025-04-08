import 'package:applianceCare/common/getApplianceImages.dart';
import 'package:flutter/material.dart';
import 'package:applianceCare/features/mainApp/navDrawer/recalls_page/model/recallClass.dart';

//Function    : showRecallDetailsDialog
//Description : This function is used to show the recall details dialog when a recall is clicked.
void showRecallDetailsDialog(Recall recall, BuildContext context) async {
  // Fetch the image URL first
  String imageURL = await getApplianceImage(recall.product_name);

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // You can call setState if you want to change any variables here later
          return AlertDialog(
            title: Text(recall.recall_heading, style: TextStyle(fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📅 Recall Date: ${recall.recall_date}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('📦 Product Name:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(recall.product_name),
                  SizedBox(height: 8),
                  Text('🚨 Hazard Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(recall.hazard_description),
                  SizedBox(height: 8),
                  
                  // Display the image if the imageURL is not empty
                  if (imageURL.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.network(imageURL),  // Display the image
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close', style: TextStyle(color: Colors.blue)),
              ),
            ],
          );
        },
      );
    },
  );
}