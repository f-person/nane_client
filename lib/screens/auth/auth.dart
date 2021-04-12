import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:nane_client/models/data/user.dart';
import 'package:nane_client/providers/settings.dart';
import 'package:nane_client/providers/user.dart';
import 'package:nane_client/widgets/scaffold.dart';

class AuthScreen extends HookWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final isButtonActive = useState<bool>(false);
    final settings = context.watch<SettingsProvider>().settings;

    void handlePressed() {
      context.read<UserProvider>().setUser(User(username: controller.text));
    }

    return AppScaffold(
      appBar: AppBar(title: Text('Дверь в игрушечный чат')),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            maxLength: settings.maxUsernameLength,
            controller: controller,
            onChanged: (value) {
              if (value.length < 2) {
                isButtonActive.value = value.isNotEmpty;
              }
            },
            decoration: InputDecoration(
              labelText: 'Игрушечное имя пользователя',
              isDense: true,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: isButtonActive.value ? handlePressed : null,
          child: Text('Войти'),
        ),
      ]),
    );
  }
}
