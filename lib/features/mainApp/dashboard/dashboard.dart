import 'package:appliance_manager/features/auth/model/user_information.dart';
import 'package:appliance_manager/features/mainApp/widgets/nav_drawer.dart';
import 'package:appliance_manager/services/get_userInformation.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart'; // Import CSV parsing package
import 'services/recalled_appliances.dart';

class Dashboard extends StatefulWidget {
  final String validEmail; // Holds the user email from the login screen.
  const Dashboard({super.key, required this.validEmail});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  UserInformation? userInfo;
  List<Map<String, String>> recalls = []; // Holds the recalls data
  bool isLoadingUser = true;
  bool isLoadingRecalls = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadCSVData();
  }

  // Fetches user profile data
  Future<void> _loadUserInfo() async {
    try {
      userInfo = await retrieveUserProfile(widget.validEmail);
      debugPrint("User info loaded: $userInfo");
    } catch (e) {
      debugPrint("Error fetching user info: $e");
    }

    setState(() {
      isLoadingUser = false;
    });

    if (userInfo == null) {
      _showErrorDialog();
    }
  }

  // Function to load CSV data
  Future<void> _loadCSVData() async {
    // Fetch the CSV data from the backend
    List<String> lines = await fetchRecalls();  // This method should return all the data

    if (lines.isNotEmpty) {
      try {
        // Parse the CSV data
        List<List<dynamic>> csvData = const CsvToListConverter(eol: "\n", fieldDelimiter: ",").convert(lines.join("\n"));
        
        if (csvData.isNotEmpty) {
          // Assume first row is header (line[0])
          List<String> headers = csvData[0].map((e) => e.toString()).toList();

          // Parse each row (starting from line[1]) into a map with only the required fields
          List<Map<String, String>> parsedRecalls = [];
          for (int i = 1; i < csvData.length; i++) {
            List<dynamic> row = csvData[i];

            Map<String, String> recallEntry = {
              'Product Safety Warning Number': row[headers.indexOf('Product Safety Warning Number')].toString(),
              'Product Name': row[headers.indexOf('Name of product')].toString(),
              'Hazard Description': row[headers.indexOf('Hazard Description')].toString(),
              'Date': row[headers.indexOf('Date')].toString(),
            };
            parsedRecalls.add(recallEntry);
          }

          setState(() {
            recalls = parsedRecalls;
          });
        }
      } catch (e) {
        debugPrint("Error parsing recall CSV: $e");
      }
    }

    setState(() {
      isLoadingRecalls = false;
    });
  }

  // Displays an error dialog if user info is null
  void _showErrorDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error Code: 404'),
            content: const Text('Servers are currently down'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Return to previous screen
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
 
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Dashboard')),
    body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Recent Appliance Recalls:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          isLoadingRecalls
              ? const Center(child: CircularProgressIndicator())
              : recalls.isEmpty
                  ? const Center(child: Text("No recall data available"))
                  : Column(
                      children: recalls.map<Widget>((recall) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(recall['Product Safety Warning Number'] ?? 'No Product Safety Warning Number'),
                            subtitle: Text('Date: ${recall['Date'] ?? 'N/A'}'),
                            trailing: Text('Hazard: ${recall['Hazard Description'] ?? 'No Hazard Description'}'),
                            isThreeLine: true,
                          ),
                        );
                      }).toList(),
                    ),
        ],
      ),
    ),
  );
}

}





