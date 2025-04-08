//File        : fetchRecallProductImage.dart
//Programmer  : Erik Holmes
//Last Updated: 03/25/2025
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


//Function    : fetchRecallProductImage
//Description : This function is used to fetch the product image of the recall.
Future<String> getApplianceImage(String query) async {
  final String apiKey = dotenv.env['GOOGLE_CUSTOM_SEARCH_API_KEY']!;
  final String cx = dotenv.env['GOOGLE_CUSTOM_SEARCH_CX']!;

  // Prepare the URL for the API request
  final url =
    'https://www.googleapis.com/customsearch/v1?q=$query&cx=$cx&searchType=image&key=$apiKey';

  // Send GET request to Google Custom Search API
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // Log the full response for debugging

    if (data['items'] != null && data['items'].isNotEmpty) {
      // Check if the 'link' in the first item is an image URL
      final imageUrl = data['items'][0]['link'];
      if (imageUrl.contains('.jpg') || imageUrl.contains('.png') || imageUrl.contains('.jpeg')) {
        return imageUrl;  // Return the valid image URL
      } 
      else {
        
        return '';  // Return empty if the URL is not an image
      }
    } 
    else {
      return '';  // No image results
    }
  } else {
    return '';  // Error fetching image
  }
}

