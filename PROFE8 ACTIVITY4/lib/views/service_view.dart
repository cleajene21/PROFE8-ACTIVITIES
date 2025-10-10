import 'package:flutter/material.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Messages'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
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
            Center(
              child: Text(
                'This is the Chats tab',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'This is the Status tab',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'This is the Calls tab',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
