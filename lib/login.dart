import 'package:flutter/material.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _itsController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
        foregroundColor: Colors.white,
        title: const Text('FMB Connect Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Enter ITS and password to log in',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _itsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ITS', border: OutlineInputBorder()),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
              )),
          MaterialButton(
              color: Colors.teal.shade900,
              textColor: Colors.white,
              child: const Text('Log in'),
              onPressed: () {
                Auth.login(context, _itsController.text, _passwordController.text);
              })
        ]
            .divide(const SizedBox(
              height: 20,
            ))
            .around(const SizedBox(
              height: 20,
            )),
      ),
    );
  }
}
