import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';
import 'constants/setting.dart';
import 'providers/base.dart';
import 'providers/settings.dart';
import 'providers/user.dart';
import 'screens/auth/auth.dart';
import 'screens/conversations/conversations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => BaseProvider(),
        ),
        ChangeNotifierProxyProvider<BaseProvider, UserProvider>(
          lazy: false,
          create: (_) => UserProvider(),
          update: (_, base, user) => UserProvider(
            user: user?.user,
            dio: base.dio,
          ),
        ),
        ChangeNotifierProxyProvider<BaseProvider, SettingsProvider>(
          create: (_) => SettingsProvider(
            settings: SettingConstants.defaultServerSettings,
          ),
          update: (_, base, settings) => SettingsProvider(
            settings:
                settings?.settings ?? SettingConstants.defaultServerSettings,
            dio: base.dio,
          ),
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
          home: user == null ? AuthScreen() : ConversationsScreen(),
        );
      },
    );
  }
}
