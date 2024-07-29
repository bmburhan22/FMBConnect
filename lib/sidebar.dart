import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/icon_button.dart';
import 'package:fmb_connect/main.dart';

class Sidebar extends ConsumerStatefulWidget {
  const Sidebar({super.key});

  @override
  ConsumerState<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar> {
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
  Future<void> fetchMessages(String its) async {
    Map? res = await fetch('/messages', {
      'its': its,
    });

    if (res == null) return;
    setState(() {
      messages = List<String>.from(res['messages'] ?? []);
    });
  }

  Future<void> fetchPaymentStatus(String its) async {
    Map? res = await fetch('/payment_status', {
      'its': its,
    });
    if (res == null) return;
    setState(() {
      paymentStatus = res['payment_status'] ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
     // fetchMessages();
    // fetchPaymentStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextIconButton(
                        text: 'Logout',
                        onTap: () =>
                            ref.read(authProvider.notifier).logout(context),
                        icon: Icons.chevron_left,
                        color: Colors.red.shade600),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.teal.shade900,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "ITS: ${ref.read(authProvider)?.its}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Text(
                      ref.read(authProvider)?.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      width: double.maxFinite,
                      child: Divider(),
                    ),
                    TextIconButton(
                      icon: Icons.currency_rupee,
                      text: 'Payment',
                      onTap: () => Navigator.pushNamed(context, '/payment'),
                    ),
                    TextIconButton(
                      icon: Icons.message,
                      text: 'Messages',
                      onTap: () => Navigator.pushNamed(context, '/messages'),
                    )

                    /*
                ExpansionTile(
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
                )*/
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
