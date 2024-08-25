// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:mayapur_bace/features/home/presentation/pages/quote_screen.dart';

// class DatePickerWidget extends StatefulWidget {
//   @override
//   _DatePickerWidgetState createState() => _DatePickerWidgetState();
// }

// class _DatePickerWidgetState extends State<DatePickerWidget> {
//   DateTime? selectedDate;

//   Future<void> selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(), // Use current date if null
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });

//       // Navigate to the ShowPerticularQuoteScreen with the selected date
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ShowPerticularQuoteScreen(selectDate: selectedDate!),
//         ),
//       );

//       log(selectedDate.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Date Picker Example"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               selectedDate != null
//                   ? "Selected Date: ${selectedDate!.toLocal()}".split(' ')[0]
//                   : "No date selected",
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => selectDate(context),
//               child: Text("Select Date"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
