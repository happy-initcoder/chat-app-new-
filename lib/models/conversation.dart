import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDetail {
  String userId;

  UserDetail({required this.userId});

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(userId: json['data']);
  }
}

Future<UserDetail> conversationList() async {
  http.Response response = await http.get(
    Uri.parse(
        'https://3c3b-112-196-166-7.in.ngrok.io/api/conversations/63dcb774860b824030a14466'),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return UserDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed');
  }
}
