
// DateTime? selectedDate;

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