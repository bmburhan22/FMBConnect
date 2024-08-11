import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/app.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';

class Messages extends ConsumerStatefulWidget {
  const Messages({super.key});
  @override
  ConsumerState<Messages> createState() => _MessagesState();
}

class _MessagesState extends ConsumerState<Messages> {
  List<Map<String, dynamic>> messages =[]; /*[
    {
      'time': 1722334334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1762334334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334634000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334834000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334234000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334834000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334934000,
      'message':
          'fewouqfbweqo feq wruohewqurhwruohewqurhwruohewqurhwruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722332334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1752334334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334934000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722334334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
    {
      'time': 1722335334000,
      'message':
          'fewouqfbweqo feq wruohewqurh oewqhro hewiuqhrihweqohrhw qehr uiwehroh woiqhre  rhoew'
    },
  ];*/

  Future<void> fetchMessages() async {
    Map? res = await fetch('/messages', {
      'its': ref.read(authProvider)!.its,
    });

    if (res == null) return;
    setState(() {
      messages = List<Map<String, dynamic>>.from(res['messages'] ?? []);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          foregroundColor: Colors.white,
          title: const Text('Messages'),
        ),
        body: RefreshIndicator(
            onRefresh: fetchMessages,
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: messages.map((data) => Container(
                          width: double.maxFinite,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 2, color: Colors.teal.shade900)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    DateTime.fromMicrosecondsSinceEpoch(
                                            data['created_at'])
                                        .toStringCustom,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Colors.blueGrey.shade900)),
                                const SizedBox(height: 5),
                                Text(data['title'],
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                                Text(data['message'],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium!)
                              ])))
                      .toList()
                      .divide(const SizedBox(height: 10))
                      .around(const SizedBox(height: 10)),
                ))));
  }
}
