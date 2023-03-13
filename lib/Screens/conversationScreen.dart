import 'package:capp/API/firendCollection.dart';
import 'package:capp/API/getDetailApi.dart';
import 'package:capp/Screens/chatScreen.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({super.key});

  static const routeName = '/Conversation-list';

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  String searchValue = '';
  @override
  void initState() {
    GetDetailsAPI.getConversation().then((value) {
      setState(() {
        GetDetailsAPI.listResponse?.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: Text('Conversations'),
        onSearch: (value) => setState(() => searchValue = value),
      ),
      body: ListView.builder(
          itemCount: GetDetailsAPI.listResponse?.length,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, ChatScreen.routeName);
                GetDetailsAPI.getIndexVal(index);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Stack(children: [
                          CircleAvatar(
                            radius: 25,
                          ),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                          ),
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(GetDetailsAPI.listResponse![index].username
                                  .toString()),
                              Text(GetDetailsAPI.listResponse![index].email
                                  .toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
