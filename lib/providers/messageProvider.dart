import 'dart:io';

import 'package:flutter/material.dart';

class MessageSocket {
  late String senderId;
  late String text;

  MessageSocket({
    required this.senderId,
    required this.text,
  });

  factory MessageSocket.fromJson(Map<String, dynamic> message) {
    return MessageSocket(
      senderId: message['senderId'],
      text: message['text'],
    );
  }
}

class MessageProvider extends ChangeNotifier {
  final List<MessageSocket> _SocketMessage = [];
  static List<MessageSocket> newMessages = [];

  List<MessageSocket> get SocketMessage => _SocketMessage;

  static void addNewMessage(MessageSocket message) {
    // _SocketMessage.add(message);
    newMessages.add(message);
    print(newMessages);
    // print(SocketMessage);
    // notifyListeners();
  }
}
