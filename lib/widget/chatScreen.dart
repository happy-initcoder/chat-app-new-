import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatScreen'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))],
      ),
      body: Container(
          // color: Colors.red,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Message...',
                  ),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
