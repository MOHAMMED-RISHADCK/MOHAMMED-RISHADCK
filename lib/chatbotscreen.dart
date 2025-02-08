import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

class AIChatBotScreen extends StatefulWidget {
  const AIChatBotScreen({super.key});

  @override
  _AIChatBotScreenState createState() => _AIChatBotScreenState();
}

class _AIChatBotScreenState extends State<AIChatBotScreen> {
  List<Map<String, dynamic>> _messages = []; // Stores messages (user and bot)
  final TextEditingController _controller = TextEditingController();

  // Simulate chatbot response using the API
  void _sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    // Call the chatbot API with user input
    _messages = await chatbotApi(userMessage, context);

    // Optionally, you could handle the response here if needed.
    // For now, you might want to handle bot responses from the API.
    // For simplicity, we'll simulate a response after sending the message.
    // Future.delayed(const Duration(seconds: 1), () {
    //   String botResponse = "I'm processing your request..."; // Placeholder
    setState(() {});

    // });

    _controller.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sendMessage('Hello');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chatbot'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Chat Messages List
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                // final isUser = message['sender'] == 'user';

                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12.0),
                            topRight: const Radius.circular(12.0),
                            bottomLeft: const Radius.circular(12.0),
                            bottomRight: const Radius.circular(0.0),
                          ),
                        ),
                        child: Text(
                          message['user_query']!,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12.0),
                            topRight: const Radius.circular(12.0),
                            bottomLeft: const Radius.circular(0.0),
                            bottomRight: const Radius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          message['chatbot_response']!,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    )
                  ],
                );

                // Align(
                //   alignment:
                //       isUser ? Alignment.centerRight : Alignment.centerLeft,
                //   child: Container(
                //     margin: const EdgeInsets.symmetric(vertical: 8.0),
                //     padding: const EdgeInsets.all(12.0),
                //     decoration: BoxDecoration(
                //       color: isUser ? Colors.blue[100] : Colors.grey[200],
                //       borderRadius: BorderRadius.only(
                //         topLeft: const Radius.circular(12.0),
                //         topRight: const Radius.circular(12.0),
                //         bottomLeft: isUser
                //             ? const Radius.circular(12.0)
                //             : const Radius.circular(0.0),
                //         bottomRight: isUser
                //             ? const Radius.circular(0.0)
                //             : const Radius.circular(12.0),
                //       ),
                //     ),
                //     child: Text(
                //       message['message']!,
                //       style: TextStyle(
                //         fontSize: 16.0,
                //         color: isUser ? Colors.black : Colors.black87,
                //       ),
                //     ),
                //   ),
                // );
              },
            ),
          ),
          const Divider(height: 1),
          // Input Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    onSubmitted: (text) => _sendMessage(text),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.blueAccent,
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> chatbotApi(
    String data, BuildContext context) async {
  try {
    final response =
        await Dio().post('$baseUrl/chatbotapi', data: {'query': data});
    print("EEEEE$response");
    int? res = response.statusCode;
    print(res);

    if (res == 201) {
      print('Chatbot response successful');
      return List<Map<String, dynamic>>.from(response.data['chat_history']);
      // Here, you can handle the response and update the chatbot UI if necessary.
    } else {
      print('Failed to get response');
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}
