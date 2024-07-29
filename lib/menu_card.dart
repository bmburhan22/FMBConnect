import 'package:flutter/material.dart';
import 'package:fmb_connect/feedback_dialog.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:intl/intl.dart';

class Menu {
  final String date;
  DateTime get dateTime => DateFormat("yyyy-MM-dd").parse(date);
  final List<String> items;
  const Menu(this.date, this.items);
  @override
  String toString() => '$date $items';
}

class MenuCard extends StatelessWidget {
  final Menu? menu;
  final bool skipped;
  const MenuCard(this.menu, this.skipped, {super.key});

  @override
  Widget build(BuildContext context) {
    return menu == null
        ? const NoTiffinCard()
        : GestureDetector(
            onTap: () {
              if (menu != null)  showDialog(context: context, builder: (context) => FeedbackDialog(menu!, 2,'Good food'));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: skipped
                      ? const Color.fromARGB(76, 255, 82, 82)
                      : const Color.fromARGB(33, 0, 150, 135),
                  border: Border.all(
                      width: 2,
                      color: skipped
                          ? Colors.redAccent.shade700
                          : Colors.teal.shade900)),
              padding: const EdgeInsets.all(10),
              child: Row(
                  children: [
                SizedBox(
                    width: 50,
                    child: Text(
                      DateFormat('EEE\nMMM dd').format(menu!.dateTime),
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    )),
                Expanded(
                    child: Text(
                  menu!.items.join(', '),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                )),
                skipped
                    ? const Icon(
                        Icons.no_meals,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.restaurant,
                        color: Colors.teal.shade900,
                      )
              ].divide(const SizedBox(width: 10))),
            ));
  }
}

class NoTiffinCard extends StatelessWidget {
  const NoTiffinCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.redAccent.shade700)),
      padding: const EdgeInsets.all(10),
      child: Row(
          children: [
        const Expanded(child: Text('No tiffin for the day')),
        const Icon(
          Icons.no_meals,
          color: Colors.red,
        )
      ].divide(const SizedBox(width: 10))),
    );
  }
}
