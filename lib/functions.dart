import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

Dio dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_URL']!,
    connectTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10)));

showLoaderDialog(BuildContext context, String? text) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(text ?? "Please wait...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<bool> showConfirmationDialog(BuildContext context,
    [String? title, String? yes, String? no]) async {
  bool confirm = false;
  AlertDialog alert = AlertDialog(
      content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
          padding: const EdgeInsets.all(10),
          child: Text(title ?? 'Press confirm or cancel',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
              textColor: Colors.teal.shade900,
              color: Colors.white,
              child: Text(no ?? 'Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
          MaterialButton(
              color: Colors.teal.shade900,
              textColor: Colors.white,
              child: Text(yes ?? 'Confirm'),
              onPressed: () {
                Navigator.pop(context);
                confirm = true;
              }),
        ],
      ),
    ],
  ));
  return showDialog(context: context, builder: (context) => alert)
      .then((_) => confirm);
}

DateTime tomorrow() {
  final dtTomorrow = DateTime.now().add(const Duration(days: 1));
  return DateTime(dtTomorrow.year, dtTomorrow.month, dtTomorrow.day);
}

DateTime today() {
  final dtToday = DateTime.now();
  return DateTime(dtToday.year, dtToday.month, dtToday.day);
}

String datesSelected(DateTime? startDate, DateTime? endDate) {
  DateFormat dateFormat = DateFormat('EEE, d/M/yy');
  if (startDate == endDate || endDate == null)
    return dateFormat.format(startDate!);

  return '${dateFormat.format(startDate!)} to ${dateFormat.format(endDate)}';
}

bool dateInRange(DateTime date, DateTime startDate, DateTime? endDate) =>
    date == startDate ||
    endDate != null && !date.isAfter(endDate) && !date.isBefore(startDate);

// List<DateTime> skippedDatesList(String its, List<DateTime> skippedDates ) {
//   Set<DateTime> dates = {};
//   for (var skip in skipsList.where((skip) => skip["its"] == its)) {
//     dates.addAll(datesInBetween(skip['startDate'], skip['endDate']));
//   }
//   return dates.toList();
// }

// bool dateSkipped(DateTime date, String its, List<Map> skipsList) {
//   return skipsList
//       .where((skip) => skip["its"] == its)
//       .any((skip) => dateInRange(date, skip['startDate'], skip['endDate']));
// }

showSnackBar(context, String text) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

List<DateTime> datesInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  return days;
}

Future<Map?> fetch(String path, [Map? data]) async {
  Response responseFromAPI = await dio.get(path, data: data);
  try {
    if (responseFromAPI.statusCode == 200) {
      return responseFromAPI.data as Map;
    } else {
      return null;
    }
  } catch (errorMsg) {
    return null;
  }
}

Future<Map?> post(String path, [Map? data]) async {
  Response responseFromAPI = await dio.post(path, data: data);
  try {
    if (responseFromAPI.statusCode == 200) {
      return responseFromAPI.data as Map;
    } else {
      return null;
    }
  } catch (errorMsg) {
    return null;
  }
}
