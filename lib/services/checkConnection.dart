
//File      : checkConnection.dart
//Programmer: Erik Holmes
//Date      : Feb 15, 2025
//Description: This file will contain the class to check the connection to the backend
import 'dart:async'; 
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import '../common/server_address.dart';
import 'package:flutter/foundation.dart';

//Class       :Checkconnection
//Description : This class will check the connection to the backend
class Checkconnection {
  Timer? _timer; 
  final int _timeout = 10; 
  static bool isConnected = false;

  //Function  :startCheckingConnection
  //Description : This function will start the timer to check the connection to the backend
  void startCheckingConnection(){
    _timer=Timer.periodic(Duration(seconds:_timeout), (timer) async {
      bool isConnected=await checkBackendConnection(); 

      debugPrint('Backend Connection: ${isConnected ? "Online" : "Offline"}');
    });
  }

  //Function  :stopCheckingConnection
  //Description : This function will stop the timer from checking the connection 
  void stopCheckingConnection()
  {
    _timer?.cancel(); 
  }

  //Function  :checkBackendConnection
  //Description : This function will check the connection to the backend
  static Future<bool> checkBackendConnection() async {
  try {
    final response = await http.get(Uri.parse('${ServerAddress.forCheckingConnection}')); 
      // Set timeout to avoid waiting too long
    if (response.statusCode == 200) {
      isConnected = true;
      return true;
    } else {
      isConnected = false;
      return false;
    }
  } 
  on SocketException {
    debugPrint("SocketException: No internet connection or backend is down.");
    isConnected = false;
    return false;
  } 
  on TimeoutException {
    debugPrint("TimeoutException: Backend did not respond in time.");
    isConnected = false;
    return false;
  } 
  catch (e) {
    debugPrint("Unexpected error: $e");
    isConnected = false;
    return false;
  }
}


  //Function  :callbackDispatcher
  //Description : This function will dispatch the callback to the workmanager
  static void callbackDispatcher() {
      Workmanager().executeTask((task, inputData) async {
        bool isConnected = await checkBackendConnection();
        debugPrint("Backend Status (Background): ${isConnected ? "Online" : "Offline"}");
        return Future.value(true);
      });
  } 
//Function  :setupWorkManager
  //Description : This function will setup the workmanager
 static void setupWorkManager() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    Workmanager().registerPeriodicTask(
      "backendCheckTask", 
      "checkBackend",
      frequency: Duration(minutes: 1), // Runs every 1 minute
    );
  }
}
