import 'package:applianceCare/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../model/appliance_information.dart';

 // Replace with your API URL


class ManualSavedWebView extends StatefulWidget {
  final Appliance appliance;

  const ManualSavedWebView({super.key, required this.appliance});

  @override
  State<ManualSavedWebView> createState() => _ManualSavedWebViewState();
}

class _ManualSavedWebViewState extends State<ManualSavedWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            Future.delayed(const Duration(seconds: 2), () {
              _injectSearchQuery();
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.appliance.manualURL));
  }

  void _injectSearchQuery() {
    String model = widget.appliance.model;
    String jsScript = """
      (function() {
        var searchBox = document.getElementById("typehead"); 
        if (searchBox) {
          searchBox.value = "$model"; 

          setTimeout(function() {
            var enterEvent = new KeyboardEvent('keydown', { key: 'Enter', bubbles: true });
            searchBox.dispatchEvent(enterEvent);
          }, 500);
        }
      })();
    """;

    _controller.runJavaScript(jsScript);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.main_colour,
      appBar: AppBar(
        title: Text("${widget.appliance.brand} Manual"),
        
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
