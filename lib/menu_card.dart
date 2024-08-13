import 'package:flutter/material.dart';
import 'package:fmb_connect/feedback_dialog.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Menu {
  String? date;
  DateTime get dateTime => DateFormat("yyyy-MM-dd").parse(date ?? '');
  List<String>? items;
  double? rating;
  String? review;
  Menu(Map? menuMap) {
    date = menuMap?['date'];
    items = List<String>.from(menuMap?['items']??[]);
    rating =  menuMap?['rating']?.toDouble();
    review = menuMap?['review'];
  }
  @override
  String toString() => '$date $items';
}

class MenuCard extends StatelessWidget {
  final Menu? menu;
  final bool skipped;
  final Function fetchMenu;
  final bool loading;
  const MenuCard(this.menu, this.skipped, this.fetchMenu, {this.loading=false,super.key});

  @override
  Widget build(BuildContext context) {
    return 
    loading?
        Skeletonizer(containersColor: Colors.teal.shade900, child:const NoTiffinCard())
    :(menu?.items?.isEmpty??true)? 
        const NoTiffinCard()
        : GestureDetector(
            onTap: () {
              if (menu != null) {
                showDialog(
                    context: context,
                    builder: (context) => FeedbackDialog(menu!, !skipped && menu!.dateTime.isBefore(today()), fetchMenu
                    ));
              }
            },
            child: 
            
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: 
                  skipped 
                      ? Colors.red.shade50
                      :Colors.teal.shade50,
              
                  border: Border.all(
                      width: 2,
                      color: skipped
                          ? Colors.redAccent.shade700
                          : Colors.teal.shade900)),
              padding: const EdgeInsets.all(10),
              child: Row(
                  children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: skipped?Colors.redAccent: Colors.teal //.shade200
                        ),
                    width: 60,
                    child: Text(
                      DateFormat('EEE\nMMM dd').format(menu!.dateTime),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        
                          fontWeight: FontWeight.w600, color: Colors.white),
                    )),
                Expanded(
                    child: Text(
                  (menu!.items??[]).join(', '),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                )),
                if (!skipped && menu!.dateTime.isBefore(today()))
                  Icon(
                    Icons.rate_review,
                    color: Colors.teal.shade900,
                  ),
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
      child: 
      
     const Row(
          children: [
            Column(children:[Text(''),Text('')]),
         Expanded(child: Text('No tiffin for the day')),
        SizedBox(width: 10),
         Icon(Icons.no_meals,color: Colors.red,
        )
      ]
      
    ),
    );
  }
}
