import 'dart:convert';
import 'dart:io';
import 'package:capp/API/getDetailApi.dart';
import 'package:capp/API/socket.dart';
import 'package:capp/Screens/authScreen.dart';
import 'package:capp/widget/messageBubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../API/BaseUrl.dart';
import '../API/messagemodel.dart';
import '../providers/messageProvider.dart';

class ChatTestingScreen extends StatefulWidget {
  const ChatTestingScreen({super.key});

  static const routeName = '/Chat-Testing-Screen';
  //  final List<GetDetailsAPI>? singleUser;

  @override
  State<ChatTestingScreen> createState() => _ChatTestingScreenState();
}

class _ChatTestingScreenState extends State<ChatTestingScreen> {
  final TextEditingController messageController = TextEditingController();

  void addMessages() async {
    try {
      http.Response response =
          await http.post(Uri.parse('${BaseUrl.baseUrl}/api/messages'), body: {
        "from": UserDetail.userid,
        "to": GetDetailsAPI.listResponse![GetDetailsAPI.index].id,
        "text": messageController.text.trim(),
      });
      print(response.body);
      if (response.statusCode == 200) {
        print('worked successfully');
      } else {
        print('faild');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getMessages() async {
    http.Response response = await http.get(
      Uri.parse(
          '${BaseUrl.baseUrl}/api/messages/${UserDetail.userid}/${GetDetailsAPI.listResponse![GetDetailsAPI.index].id}'),
    );

    List<Messagemodel> mlist = [];

    if (response.statusCode == 200) {
      var urjson = json.decode(response.body);
      var jsonData = urjson['data'];

      for (var jData in jsonData) {
        mlist.add(Messagemodel.fromJson(jData));
      }
    }
    return mlist;
  }

  _sendMessage() {
    ClassSocket.socket.emit('sendMessage', {
      'senderId': UserDetail.userid,
      'receiverId': GetDetailsAPI.listResponse![GetDetailsAPI.index].id,
      'text': messageController.text.trim()
    });
    addMessages();
    messageController.clear();
  }

  @override
  void initState() {
    super.initState();

    getMessages().then((value) {
      setState(() {
        Messagemodel.messageList?.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Messagemodel.messageList?.clear();
                  },
                  icon: Icon(Icons.arrow_back)),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  radius: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                    GetDetailsAPI.listResponse![GetDetailsAPI.index].username),
              ),
            ],
          )),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MessageProvider>(
              builder: (_, provider, __) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final message = MessageProvider.newMessages[index];
                  return Wrap(
                    alignment: message.senderId == UserDetail.userid
                        ? WrapAlignment.end
                        : WrapAlignment.start,
                    children: [
                      Card(
                        color: message.senderId == UserDetail.userid
                            ? Theme.of(context).primaryColorLight
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                                message.senderId == UserDetail.userid
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Text(message.text),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: MessageProvider.newMessages.length,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (messageController.text.trim().isNotEmpty) {
                        _sendMessage();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
