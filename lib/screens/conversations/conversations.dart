import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:nane_client/providers/user.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Игрушечные чаты'), actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            context.read<UserProvider>().setUser(null);
          },
        ),
      ]),
    );
  }
}
