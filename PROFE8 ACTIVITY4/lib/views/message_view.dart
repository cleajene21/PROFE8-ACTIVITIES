import 'package:flutter/material.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Messages'),
          backgroundColor: Colors.pinkAccent,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.chat), text: 'Chats'),
              Tab(icon: Icon(Icons.update), text: 'Status'),
              Tab(icon: Icon(Icons.call), text: 'Calls'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('This is the Chats tab')),
            Center(child: Text('This is the Status tab')),
            Center(child: Text('This is the Calls tab')),
          ],
        ),
      ),
    );
  }
}
