//File      : main.dart
//Programmer: Erik Holmes
//Date      : January 20, 2024
//Description: This is the main appliaction of the appliance manager mobile app.

import 'package:flutter/material.dart';
import 'entrypoint.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const Entrypoint());
}
