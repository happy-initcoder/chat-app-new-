import 'dart:convert';
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

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const routeName = '/Chat-Screen';
  //  final List<GetDetailsAPI>? singleUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  void addMessages() async {
    try {
      http.Response response =
          await http.post(Uri.parse('${BaseUrl.baseUrl}/api/messages'), body: {
        "from": UserDetail.userid,
        "to": GetDetailsAPI.listResponse![GetDetailsAPI.index].id,
        "text": messageController.text.trim(),
      });

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
    // AppendMessage.messageList.add(Messagemodel(
    //   from: UserDetail.userid.toString(),
    //   text: [messageController.text.trim().toString()],
    // ));
    Provider.of<AppendMessage>(context, listen: false).addNewMessage(
      messageController.text.trim().toString(),
      UserDetail.userid.toString(),
    );
    ClassSocket.socket.emit('sendMessage', {
      'senderId': UserDetail.userid,
      'receiverId': GetDetailsAPI.listResponse![GetDetailsAPI.index].id,
      'text': messageController.text.trim()
    });
    addMessages();

    print(AppendMessage.messageList);
    messageController.clear();
  }

  // _reciveMessage(){
  //   socket.on('getMessage', (data) => print(data));
  // }

  _connectSocket() {
    ClassSocket.socket.on(
        'getMessage',
        (data) => Provider.of<AppendMessage>(context, listen: false)
            .addNewMessage(data['text'], data['senderId']));
    ClassSocket.socket.on('getMessage', (data) => print(data['text']));
  }

  @override
  void initState() {
    super.initState();
    // socket = IO.io(
    //   '${BaseUrl.baseUrl}',
    //   IO.OptionBuilder().setTransports(['websocket']).setQuery(
    //       {'from': UserDetail.userid}).build(),
    // );
    _connectSocket();
    getMessages().then((value) {
      setState(() {
        AppendMessage.messageList.addAll(value);
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
                      AppendMessage.messageList.clear();
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
                  child: Text(GetDetailsAPI
                      .listResponse![GetDetailsAPI.index].username),
                ),
              ],
            )),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Consumer<AppendMessage>(
                  builder: (_, provider, __) => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: UserDetail.userid !=
                                AppendMessage.messageList[index].from
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: UserDetail.userid !=
                                      AppendMessage.messageList[index].from
                                  ? Colors.grey[300]
                                  : Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: UserDetail.userid !=
                                        AppendMessage.messageList[index].from
                                    ? Radius.circular(12)
                                    : Radius.circular(0),
                                bottomRight: UserDetail.userid !=
                                        AppendMessage.messageList[index].from
                                    ? Radius.circular(0)
                                    : Radius.circular(12),
                              ),
                            ),
                            width: 140,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            margin: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              AppendMessage.messageList[index].text[0],
                              style: TextStyle(
                                color: UserDetail.userid !=
                                        AppendMessage.messageList[index].from
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: AppendMessage.messageList.length,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
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
              ),
            )
          ],
        ));
  }
}
