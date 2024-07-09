// import 'package:flutter/material.dart';
// import 'package:fmb_connect/functions.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// Widget cellBuilder(DateRangePickerCellDetails details, String its, DateRangePickerController controller,
//     {Color rangeColor = Colors.teal,
//     Color selectionColor = Colors.teal,
//     Color specialColor=Colors.red,
//     Color specialTextColor=Colors.white,
//     Color selectionTextColor=Colors.white,
//     Color textColor=Colors.black}) {
//   PickerDateRange dateRange = controller.selectedRange!;

//   DateTime date = details.date, startDate = dateRange.startDate!;
//   DateTime? endDate = dateRange.endDate;
//   bool isSkipped = dateSkipped(details.date, its);
//   bool isWithinSelection = dateInRange(date, startDate, endDate);
//   bool isSelectionStart = date == startDate;
//   bool isSelectionEnd = endDate != null && date == endDate;
//   bool isSelected = isSelectionStart || isSelectionEnd;

//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Stack(
//         alignment: Alignment.center,
//         children: [
//           Align(
//               alignment: isSelectionStart
//                   ? Alignment.centerRight
//                   : isSelectionEnd
//                       ? Alignment.centerLeft
//                       : Alignment.center,
//               child: Container(
//                 height: 35,
//                 width: startDate == (endDate ?? startDate)
//                     ? 0
//                     : isSelected
//                         ? details.bounds.width / 2
//                         : isWithinSelection
//                             ? details.bounds.width
//                             : 0,
//                 color: rangeColor,
//               )),
//           Container(
//             height: 35,
//             width: 35,
//             decoration: BoxDecoration(
//                 color: isSelected ? selectionColor : Colors.transparent, borderRadius: BorderRadius.circular(20)),
//           ),
//           Container(
//             alignment: Alignment.center,
//             height: 25,
//             width: 25,
//             decoration: BoxDecoration(
//                 color: isSkipped ? specialColor : Colors.transparent, borderRadius: BorderRadius.circular(15)),
//             child: Text(
//               details.date.day.toString(),
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: isWithinSelection
//                       ? selectionTextColor
//                       : isSkipped
//                           ? specialTextColor
//                           : textColor),
//             ),
//           )
//         ],
//       ),
//       Icon(
//         color: isSkipped ? specialColor : Colors.transparent,
//         Icons.block,
//         size: 20,
//       )
//     ],
//   );
// }
