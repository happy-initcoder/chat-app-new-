import 'package:capp/Screens/chatScreen.dart';
import 'package:flutter/material.dart';

class Messagemodel extends ChangeNotifier {
  Messagemodel({
    required this.to,
    required this.from,
    required this.text,
    required this.id,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.v,
  });
  static List<Messagemodel>? messageList = [];
  String to;
  String from;
  List<String> text;
  String id;
  // DateTime createdAt;
  // DateTime updatedAt;
  // int v;

  factory Messagemodel.fromJson(Map<String, dynamic> json) => Messagemodel(
        to: json["to"],
        from: json["from"],
        text: List<String>.from(json["text"].map((x) => x)),
        id: json["_id"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        // v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "from": from,
        "text": List<dynamic>.from(text.map((x) => x)),
        "_id": id,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        // "__v": v,
      };

  addNewMessage(Messagemodel message) {
    messageList?.add(message);
    notifyListeners();
  }
}
