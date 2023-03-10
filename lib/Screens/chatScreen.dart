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

  void addMessages() async {
    try {
      http.Response response =
          await http.post(Uri.parse('${BaseUrl.baseUrl}/api/messages'), body: {
        "from": '63dcb774860b824030a14466',
        "to": '63e08b8cd73fc0ea247d61b3',
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
          '${BaseUrl.baseUrl}/api/messages/63e08b8cd73fc0ea247d61b3/63dcb774860b824030a14466'),
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
    socket.emit('sendMessage', {
      'senderId': '63e08b8cd73fc0ea247d61b3',
      'receiverId': '63dcb774860b824030a14466',
      'text': messageController.text.trim()
    });
    addMessages();
    messageController.clear();
  }

  // _reciveMessage(){
  //   socket.on('getMessage', (data) => print(data));
  // }

  _connectSocket() {
    socket.onConnect((data) => print('connection established'));
    socket.onConnectError((data) => print('Connect Error: $data'));
    socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    socket.on('getMessage', (data) => Messagemodel.messageList?.add(data));
  }

  @override
  void initState() {
    super.initState();
    socket = IO.io(
      '${BaseUrl.baseUrl}',
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'from': UserDetail.userid}).build(),
    );
    _connectSocket();
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
          title: Row(
        children: [
          CircleAvatar(
            radius: 25,
          ),
          Text(GetDetailsAPI.listResponse![GetDetailsAPI.index].username),
        ],
      )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 610,
              child: SingleChildScrollView(
                reverse: true,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: UserDetail.userid !=
                              Messagemodel.messageList![index].to
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: UserDetail.userid !=
                                    Messagemodel.messageList![index].to
                                ? Colors.grey[300]
                                : Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: UserDetail.userid !=
                                      Messagemodel.messageList![index].to
                                  ? Radius.circular(12)
                                  : Radius.circular(0),
                              bottomRight: UserDetail.userid !=
                                      Messagemodel.messageList![index].to
                                  ? Radius.circular(0)
                                  : Radius.circular(12),
                            ),
                          ),
                          width: 140,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Text(
                            Messagemodel.messageList![index].text[0],
                            style: TextStyle(
                              color: UserDetail.userid !=
                                      Messagemodel.messageList![index].to
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: Messagemodel.messageList?.length,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 5),
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
                IconButton(onPressed: _sendMessage, icon: Icon(Icons.send))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
