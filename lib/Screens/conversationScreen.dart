import 'package:capp/API/firendCollection.dart';
import 'package:capp/API/getDetailApi.dart';
import 'package:capp/providers/messageProvider.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:capp/API/messagemodel.dart';
import 'package:capp/Screens/chatScreen.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

import 'package:flutter/material.dart';

import '../API/BaseUrl.dart';
import '../API/socket.dart';
import 'authScreen.dart';
import 'chatTesting.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({super.key});

  static const routeName = '/Conversation-list';

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  String searchValue = '';
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    ClassSocket.socket = IO.io(
      '${BaseUrl.baseUrl}',
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'from': UserDetail.userid}).build(),
    );
    GetDetailsAPI.getConversation().then((value) {
      setState(() {
        GetDetailsAPI.listResponse?.addAll(value);
        GetDetailsAPI.listResponse
            ?.removeWhere((element) => element.id == UserDetail.userid);
      });
    });
    _connectSocket();

    super.initState();
  }

  _connectSocket() {
    ClassSocket.socket.onConnect((data) => print(data));
    ClassSocket.socket.emit('addUser', {UserDetail.userid});
    ClassSocket.socket.on('getUsers', (data) => print('all users '));
    ClassSocket.socket.onConnectError((data) => print('Connect Error: $data'));
    ClassSocket.socket
        .onDisconnect((data) => print('Socket.IO server disconnected'));

    // ClassSocket.socket.on('getMessage', (data) {
    //   MessageProvider.newMessages.add(MessageSocket.fromJson(data));
    //   print('messages ${data['text']}');
    // });
    // ClassSocket.socket
    //     .on('getMessage', (data) => );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
        title: Text('FLutter chat'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: GetDetailsAPI.listResponse?.length,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, ChatScreen.routeName);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => ChangeNotifierProvider(
                //         create: (context) => MessageProvider(),
                //         child: ChatTestingScreen()),
                //   ),
                // );
                GetDetailsAPI.getIndexVal(index);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  // shape: RoundedRectangleBorder(
                  //     side: BorderSide(color: Colors.blue, width: 2),
                  //     borderRadius: BorderRadius.circular(20)),
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
                            radius: 7,
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
