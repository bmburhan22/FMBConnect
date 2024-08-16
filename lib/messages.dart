import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/constdata.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:fmb_connect/message_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Messages extends ConsumerStatefulWidget {
  const Messages({super.key});
  @override
  ConsumerState<Messages> createState() => _MessagesState();
}

class _MessagesState extends ConsumerState<Messages> {
  List<Map<String, dynamic>> messages = [];
bool loading=true;

  Future<void> fetchMessages() async {
    Map? res = await fetch('/messages', {
      'its': ref.read(authProvider)!.its,
    });
    /* 
    POPULATE CONST DATA: MESSAGES

    setState(() {messages = constMessages;loading=false;});
    */
    if (res == null) return;
    setState(() {
      messages = List<Map<String, dynamic>>.from(res['messages'] ?? []);
      loading=false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return
        RefreshIndicator(onRefresh: fetchMessages,child: 
     Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          foregroundColor: Colors.white,
          title: const Text('Messages'),
        ),
        body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child:  
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max, 
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:
                  (messages.isEmpty?[null]:messages).map((data) => 
                  Skeletonizer(
                  enabled: loading,
                  child: 
                  
   Skeleton.leaf(
    child: 
                  MessageCard(data))))
                      .toList()
                      .divide(const SizedBox(height: 10))
                      .around(const SizedBox(height: 10)),
    ))));
  }
}
