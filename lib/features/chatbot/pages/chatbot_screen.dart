import 'dart:async';

import 'package:flutter/material.dart';


import '../models/models.dart';
import '/display/display.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _botMessages = const [
    Message(message: "What is your favorite hobby?", isFromUser: false),
    Message(message: "Can you tell me about your day?", isFromUser: false),
    Message(message: "What inspires you the most?", isFromUser: false),
    Message(message: "Do you enjoy traveling? Why?", isFromUser: false),
    Message(message: "What’s your favorite kind of music?", isFromUser: false),
    Message(message: "Can you describe your ideal weekend?", isFromUser: false),
    Message(
        message: "What’s the most interesting fact you know?",
        isFromUser: false),
    Message(
        message:
            "If you could learn one new skill instantly, what would it be?",
        isFromUser: false),
    Message(message: "What’s your favorite book or movie?", isFromUser: false),
    Message(
        message: "Do you like cooking? What's your favorite dish?",
        isFromUser: false),
  ];

  // Stores all chat messages (both user and bot)
  final List<Message> _messages = [];

  int _botMessageIndex = 0;

  bool _isBotTyping = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  //Meant to fetch user's name
  void _fetchUser() {
    setState(() {
      _messages.add(const Message(
          message: "Hi Eugene\nHow may I help you?", isFromUser: false));
    });
  }

  void _scrollToBottom() {
    if(_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    String userMessage = _messageController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add(Message(message: userMessage, isFromUser: true));
      _isBotTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    if (_botMessageIndex < _botMessages.length) {
      Timer(const Duration(seconds: 3), () {
        setState(() {
          _messages.add(_botMessages[_botMessageIndex]);
          _botMessageIndex++;
          _isBotTyping = false;
        });
        _scrollToBottom();
      });
    } else {
      setState(() {
        _isBotTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Chat with Akili Doctor 🤖",
              style: theme.textTheme.titleLarge,
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message.isFromUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: message.isFromUser
                            ? MainAxisAlignment.end 
                            : MainAxisAlignment
                                .start, 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Show icon for bot messages
                          if (!message.isFromUser)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                CustomIcons.robot,   
                                size: 30,
                                color: theme.colorScheme.primary,                             
                              ),
                            ),
                          // Message container
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: message.isFromUser
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              message.message,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: message.isFromUser
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          // Show icon for user messages
                          if (message.isFromUser)
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.person, 
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
              child: Row(
                children: [
                  if (!_isBotTyping) ...[
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Chat with Akili Doctor...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.send,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ] else
                    Expanded(
                      child: Center(
                        child: FadeTransition(
                          opacity: _animationController,
                          child: Text(
                            "Akili Doctor is typing...",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
