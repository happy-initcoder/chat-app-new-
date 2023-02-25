import 'dart:convert';

import 'package:capp/API/getDetailApi.dart';
import 'package:capp/Screens/authScreen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../API/BaseUrl.dart';

class ConversationWidget extends StatefulWidget {
  const ConversationWidget({super.key});

  @override
  State<ConversationWidget> createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: GetDetailsAPI.names.length,
        itemBuilder: (context, index) {
          GestureDetector(
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
                                  GetDetailsAPI.detail?['username'],
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
        });
  }
}
