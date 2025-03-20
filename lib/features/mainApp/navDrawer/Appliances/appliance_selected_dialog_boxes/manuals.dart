import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../model/appliance_information.dart';

//Class     : ManualWebViewState
//Description: This class will show the manual of the appliance in a webview.
class ManualWebView extends StatefulWidget
{
  final String manualUrl;
  
  const ManualWebView({super.key, required this.manualUrl});

  @override
  State<ManualWebView> createState() => _ManualWebViewState();
}


class _ManualWebViewState extends State<ManualWebView>
{
  late final WebViewController _controller;

  @override
  void initState() 
  {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.manualUrl));
  }



}



// ipconfig getifaddr en0