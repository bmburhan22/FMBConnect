import 'package:flutter/material.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:fmb_connect/menu.dart';
import 'package:fmb_connect/menu_card.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class App extends StatefulWidget {
  final String its;
  const App(this.its, {super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  DateTime? startDate = today(), endDate = today();
  _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      startDate = args.value.startDate;
      endDate = args.value.endDate;
    });
  }

  _onSkipTiffins() async {
    if (!await showConfirmationDialog(context, 'Skip tiffin for date:\n${datesSelected(startDate, endDate)} ?', 'Confirm', 'Cancel')) return;
    setState(() {
      endDate = endDate ?? startDate;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (startDate!.isBefore(tomorrow()) ||
        datesInBetween(startDate!, endDate!).any((date) => dateSkipped(date, widget.its))) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Select dates from tomorrow onwards that are not skipped ')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ITS ${widget.its} skipped tiffin for date ${datesSelected(startDate, endDate)}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final menusFiltered = menusList.where((menu) => filterMenu(menu, startDate!, endDate ?? startDate!)).toList();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          foregroundColor: Colors.white,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('FMB Connect'),
            const SizedBox(width: 10),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(color: Colors.teal.shade700, borderRadius: BorderRadius.circular(30)),
                child: Text('ITS - ${widget.its}')),
          ]),
          actions: [
            IconButton(
                onPressed: () {
                  Auth.logout(context);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
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
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MenuCard(
                  menusList.where((menu) => DateTime(menu.year, menu.month, menu.day) == today()).firstOrNull,
                  dateSkipped(today(), widget.its)),
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SfDateRangePicker(
                  backgroundColor: const Color.fromARGB(255, 211, 226, 225),
                  rangeTextStyle: const TextStyle(color: Colors.white),
                  monthViewSettings: DateRangePickerMonthViewSettings(specialDates: skippedDatesList(widget.its)),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                      specialDatesDecoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent.shade400, width: 2),
                    shape: BoxShape.circle,
                  )),
                  rangeSelectionColor: Colors.teal,
                  headerStyle: DateRangePickerHeaderStyle(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.teal.shade900),
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: _onSelectionChanged,
                  initialSelectedRange: PickerDateRange(startDate, endDate),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Menu for selected dates',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500)),
                  MaterialButton(
                    onPressed: _onSkipTiffins,
                    color: Colors.red.shade700,
                    child: Text(
                      'Skip Tiffins',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  )
                ])),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: menusFiltered.isEmpty
                    ? const MenuCard(null, true)
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: menusFiltered.length,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          final menu = menusFiltered[i];
                          final date = DateTime(menu.year, menu.month, menu.day);
                          return MenuCard(menu, dateSkipped(date, widget.its));
                        },
                        separatorBuilder: (_, i) => const SizedBox(
                          height: 10,
                        ),
                      )),
          ]
              .divide(const SizedBox(
                height: 10,
              ))
              .around(const SizedBox(
                height: 10,
              )),
        )));
  }
}
