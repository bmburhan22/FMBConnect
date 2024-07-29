import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/app.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/login.dart';
import 'package:fmb_connect/messages.dart';
import 'package:fmb_connect/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fmb_connect/user_provider.dart';
import 'package:intl/intl.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context ) {
    return Consumer( 
      builder: (context, WidgetRef ref, child) {
          return MaterialApp(
            title: 'FMBConnect',
            theme: theme,
            initialRoute: ref.watch(userProvider) == null ? 'login' : '/',
            routes: {
              '/': (context) => const App(), // user can be null?
              '/messages': (context) => const Messages(),
              'login': (context) => const Login(),
            },
          );
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
