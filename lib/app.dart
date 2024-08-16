import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/constdata.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:fmb_connect/menu_card.dart';
import 'package:fmb_connect/sidebar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get toISODate => DateFormat('yyyy-MM-dd').format(this);
  String get toDateString => DateFormat('MMM d, yyyy').format(this);
  String get toDateTimeString => DateFormat('h:mm a, d/M/y').format(this);
  DateTime get lastDayOfMonth =>
      month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);
}

class App extends ConsumerStatefulWidget {
  const App({super.key});
  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  bool loading = true;
  DateTime? startDate = today(), endDate = today();
  late DateTime monthStart, monthEnd;
  Menu? menuToday;
  List<Menu> menuList = [], menusFiltered = [];
  List<DateTime> skippedDates = [];
  @override
  void initState() {
    super.initState();
    fetchSkips();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchMenu() async {
    if (startDate == null || endDate == null) return;
    Map? res = await fetch('/menu', {
      'its': ref.read(authProvider)!.its,
      'startDate': monthStart.toISODate,
      'endDate': monthEnd.toISODate,
      'today': today().toISODate
    });
    /*
    POPULATE CONST DATA: MENUS

    setState(() {
      menuList = constMenuList;
      menuToday = constMenuToday;
      loading = false;
    });
    */
    if (res == null) return;
    setState(() {
      menuToday = Menu(res['menuToday']);
      /*
      res['menus'].forEach((m) {if (!menuList.any((i) => i.date == m['date'])) menuList.add(Menu(m['date'], List<String>.from(m['items'])));
      */
      menuList = List<Menu>.from(res['menus'].map((m) => Menu(m)));
      loading = false;
    });
  }

  Future<void> refresh() async {
    await fetchMenu();
    await fetchSkips();
  }

  Future<void> fetchSkips() async {
    Map? res = await fetch('/skip', {'its': ref.read(authProvider)!.its});
    /*
    POPULATE CONST DATA: SKIPS

    setState(() {
      skippedDates = constSkippedDates
          .map((String d) => DateFormat('yyyy-MM-dd').parse(d))
          .toList();
    });
    */
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
        'Skip tiffin for date:\n${datesSelected(startDate, endDate)} ?',
        'Confirm',
        'Cancel')) return;
    setState(() {
      endDate = endDate ?? startDate;
    });
    if (startDate!.isBefore(tomorrow())) {
      showSnackBar('Select dates from tomorrow onwards');
    } else if ((await post('/skip', {
          'its': ref.read(authProvider)!.its,
          'startDate': startDate!.toISODate,
          'endDate': endDate!.toISODate
        })) !=
        null) {
      fetchSkips().then((_) => showSnackBar(
          'ITS ${ref.read(authProvider)!.its} skipped tiffin for date ${datesSelected(startDate, endDate)}'));
    }
  }

  _onUnskipTiffins() async {
    setState(() {
      endDate = endDate ?? startDate;
    });
    if (startDate!.isBefore(tomorrow()) ) {
      showSnackBar('Select dates from tomorrow onwards');
    } else if ((await delete('/skip', {
          'its': ref.read(authProvider)!.its,
          'startDate': startDate!.toISODate,
          'endDate': endDate!.toISODate
        })) !=
        null) {
      fetchSkips().then((_) => showSnackBar(
          'ITS ${ref.read(authProvider)!.its} unskipped tiffin for date ${datesSelected(startDate, endDate)}'));
    }
  }

  @override
  Widget build(BuildContext context) {
    menusFiltered = menuList
        .where((menu) =>
            dateInRange(menu.dateTime, startDate!, endDate ?? startDate!))
        .toList();
    return RefreshIndicator(
        onRefresh: refresh,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal.shade900,
              foregroundColor: Colors.white,
              title: const Text('FMB Connect'),
            ),
            drawer: const Sidebar(),
            body: 
            SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child:
                
                 Column(
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
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MenuCard(
                        menuToday,
                        skippedDates.contains(today()),
                        fetchMenu,
                        loading: loading,
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Container(
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
                            ? MenuCard(null, true, fetchMenu)
                            : ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: menusFiltered.length,
                                shrinkWrap: true,
                                itemBuilder: (_, i) {
                                  final menu = menusFiltered[i];
                                  return MenuCard(
                                      menu,
                                      skippedDates.contains(menu.dateTime),
                                      fetchMenu);
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
