import 'dart:convert';

import 'package:capp/widget/conversation.dart';
import 'package:flutter/material.dart';

import '../Screens/authScreen.dart';
import 'package:http/http.dart' as http;

import 'BaseUrl.dart';
import 'firendCollection.dart';

class GetDetailsAPI {
  static Map? mapData;
  static List? listData;
  static List<getFriendDetail>? listResponse = [];

  static callFun() {
    getConversation();
  }

  static getConversation() async {
    http.Response response = await http.get(
      Uri.parse('${BaseUrl.baseUrl}/api/users/'),
    );
    mapData = json.decode(response.body);
    listData = mapData?['data'];

    print(mapData?['data'][0]);

    listResponse = jsonDecode(response.body)
        .map((item) => getFriendDetail.fromJson(item))
        .toList()
        .cast<getFriendDetail>();
    // print(listResponse);
    // if (response.statusCode == 200) {
    //   List<dynamic> jsonlist = jsonDecode(listData![0].toString());
    //   return jsonlist
    //       .map((json) => getFriendDetail(
    //           sId: json['_id'],
    //           username: json['username'],
    //           email: json['email']))
    //       .toList();
    // } else
    //   print('failed');

    // return listResponse;
  }
}
