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
      senderId: message['message'],
      text: message['senderUsername'],
    );
  }
}

class MessageProvider extends ChangeNotifier {
  final List<MessageSocket> _SocketMessage = [];

  List<MessageSocket> get SocketMessage => _SocketMessage;

  addNewMessage(MessageSocket message) {
    _SocketMessage.add(message);
    notifyListeners();
  }
}
