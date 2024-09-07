import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SevaDetailsScreen extends StatefulWidget {
  const SevaDetailsScreen({super.key, required this.inputEmail});
  final String inputEmail;

  @override
  State<SevaDetailsScreen> createState() => _SevaDetailsScreenState();
}

class _SevaDetailsScreenState extends State<SevaDetailsScreen> {
  Map<DateTime, String> _dailyWorkStatus = {}; 
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchDailyWorkStatus(widget.inputEmail);  
  }

  void _fetchDailyWorkStatus(String inputEmail) {
    FirebaseFirestore.instance
        .collection("seva_calendar")
        .doc(inputEmail)
        .get()
        .then((doc) {
      if (doc.exists) {
        setState(() {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data.forEach((key, value) {
            DateTime date = DateTime.parse(key);
            _dailyWorkStatus[date] = value["status"];
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Seva")),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime(2023, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_dailyWorkStatus.containsKey(day)) {
                  return Container(
                    margin: const EdgeInsets.all(9.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _dailyWorkStatus[day] == "✔ Completed"
                          ? Colors.green
                          : Colors.red,
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          if (_dailyWorkStatus[_selectedDay] != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Task for ${_selectedDay.toLocal()} is ${_dailyWorkStatus[_selectedDay] == '✔ Completed' ? '✔ Completed' : '✘ Not Completed'}",
              ),
            ),
        ],
      ),
    );
  }
}

// class SevaDetailsScreen extends StatefulWidget {
//    SevaDetailsScreen({super.key, required this.inputEmail});
//   final String inputEmail;

//   @override
//   State<SevaDetailsScreen> createState() => _SevaDetailsScreenState();
// }

// class _SevaDetailsScreenState extends State<SevaDetailsScreen> {
//   Map<DateTime, String> _dailyWorkStatus = {}; 

//   DateTime _selectedDay = DateTime.now();

//   void _fetchDailyWorkStatus(String inputEmail) {

//       FirebaseFirestore.instance
//           .collection("seva_calendar")
//           .doc(inputEmail)
//           .get()
//           .then((doc) {
//         if (doc.exists) {
    
//             Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//             data.forEach((key, value) {
//               DateTime date = DateTime.parse(key);
//               _dailyWorkStatus[date] = value["status"];
//             });
     
//         }
//       });
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Daily Seva")),
//       body: Column(
//         children: [
     
//           TableCalendar(
//             focusedDay: _selectedDay,
//             firstDay: DateTime(2023, 1, 1),
//             lastDay: DateTime(2030, 12, 31),
//             selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//             onDaySelected: (selectedDay, focusedDay) {
         
//             },
//             calendarBuilders: CalendarBuilders(
//               defaultBuilder: (context, day, focusedDay) {
//                 if (_dailyWorkStatus.containsKey(day)) {
//                   return Container(
//                     margin: EdgeInsets.all(9.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: _dailyWorkStatus[day] == "✔ Completed"
//                           ? Colors.green
//                           : Colors.red,
//                       shape: BoxShape.rectangle,
//                     ),
//                     child: Center(
//                       child: Text(
//                         day.day.toString(),
//                         style: TextStyle(color: Colors.white, fontSize: 15),
//                       ),
//                     ),
//                   );
//                 }
//                 return null;
//               },
//             ),
//           ),
//           if (_dailyWorkStatus[_selectedDay] != null)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "Task for ${_selectedDay.toLocal()} is ${_dailyWorkStatus[_selectedDay] == '✔ Completed' ? '✔ Completed' : '✘ Not Completed'}",
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
