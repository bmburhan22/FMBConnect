import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/icon_button.dart';
import 'package:fmb_connect/main.dart';

class Sidebar extends ConsumerStatefulWidget {
  const Sidebar({super.key});

  @override
  ConsumerState<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade900,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          const Icon(Icons.person, size: 36,color: Colors.white,),
                          const SizedBox(width: 10),
                          Text(
                            ref.read(authProvider)?.its ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ])),
                    Text(
                      ref.read(authProvider)?.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    TextIconButton(
                        text: 'Logout',
                        onTap: () =>
                            ref.read(authProvider.notifier).logout(),
                        icon: Icons.chevron_left,
                        color: Colors.red.shade600,
                        mainAxisSize: MainAxisSize.min,
                        ),
                    const SizedBox(
                      width: double.maxFinite,
                      child: Divider(),
                    ),
                    TextIconButton(
                      icon: Icons.currency_rupee,
                      text: 'Payment',
                      onTap: ()=>navkey. currentState?.pushNamed( '/payment'),
                    ),
                    TextIconButton(
                      icon: Icons.message,
                      text: 'Messages',
                      onTap: ()=> navkey.currentState?.pushNamed( '/messages'),
                    ),
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
