import 'package:flutter/material.dart';
import 'component/my_drawer.dart';

class AdminChatBot extends StatefulWidget {
  const AdminChatBot({super.key});

  @override
  State<AdminChatBot> createState() => _AdminChatBotState();
}

class _AdminChatBotState extends State<AdminChatBot> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'user': text});
      _controller.clear();
      // Simulating a response from the bot
      _messages.add({'bot': _generateBotResponse(text)});
    });
  }

  String _generateBotResponse(String userMessage) {
    // This function generates a basic response based on the user's message
    if (userMessage.toLowerCase().contains('help')) {
      return 'How can I assist you with your ICT needs?';
    } else if (userMessage.toLowerCase().contains('network')) {
      return 'It looks like you need help with networking. Please check your connection and restart your router.';
    } else if (userMessage.toLowerCase().contains('software')) {
      return 'If you are facing software issues, please make sure your applications are updated.';
    } else if (userMessage.toLowerCase().contains('hardware')) {
      return 'For hardware problems, ensure all cables are connected properly and your device is powered on.';
    } else {
      return 'I am here to help with ICT-related issues. Could you please provide more details?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'ICT Help ChartBot',
          style: TextStyle(color: Colors.lightBlue),
        ),
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message.containsKey('user')) {
                  return _buildUserMessage(message['user']!);
                } else {
                  return _buildBotMessage(message['bot']!);
                }
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildUserMessage(String message) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBotMessage(String message) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.lightBlue),
            onPressed: () {
              _sendMessage(_controller.text);
            },
          ),
        ],
      ),
    );
  }
}
