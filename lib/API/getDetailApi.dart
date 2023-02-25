import 'dart:convert';

import 'package:capp/widget/conversation.dart';
import 'package:flutter/material.dart';

import '../Screens/authScreen.dart';
import 'package:http/http.dart' as http;

import 'BaseUrl.dart';

class FriendName {
  String? name;
}

class GetDetailsAPI {
  static List<FriendName> names = [];
  static Map? mapData;
  static List? listResponse;
  static List? listData;
  static String? friendId;
  static Map? friendData;
  static Map? detail;
  static List? detailList;

  static callFun() {
    getConversation();
  }

  static getConversation() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${BaseUrl.baseUrl}/api/conversations/${UserID()}'),
      );
      mapData = json.decode(response.body);
      listResponse = mapData?['data'];

      print(mapData);
      if (response.statusCode == 200) {
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
    getFriendDetail();
  }

  static getFriendDetail() async {
    for (var i = 0; i < listResponse!.length; i++) {
      listData = listResponse?[i]["members"];
      if (listData?[0] == UserID()) {
        friendId = listData?[1];
      } else {
        friendId = listData?[0];
      }

      try {
        http.Response response = await http.get(
          Uri.parse('${BaseUrl.baseUrl}/api/users/${friendId}'),
        );
        friendData = json.decode(response.body);
        detail = friendData?['data'];
        names = detail?['username'];
      } catch (e) {
        print(e.toString());
      }
      print(detail?['username']);
    }
  }
}
