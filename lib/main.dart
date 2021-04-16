import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';
import 'providers/chat.dart';
import 'providers/settings.dart';
import 'providers/user.dart';
import 'screens/auth/auth.dart';
import 'screens/rooms/rooms.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final config = CatcherOptions(
    DialogReportMode(),
    [
      EmailManualHandler(['agakaryan.arshak@gmail.com'])
    ],
  );
  Catcher(
    debugConfig: config,
    releaseConfig: config,
    rootWidget: MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProxyProvider<UserProvider, ChatProvider>(
          lazy: false,
          create: (_) => ChatProvider(),
          update: (_, user, chat) {
            return chat!..updateUsername(user.user?.username);
          },
        ),
      ],
      builder: (context, child) {
        final user = context.select((UserProvider user) => user.user);

        return MaterialApp(
          title: 'Nane Chat',
          theme: ThemeData(
            primaryColor: AppColors.primary,
            accentColor: AppColors.accent,
          ),
          home: user == null ? AuthScreen() : RoomsScreen(),
        );
      },
    );
  }
}
