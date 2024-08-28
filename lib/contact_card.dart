import 'package:flutter/material.dart';
import 'package:fmb_connect/icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final Map<String, dynamic>? contact;
  const ContactCard(this.contact, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: Colors.teal.shade900)),
        child: contact == null
            ? const Expanded(
                child: Text('\nNo contact\n', textAlign: TextAlign.center))
            : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(contact?['admin_name'],
                    style: Theme.of(context).textTheme.bodyLarge!),
                const SizedBox(height: 5),
                TextIconButton(
                    text: contact?['contact_number'] ?? '',
                    icon: Icons.call,
                    onTap: () => launchUrl(
                        Uri.parse('tel:${contact?['contact_number']}'))),
                const SizedBox(height: 5),
                TextIconButton(
                    text: contact?['email'] ?? '',
                    icon: Icons.mail,
                    onTap: () =>
                        launchUrl(Uri.parse('mailto:${contact?['email']}'))),
              ]));
  }
}
