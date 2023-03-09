import 'package:capp/API/getDetailApi.dart';
import 'package:capp/Screens/authScreen.dart';
import 'package:capp/Screens/conversationScreen.dart';
import 'package:capp/Screens/chatScreen.dart';

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
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        ConversationList.routeName: (ctx) => ConversationList(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
      },
    );
  }
}
