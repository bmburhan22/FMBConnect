class Menu {
  final int day, month, year;
  final List<String> items;
  const Menu(this.day, this.month, this.year, this.items);
}

const List<Menu> menusList = [
  Menu(11, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(12, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(13, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(14, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(15, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(16, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(17, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(18, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(19, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(20, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(21, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(22, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(23, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(24, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(25, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(26, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(27, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(28, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(29, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
  Menu(30, 6, 2024,  ['Dal', 'Rice', 'Gajar Halwa', 'Roti','Dal', 'Rice', 'Gajar Halwa', 'Roti']),
];

final List<Map<String, dynamic>> skipsList = [
  {
    "its": "9",
    "startDate":
        DateTime.fromMillisecondsSinceEpoch(1719262800000), // KWT: Tuesday, June 25, 2024 12:00:00 AM GMT+03:00

    "endDate": DateTime.fromMillisecondsSinceEpoch(1719262800000)
  },
  {
    "its": "9",
    "startDate":
        DateTime.fromMillisecondsSinceEpoch(1719435600000), // KWT: Thursday, June 27, 2024 12:00:00 AM GMT+03:00

    "endDate": DateTime.fromMillisecondsSinceEpoch(1719694800000) // KWT: Thursday, June 30, 2024 12:00:00 AM GMT+03:00
  }
// TODO convert day-1 9 PM (GMT) to local time for correct comparisions when fetched
// TODO convert back to GMT (local_datetime.subtract(tz offset)) when posting data
];
