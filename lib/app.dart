import 'package:flutter/material.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:fmb_connect/menu_card.dart';
import 'package:fmb_connect/sidebar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get toISODate => DateFormat('yyyy-MM-dd').format(this);
  // DateTime get firstDayOfMonth => add(const Duration(days: 1));
  DateTime get lastDayOfMonth =>
      month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);
}

class App extends StatefulWidget {
  final User user;
  const App(this.user, {super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  DateTime? startDate = today(), endDate = today();
  late DateTime monthStart, monthEnd;
  Menu? menuToday;
  List<Menu> menuList = [], menusFiltered = [];
  List<DateTime> skippedDates = [];

  bool isClickable = false;

  @override
  void initState() {
    // TODO: implement initState
    fetchSkips();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchMenu() async {
    // if (startDate == null || endDate == null) return;
     Map? res  //=await fetch('/menu', {
    //   'its': widget.user.its,
    //   'startDate': monthStart.toISODate,
    //   'endDate': monthEnd.toISODate,
    //   'today': today().toISODate
    // });
    = {
      'its': '111',
      'menus': [],
      'menuToday': {'date': '2024-07-29', 'items': ['eq','3q']}
    };
    if (res == null) return;
    List<String> todayItems =
        List<String>.from(res['menuToday']?['items'] ?? []);
    setState(() {
      menuToday =
          todayItems.isEmpty ? null : Menu(today().toISODate, todayItems);
      // res['menus'].forEach((m) {if (!menuList.any((i) => i.date == m['date'])) menuList.add(Menu(m['date'], List<String>.from(m['items'])));
      menuList = List<Menu>.from(res!['menus']
          .map((m) => Menu(m['date'], List<String>.from(m['items']))));
    });
  }

  Future<void> refresh() async {
    await fetchMenu();
    await fetchSkips();
  }

  Future<void> fetchSkips() async {
    Map? res = await fetch('/skip', {'its': widget.user.its});
    if (res == null) return;
    setState(() {
      skippedDates = List<String>.from(res['dates'])
          .map((String d) => DateFormat('yyyy-MM-dd').parse(d))
          .toList();
    });
  }

  _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      startDate = args.value.startDate;
      endDate = args.value.endDate;
    });
  }

  _onSkipTiffins() async {
    if (!await showConfirmationDialog(
        context,
        'Skip tiffin for date:\n${datesSelected(startDate, endDate)} ?',
        'Confirm',
        'Cancel')) return;
    setState(() {
      endDate = endDate ?? startDate;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (startDate!.isBefore(tomorrow())
        // || datesInBetween(startDate!, endDate!).any((date) => skippedDates.contains(date))

        ) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Select dates from tomorrow onwards')));
    } else {
      if ((await post('/skip', {
            'its': widget.user.its,
            'startDate': startDate!.toISODate,
            'endDate': endDate!.toISODate
          })) !=
          null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'ITS ${widget.user.its} skipped tiffin for date ${datesSelected(startDate, endDate)}')));
        fetchSkips();
      }
    }
  }

  _onUnskipTiffins() async {
    print('rewrewqrweq');
    setState(() {
      endDate = endDate ?? startDate;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if ((await delete('/skip', {
          'its': widget.user.its,
          'startDate': startDate!.toISODate,
          'endDate': endDate!.toISODate
        })) !=
        null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'ITS ${widget.user.its} unskipped tiffin for date ${datesSelected(startDate, endDate)}')));
      fetchSkips();
    }
  }

  @override
  Widget build(BuildContext context) {
    menusFiltered = menuList
        .where((menu) =>
            dateInRange(menu.dateTime, startDate!, endDate ?? startDate!))
        .toList();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          foregroundColor: Colors.white,
          title: const Text('FMB Connect'),
        ),
        drawer: Sidebar(
          user: widget.user,
        ),
        body: RefreshIndicator(
            onRefresh: refresh,
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontWeight: FontWeight.w700),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:
                          MenuCard(menuToday, skippedDates.contains(today())),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SfDateRangePicker(
                          onViewChanged: (args) async {
                            await Future.delayed(
                                Duration.zero,
                                () => setState(() {
                                      monthStart =
                                          args.visibleDateRange.startDate!;
                                      monthEnd = args.visibleDateRange.endDate!;
                                    }));
                            await fetchMenu();
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 211, 226, 225),
                          rangeTextStyle: const TextStyle(color: Colors.white),
                          monthViewSettings: DateRangePickerMonthViewSettings(
                              specialDates: skippedDates),
                          monthCellStyle: DateRangePickerMonthCellStyle(
                              specialDatesDecoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.redAccent.shade400, width: 2),
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
                          initialSelectedRange:
                              PickerDateRange(startDate, endDate),
                        )),
                    Text('Menu for selected dates',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w500)),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                onPressed: _onUnskipTiffins,
                                color: Colors.teal.shade900,
                                child: Text(
                                  'Unskip Tiffins',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                ),
                              ),
                              MaterialButton(
                                onPressed: _onSkipTiffins,
                                color: Colors.red.shade700,
                                child: Text(
                                  'Skip Tiffins',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
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
                                  return MenuCard(menu,
                                      skippedDates.contains(menu.dateTime));
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
                ))));
  }
}
