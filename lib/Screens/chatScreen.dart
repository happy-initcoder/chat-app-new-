import 'dart:io';

import 'package:capp/API/firendCollection.dart';
import 'package:capp/API/getDetailApi.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const routeName = '/Chat-Screen';
  //  final List<GetDetailsAPI>? singleUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
          // color: Colors.red,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Message...',
                  ),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
