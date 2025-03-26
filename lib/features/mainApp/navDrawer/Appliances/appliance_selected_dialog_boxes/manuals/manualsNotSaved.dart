
import 'package:appliance_manager/common/obj/server_address.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/appliance_information.dart';

// Replace with your API URL
const String manualLibsUrl = 'https://www.manualslib.com/brand/';
 // Replace with your API URL

class ManualNotSavedWebView extends StatefulWidget {
  final Appliance appliance;
  
  const ManualNotSavedWebView({super.key, required this.appliance});

  @override
  State<ManualNotSavedWebView> createState() => _ManualNotSavedWebViewState();
}

class _ManualNotSavedWebViewState extends State<ManualNotSavedWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    const int sec = 2;
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            Future.delayed(const Duration(seconds: sec), () {
              _injectSearchQuery();
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(manualLibsUrl + widget.appliance.brand));
  }

  //Function   : _injectSearchQuery
  //Dcescription: 
  void _injectSearchQuery() {
    String model = widget.appliance.model;
    String brand=widget.appliance.brand;
    String jsScript = """
      (function() 
      {
        var searchBox = document.getElementById("typehead"); 
        if (searchBox) {
          searchBox.value = "$brand $model"; 

          setTimeout(function() {
            var enterEvent = new KeyboardEvent('keydown', { key: 'Enter', bubbles: true });
            searchBox.dispatchEvent(enterEvent);
          }, 500);
        }
      })();
    """;

    _controller.runJavaScript(jsScript);
  }

  Future<void> _saveManualUrl() async 
  {

    widget.appliance.manualURL = ''; 

    String? currentUrl = await _controller.currentUrl();
    if (currentUrl != null) 
    {
      try {
        final response = await http.post(
          Uri.parse(ServerAddress.saveManual), // Replace with your API URL
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "id": widget.appliance.userId,
            'brand': widget.appliance.brand,
            'model': widget.appliance.model,
            'manualUrl': currentUrl,
          }),
        );

        if (response.statusCode == 200)
       {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Manual saved successfully!')),
          );
        } 
        else
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save manual.')),
          );
        }
      }
      catch (e) 
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.appliance.brand} Manual"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed:() async{
              await _saveManualUrl();
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
