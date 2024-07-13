import 'package:flutter/material.dart';
import 'package:fmb_connect/app.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/login.dart';
import 'package:fmb_connect/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';


void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
  
    await Auth.authState()
    ));
}

class MyApp extends StatelessWidget {
  final String its;
  const MyApp(this.its, {super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(title: 'FMBConnect', theme: theme, initialRoute: its.isEmpty ? 'login' : '/', 
    routes: {
      '/': ( context) => App(ModalRoute.of(context)!.settings.arguments as String? ?? its),
      'login': (context) => const Login(),
    },
    );

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