// import 'dart:developer';
// import 'package:flutter/material.dart';

// class DatePickerExample extends StatefulWidget {
//   @override
//   _DatePickerExampleState createState() => _DatePickerExampleState();
// }

// class _DatePickerExampleState extends State<DatePickerExample> {
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
//         title: Text('Date Picker Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => selectDate(context),
//           child: Text('Pick a Date'),
//         ),
//       ),
//     );
//   }
// }

// class ShowPerticularQuoteScreen extends StatelessWidget {
//   final DateTime selectDate;

//   const ShowPerticularQuoteScreen({required this.selectDate});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Selected Date Quote'),
//       ),
//       body: Center(
//         child: Text(
//           'Selected Date: ${selectDate.toString()}',
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
