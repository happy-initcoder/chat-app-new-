import 'package:capp/API/getDetailApi.dart';
import 'package:capp/widget/conversation.dart';
import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({super.key});

  static const routeName = '/Conversation-list';

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(), child: GetDetailsAPI.callFun()),
    );
  }
}
