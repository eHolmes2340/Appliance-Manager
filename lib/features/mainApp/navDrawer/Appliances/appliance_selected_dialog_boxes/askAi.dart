import 'package:applianceCare/common/theme.dart';
import 'package:applianceCare/features/mainApp/navDrawer/Appliances/model/appliance_information.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart'; // Import Gemini package
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // For dotenv

class AskAi extends StatefulWidget {
  final Appliance appliance;

  AskAi({super.key, required this.appliance});

  @override
  State<AskAi> createState() => _AskAiState();
}

class _AskAiState extends State<AskAi> {
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User", lastName: "User");
  ChatUser googleGeminiUser = ChatUser(id: "1", firstName: "Google", lastName: "Gemini");

  late Gemini gemini;

  @override
  void initState() {
    super.initState();

    // Load environment variables
    dotenv.load().then((_) {
      String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
      if (apiKey.isNotEmpty) {
        // Initialize Gemini client with API key
        gemini = Gemini.init(apiKey: apiKey); // Assuming the init method works
      } else {
        Logger().e('API key is missing in .env');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Google Gemini'),
        centerTitle: true,
        backgroundColor: AppTheme.main_colour,
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
      
    );
  }
  void _sendMessage(ChatMessage chatMessage) {
  setState(() {
    messages = [chatMessage, ...messages];
  });

  try {
    String question = chatMessage.text;
    String applianceInfomration = "Appliance Name: ${widget.appliance.applianceName}, Appliance Model: ${widget.appliance.model}, Brand: ${widget.appliance.brand}";  
    String fullQuestion = "Appliance: $applianceInfomration. Question: $question";  // Combine appliance info with question

    // Create Part object (Ensure 'Part' is correct and accepts 'text' as parameter)
    List<Part> parts = [
      Part.text(fullQuestion),  // Send the combined context and question to Gemini
    ];

    // Assuming 'prompt' is the correct API method for fetching a response
    gemini.prompt(parts: parts).then((response) {
      // Print the full response to inspect the structure
      Logger().d("Full response: $response");

      String answer = response?.content?.parts?.fold("", (previous, current) {
        Logger().d("Current part: ${current.toString()}");

        // Access the text from the TextPart
        String currentText = "";
        if (current is TextPart) {
          currentText = current.text;  // If 'text' exists, access it
        }
        return "$previous$currentText";

      }) ?? "No response";

      String applianceImage = widget.appliance.appilanceImageURL; 

      if(applianceImage == null)
      {
        ChatMedia media = ChatMedia(
        url: applianceImage,  // The image URL to display
        fileName: "google-gemini.webp",  // You can give a name to the image file
        type: MediaType.image,  // Specify that this is an image
       );
       // Create and send the response as a ChatMessage with the image
      ChatMessage message = ChatMessage(
        user: googleGeminiUser,
        createdAt: DateTime.now(),
        text: answer,
        medias: [media],  // Include the image media in the message
      );
      setState(() {
        messages = [message, ...messages];
      });

      }
      else {
        // Create and send the response as a ChatMessage with the image
      ChatMessage message = ChatMessage(
        user: googleGeminiUser,
        createdAt: DateTime.now(),
        text: answer,  // Include the image media in the message
      );
      setState(() {
        messages = [message, ...messages];
      });

      }

      // Create ChatMedia object for the image
     

      
      
    }).catchError((error) {
      Logger().e('Error with Gemini API: $error');
    });
  } catch (e) {
    Logger().e('Error sending message: $e');
  }
}


}
