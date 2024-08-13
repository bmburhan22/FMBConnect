import 'package:flutter/material.dart';
import 'package:fmb_connect/app.dart';
import 'package:skeletonizer/skeletonizer.dart';
class MessageCard extends StatelessWidget {
  final Map<String,dynamic>? message;
  const MessageCard(this.message,{ super.key});

  @override
  Widget build(BuildContext context) {
    return 
   Skeleton.leaf(
    child: 
    Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 2, color: Colors.teal.shade900)),
                          child:
    
                          
                          message==null?const Expanded( child: Text('\n\nNo Message\n\n', textAlign: TextAlign.center)):
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children:
                               [
                                Text(
                                    DateTime.fromMicrosecondsSinceEpoch(
                                            message!['created_at'])
                                        .toDateTimeString,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Colors.blueGrey.shade900)),
                                const SizedBox(height: 5),
                                Text(message!['title'],
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                                Text(message!['message'],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium!)
                              ])));
  }
}