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
  void initState() {
    super.initState();
    GetDetailsAPI.callFun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
      ),
      // body: ListView.builder(
      //     itemCount: GetDetailsAPI.listResponse?.length,
      //     itemBuilder: (BuildContext context, index) {
      //       return Card(
      //         child: Container(
      //           width: double.infinity,
      //           padding: EdgeInsets.all(10),
      //           child: Text('${GetDetailsAPI.listResponse?[index].username}'),
      //           // Text("index${index}")
      //         ),
      //       );
      //     }),
    );
  }
}
