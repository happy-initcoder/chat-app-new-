import 'dart:convert';

import 'package:capp/models/conversation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConversationWidget extends StatefulWidget {
  const ConversationWidget({super.key});

  @override
  State<ConversationWidget> createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  Map? mapData;
  List? listResponse;

  void getConversation() async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            'https://68f3-112-196-188-56.in.ngrok.io/api/conversations/63dcb774860b824030a14466'),
      );
      mapData = json.decode(response.body);
      listResponse = mapData?['data'];

      // print(response.body);
      // print(mapData);
      print(listResponse?[1]['members']);
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    getConversation();
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      height: 51,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            'hello',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'hellio',
              style: TextStyle(
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
