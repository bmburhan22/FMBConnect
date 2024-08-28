import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/contact_card.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
class Contactus extends ConsumerStatefulWidget {
  const Contactus({super.key});
  @override
  ConsumerState<Contactus> createState() => _ContactusState();
}

class _ContactusState extends ConsumerState<Contactus> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          foregroundColor: Colors.white,
          title: const Text('Contact Us'),
        ),
        body: FutureBuilder(
            future: fetch('/contactus', {'its': ref.read(authProvider)!.its}),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
  return 
    LoadingDialog().alert;
            }
            List<Map<String,dynamic>> contactInfo = List<Map<String, dynamic>>.from( snapshot.data? ['data']??[]);
            
              return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: (contactInfo.isEmpty ? [null] : contactInfo)
                        .map((data) => ContactCard(data))
                        .toList()
                        .divide(const SizedBox(height: 10))
                        .around(const SizedBox(height: 10)),
                  ));
            }));
  }
}
