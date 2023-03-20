import 'package:capp/Screens/chatScreen.dart';
import 'package:flutter/material.dart';

class Messagemodel extends ChangeNotifier {
  Messagemodel({
    // required this.to,
    required this.from,
    required this.text,
    // required this.id,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.v,
  });

  // String to;
  String from;
  List<String> text;
  // String id;
  // DateTime createdAt;
  // DateTime updatedAt;
  // int v;

  factory Messagemodel.fromJson(Map<String, dynamic> json) => Messagemodel(
        // to: json["to"],
        from: json["from"],
        text: List<String>.from(json["text"].map((x) => x)),
        // id: json["_id"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        // v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        // "to": to,
        "from": from,
        "text": List<dynamic>.from(text.map((x) => x)),
        // "_id": id,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        // "__v": v,
      };
}

class AppendMessage extends ChangeNotifier {
  static String? dataId;
  static String? dataText;
  static List<Messagemodel> messageList = [];

  addNewMessage(message, id) {
    print(id);
    String? senderId;
    String? text;
    senderId = id;
    text = text;
    messageList.add(Messagemodel(
      from: id.toString(),
      text: [message.toString()],
    ));
    // senderId = null;
    // text = null;

    // print('this is sender id ${senderId.toString()}');
    // print('message is this  ${text.toString()}');
    notifyListeners();
  }
}
