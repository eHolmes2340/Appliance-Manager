import 'dart:convert';
import 'package:appliance_manager/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

//Class       :RepairCompanies
//Description : This class will show the repair companies in the area.
class RepairCompanies extends StatefulWidget {
  final String? postalCode;

  const RepairCompanies({super.key, required this.postalCode});

  @override
  _RepairCompaniesState createState() => _RepairCompaniesState();
}

//Class       :_RepairCompaniesState
//Description : This class will create a list 
class _RepairCompaniesState extends State<RepairCompanies> {
  List<Map<String, dynamic>> repairCompanies = [];
  final String googlePlacesApiKey = dotenv.env['GOOGLE_PLACES_API_KEY']!;

  @override
  void initState() {
    super.initState();
    fetchRepairCompanies();
  }

  //Function    :fetchRepairCompanies 

  //Description : This function will fetch the repair companies in the area.
  Future<void> fetchRepairCompanies() async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?"
        "query=appliance+repair+in+${widget.postalCode}"
        "&key=$googlePlacesApiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List places = data['results'];

        // Limit to first 15 repair companies
        setState(() {
          repairCompanies = places.take(15).map((place) {
            return {
              'name': place['name'],
              'address': place['formatted_address'],
              'rating': place['rating'],
              'place_id': place['place_id'],
            };
          }).toList();
        });

        fetchContactDetails();
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> fetchContactDetails() async {
    for (var company in repairCompanies) {
      final String detailsUrl =
          "https://maps.googleapis.com/maps/api/place/details/json?"
          "place_id=${company["place_id"]}"
          "&fields=name,formatted_phone_number,formatted_address,website"
          "&key=$googlePlacesApiKey";
      try 
      {
        final response = await http.get(Uri.parse(detailsUrl));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data == null || !data.containsKey("result") || data["result"] == null)
           {
            continue;
          }

          final result = data["result"];
          setState(() {
            company["phone"] = result["formatted_phone_number"] ?? "N/A";
            company["website"] = result["website"] ?? "N/A";
          });
        } else {
          Logger().e("Failed to fetch details for ${company["name"]}");
        }
      } 
      catch (e) 
      {
        Logger().e(e);
      }
    }
  }

  @override
  void dispose() {
    // Clean up any resources if needed (e.g., cancel ongoing API requests)
    // For now, nothing specific to clean up in this code.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Repair Services'),
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.main_colour,
      ),
      body: repairCompanies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: repairCompanies.length,
              itemBuilder: (context, index) {
                final company = repairCompanies[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      company["name"] ?? "Unknown",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address: ${company["address"]}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          "Phone: ${company["phone"] ?? "Loading..."}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          "Website: ${company["website"] ?? "Loading..."}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle tap on company
                    },
                  ),
                );
              },
            ),
    );
  }
}
