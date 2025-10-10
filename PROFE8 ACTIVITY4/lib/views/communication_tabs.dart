import 'package:flutter/material.dart';

class CommunicationTabs extends StatelessWidget {
  const CommunicationTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Barber Chat Center'),
          backgroundColor: Colors.pinkAccent,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.chat), text: 'Chats'),
              Tab(icon: Icon(Icons.circle), text: 'Status'),
              Tab(icon: Icon(Icons.call), text: 'Calls'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Chat with your barber')),
            Center(child: Text('Barber status updates')),
            Center(child: Text('Call history')),
          ],
        ),
      ),
    );
  }
}
