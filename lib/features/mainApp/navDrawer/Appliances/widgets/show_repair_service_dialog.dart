import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

//Function  : showRepairServiceDialog
//Description: This function will show a dialog with the repair service details.
void showRepairServiceDialog(BuildContext context, Map<String, dynamic> company) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(company["name"] ?? "Unknown"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Address: ${company["address"]}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Phone: ${company["phone"] ?? "Loading..."}")),
                IconButton(
                  icon: Icon(Icons.call, color: Colors.green),
                  onPressed: () => _makePhoneCall(company["phone"]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Website: ${company["website"] ?? "Loading..."}")),
                IconButton(
                  icon: Icon(Icons.web, color: Colors.blue),
                  onPressed: () => _openWebsite(company["website"]),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}

//Function    : _makePhoneCall
//Description : This function will make a phone call to the given phone number.
Future<void> _makePhoneCall(String? phoneNumber) async {
  if (phoneNumber != null && phoneNumber.isNotEmpty && phoneNumber != "N/A") {
    final Uri phoneUri = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw "Could not launch $phoneUri";
    }
  }
}

//Function    : _openWebsite
//Description : This function will open the given website URL in the default browser.
Future<void> _openWebsite(String? websiteUrl) async {
  if (websiteUrl != null && websiteUrl.isNotEmpty && websiteUrl != "N/A") {
    final Uri webUri = Uri.parse(websiteUrl);
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $webUri";
    }
  }
}
