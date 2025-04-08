import 'dart:convert';
import 'package:applianceCare/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../widgets/show_repair_service_dialog.dart'; 

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repair Services Nearby', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        backgroundColor: AppTheme.main_colour,
        elevation: 4,
      ),
      body: repairCompanies.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppTheme.main_colour),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: repairCompanies.length,
              itemBuilder: (context, index) {
                final company = repairCompanies[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  child: InkWell(
                    onTap: () {
                      // Handle tap on company
                      showRepairServiceDialog(context, company);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            company["name"] ?? "Unknown",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.main_colour,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 18, color: Colors.grey),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  company["address"] ?? "No address available",
                                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 18, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                company["phone"] ?? "Loading...",
                                style: TextStyle(color: Colors.grey[700], fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.web, size: 18, color: Colors.grey),
                              SizedBox(width: 4),
                              // Truncate long URLs with ellipsis
                              Expanded(
                                child: Text(
                                  company["website"] ?? "Loading...",
                                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,  // Allow only one line for the URL
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
