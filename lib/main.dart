import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/app.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/login.dart';
import 'package:fmb_connect/messages.dart';
import 'package:fmb_connect/payment.dart';
import 'package:fmb_connect/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WidgetRef ref, child) {
      return FutureBuilder(
          future: ref.read(authProvider.notifier).initAuth(),
          builder: (context, snapshot) {
            // print(ref.read(authProvider));
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return MaterialApp(
            //     theme: theme,
            //     builder: (context, child) => Scaffold(
            //         floatingActionButton: FloatingActionButton(
            //             backgroundColor: Colors.amber, onPressed: () {})),
            //   );
            // }
            return MaterialApp(
              title: 'FMBConnect',
              theme: theme,
              initialRoute: ref.watch(authProvider) == null ? 'login' : '/',
              routes: {
                '/': (context) => const App(),
                'login': (context) => const Login(),
                '/messages': (context) => const Messages(),
                '/payment': (context) => const Payment(),
              },
            );
          });
    });
  }
}

extension ListExtensions on List<Widget> {
  List<Widget> around(Widget divider) {
    List<Widget> paddedList = this;
    paddedList.insert(0, divider);
    paddedList.add(divider);
    return paddedList;
  }

  List<Widget> divide(Widget divider) {
    if (isEmpty) {
      return this;
    }
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
