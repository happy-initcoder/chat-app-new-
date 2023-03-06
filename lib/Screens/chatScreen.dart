import 'dart:convert';
import 'package:capp/API/getDetailApi.dart';
import 'package:capp/Screens/authScreen.dart';
import 'package:capp/widget/messageBubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../API/BaseUrl.dart';
import '../API/messagemodel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const routeName = '/Chat-Screen';
  //  final List<GetDetailsAPI>? singleUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final TextEditingController messageController = TextEditingController();
  static List<Messagemodel>? messageList = [];

  void addMessages() async {
    try {
      http.Response response =
          await http.post(Uri.parse('${BaseUrl.baseUrl}/api/messages'), body: {
        "from": UserDetail.userid,
        "to": GetDetailsAPI.listResponse![1].id,
        "text": messageController.text.trim(),
      });

      if (response.statusCode == 201) {
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
          '${BaseUrl.baseUrl}/api/messages/${UserDetail.userid}/63e08b8cd73fc0ea247d61b3'),
    );

    List<Messagemodel> mlist = [];

    if (response.statusCode == 200) {
      var urjson = json.decode(response.body);
      var jsonData = urjson['data'];
      print(urjson);
      for (var jData in jsonData) {
        mlist.add(Messagemodel.fromJson(jData));
      }
    }
    return mlist;
  }

  _sendMessage() {
    socket.emit('sendMessage', {
      // 'senderId': UserDetail.userid,
      // 'receiverId': GetDetailsAPI.listResponse![1].id,
      // 'text': messageController.text.trim()
      addMessages()
    });
  }

  _connectSocket() {
    socket.onConnect((data) => print('connection established'));
    socket.onConnectError((data) => print('Connect Error: $data'));
    socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  }

  @override
  void initState() {
    super.initState();
    socket = IO.io(
      'https://ed7b-112-196-188-68.in.ngrok.io',
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'from': UserDetail.userid}).build(),
    );
    _connectSocket();
    getMessages().then((value) {
      setState(() {
        messageList?.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              return Text(messageList![index].text as String);
            },
            itemCount: messageList?.length,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Message...',
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.send))
            ]),
          )
        ],
      ),
    );
  }
}
