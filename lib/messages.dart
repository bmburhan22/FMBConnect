import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';

class Messages extends ConsumerStatefulWidget {
  const Messages({super.key});
  @override
  ConsumerState<Messages> createState() => _MessagesState();
}

class _MessagesState extends ConsumerState<Messages> {
  List<String> messages = [];
  Future<void> fetchMessages() async {
    Map? res = await fetch('/messages', {
      'its':ref.read(authProvider)!.its,
    });

    if (res == null) return;
    setState(() {
      messages = List<String>.from(res['messages'] ?? []);
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
          title:  Text('FMB Connect ${ref.read(authProvider)?.its }'),
        ),
        body: RefreshIndicator(
            onRefresh: fetchMessages,
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Today's Menu",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w700),
                            )),
                      )
                    ]))));
  }
}
