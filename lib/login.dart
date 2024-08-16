import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:pinput/pinput.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController _itsController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  Timer? timer;
  int seconds = 0;

  void startTimer() {
    timer?.cancel();
    setState(() {
      seconds = 10;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

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
            'Enter ITS and OTP to log in',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
              width: 200,
              child: TextFormField(
                enabled: seconds == 0,
                controller: _itsController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
                decoration: const InputDecoration(
                    hintText: 'ITS',
                    alignLabelWithHint: true,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: OutlineInputBorder()),
              )),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () async {
                        if (seconds == 0) {
                          if (_itsController.text.isEmpty) {
                            showSnackBar( 'ITS field is empty');
                            return;
                          }
                          Map? res = await post(
                              '/send_otp', {'its': _itsController.text});
                          showSnackBar(res?['message']);
                          if (res?['error']?.isNotEmpty ?? false) return;

                          startTimer();
                        }
                      },
                      child: Text(
                        seconds > 0 ? 'Resend OTP in ${seconds}s' : 'Send OTP',
                        style: const TextStyle(color: Colors.blue),
                      )))),

          Pinput(
              controller: _otpController,
              length: 6,
              onCompleted: (password) async {
                await ref
                    .read(authProvider.notifier)
                    .login( _itsController.text, password);
                _otpController.clear();
              },
              defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: const TextStyle(fontSize: 24),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ))),
/*
          MaterialButton(
              color: Colors.teal.shade900,
              textColor: Colors.white,
              child: Text('Log in'),
              onPressed: () {
                Auth.login(context, _itsController.text, _passwordController.text);
              })
              */
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
