import 'package:flutter/material.dart';
import 'features/auth/view/signup_screen.dart'; 

class Entrypoint extends StatelessWidget{
  const Entrypoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Appliance Manager', 
      theme:ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color.fromARGB(255, 25, 53, 193)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Appliance Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//Class: _MyHomePageState
//Description: This class will 
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Login button pressed
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Sign up button pressed 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}