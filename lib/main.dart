import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/app.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/firebase_options.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/login.dart';
import 'package:fmb_connect/messages.dart';
import 'package:fmb_connect/payment.dart';
import 'package:fmb_connect/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

final navkey = GlobalKey<NavigatorState>();
void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  initNotifications();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(_) {
    return Consumer(builder: (_, WidgetRef ref, child) {
      return FutureBuilder(
          future: ref.read(authProvider.notifier).initAuth(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(
                theme: theme,
                builder: (context, child) => Scaffold(
                  body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Center(child: LinearProgressIndicator()),
                  ),
                ),
              );
            }
            FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

            return MaterialApp(
              title: 'FMBConnect',
              theme: theme,
              initialRoute: ref.read(authProvider) == null ? 'login' : '/',
              navigatorKey: navkey,
              routes: {
                '/': (_) => const App(),
                'login': (_) => const Login(),
                '/messages': (_) => const Messages(),
                '/payment': (_) => const Payment(),
              },
            );
          });
    });
  }
}

extension ListExtensions on List<Widget> {
  List<Widget> around(Widget divider) {
    if (isEmpty) return this;

    List<Widget> paddedList = this;
    paddedList.insert(0, divider);
    paddedList.add(divider);
    return paddedList;
  }

  List<Widget> divide(Widget divider) {
    if (isEmpty) return this;
    
    List<Widget> dividedList = [];
    for (int i = 0; i < length; i++) {
      dividedList.add(this[i]);
      if (i < length - 1) {
        dividedList.add(divider);
      }
    }
    return dividedList;
  }
}
