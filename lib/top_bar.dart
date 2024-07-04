import 'package:flutter/material.dart';
import 'package:fmb_connect/auth.dart';

class TopBar extends StatelessWidget {
  final String? its;
  final String title;
  const TopBar(this.title,this.its, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal.shade900,
      foregroundColor: Colors.white,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title),
        const SizedBox(width: 10),
        if(its!=null) Text('ITS - $its'),
      ]),
      actions:its==null?[]:[
              IconButton(
                  onPressed: () {
                    Auth.logout(context);
                  },
                  icon: const Icon(Icons.logout))
            ],
    );
  }
}
