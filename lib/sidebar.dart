import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:fmb_connect/theme.dart';

class Sidebar extends StatefulWidget {
  final User? user;
  const Sidebar({this.user, super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool paymentStatus = false;
  List<String> messages = [
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
    'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew',
  ];
  Future<void> fetchMessages() async {
    Map? res = await fetch('/messages', {
      'its': widget.user!.its,
    });

    if (res == null) return;
    setState(() {
      messages = List<String>.from(res['messages'] ?? []);
    });
  }

  Future<void> fetchPaymentStatus() async {
    Map? res = await fetch('/payment_status', {
      'its': widget.user!.its,
    });

    if (res == null) return;
    setState(() {
      paymentStatus = res['payment_status'] ?? false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // fetchMessages();
    // fetchPaymentStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: 
                SingleChildScrollView(child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          label: Text('Logout',
                              style: Theme.of(context).textTheme.bodyLarge!),
                          onPressed: () {
                            Auth.logout(context);
                          },
                          icon: Icon(
                            color: Colors.teal.shade900,
                            Icons.chevron_left,
                            size: 24,
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade900,
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "ITS: ${widget.user?.its}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ]),
                Text(
                  widget.user?.name ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                      color: paymentStatus
                          ? Colors.teal.shade900
                          : Colors.red.shade900,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    paymentStatus ? 'Payment Complete' : 'Payment Pending',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: double.maxFinite,
                  child: Divider(),
                ), ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  backgroundColor: Colors.teal.shade50,
                  collapsedBackgroundColor: Colors.teal.shade50,
                  title: Text(
                    'Messages',
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                  children: messages
                      .map((text) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(text,
                              style: Theme.of(context).textTheme.bodyMedium!)))
                      .toList()
                      .divide(const SizedBox(height: 5)),
                )
                
              ]
                  .divide(const SizedBox(
                    height: 20,
                  ))
                  .around(const SizedBox(
                    height: 20,
                  ))))),
    );
  }
}
