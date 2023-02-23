import 'package:capp/Screens/authScreen.dart';
import 'package:capp/Screens/conversationScreen.dart';
import 'package:capp/models/conversation.dart';
import 'package:capp/widget/conversation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat app',
      debugShowCheckedModeBanner: false,
      home: ConversationList(),
      theme: ThemeData(primarySwatch: Colors.blue, hintColor: null),
    );
  }
}
