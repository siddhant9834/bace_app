import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DailySevaScreen extends StatefulWidget {
  const DailySevaScreen({super.key});

  @override
  _DailyWorkScreenState createState() => _DailyWorkScreenState();
}

class _DailyWorkScreenState extends State<DailySevaScreen> {
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, String> _dailyWorkStatus = {}; 
  String? userEmail;
  String? sevaAssigned;

  @override
  void initState() {
    super.initState();
    _fetchUserEmail(); 
  }

  Future<void> _fetchUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email;
      });
      _fetchDailyWorkStatus(); 
    }
  }


  void _fetchDailyWorkStatus() {
    if (userEmail != null) {
      FirebaseFirestore.instance
          .collection("seva_calendar")
          .doc(userEmail)
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daily Seva")),
      body: Column(
        children: [
          if (sevaAssigned != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Assigned Seva: $sevaAssigned",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime(2023, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
              _showTaskDialog(); 
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_dailyWorkStatus.containsKey(day)) {
                  return Container(
                    margin: EdgeInsets.all(9.0),
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
                        style: TextStyle(color: Colors.white, fontSize: 15),
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

  void _showTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Mark task for ${_selectedDay.toLocal()}"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.check, color: Colors.green),
                  onPressed: () {
                    _updateTaskStatus("✔ Completed");
                    Future.delayed(Duration(milliseconds: 700), () {
                      Navigator.pop(context); 
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    _updateTaskStatus("✘ Not Completed");
                    Future.delayed(Duration(milliseconds: 700), () {
                      Navigator.pop(context); 
                    });
                  }),
            ],
          ),
        );
      },
    );
  }

  void _updateTaskStatus(String status) async {
    setState(() {
      _dailyWorkStatus[_selectedDay] = status;
    });

    if (userEmail != null) {
      log(userEmail.toString());

      FirebaseFirestore.instance
          .collection("seva_calendar")
          .doc(userEmail)
          .set(
        {
          _selectedDay.toIso8601String(): {"status": status},
        },
        SetOptions(merge: true),
      );
    }
  }
}

// class DailySevaScreen extends StatefulWidget {
//   @override
//   _DailyWorkScreenState createState() => _DailyWorkScreenState();
// }


// class _DailyWorkScreenState extends State<DailySevaScreen> {
//   DateTime _selectedDay = DateTime.now();
//   Map<DateTime, String> _dailyWorkStatus = {}; // Store task status by date
//   String? userEmail;
//   String? nameOfWork = 'Your Seva';

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserEmail(); // Fetch user email and then daily work status on initialization
//   }

//   // Fetch user's email from FirebaseAuth
//   Future<void> _fetchUserEmail() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       setState(() {
//         userEmail = user.email;
//       });
//       _fetchDailyWorkStatus(); // Fetch daily work status after getting email
//     }
//   }

//   void _fetchDailyWorkStatus() {
//     if (userEmail != null) {
//       FirebaseFirestore.instance
//           .collection("daily_work")
//           .doc(userEmail)
//           .get()
//           .then((doc) {
//         if (doc.exists) {
//           setState(() {
//             // Retrieve the name of work
//             nameOfWork = doc["name_of_work"];
//             log("Name of work: $nameOfWork");

//             // Fetch the daily work status for all dates
//             Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//             data.forEach((key, value) {
//               if (key != "name_of_work" && key != "user_name") {
//                 DateTime date = DateTime.parse(key);
//                 _dailyWorkStatus[date] = value["status"];
//               }
//             });
//           });
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Daily Work")),
//       body: Column(
//         children: [
//           // Display the name of work
//           if (nameOfWork != null)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "Work: $nameOfWork",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//           TableCalendar(
//             focusedDay: _selectedDay,
//             firstDay: DateTime(2023, 1, 1),
//             lastDay: DateTime(2030, 12, 31),
//             selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//             onDaySelected: (selectedDay, focusedDay) {
//               setState(() {
//                 _selectedDay = selectedDay;
//               });
//               _showTaskDialog(); // Show dialog for marking task status
//             },
//             calendarBuilders: CalendarBuilders(
//               defaultBuilder: (context, day, focusedDay) {
//                 if (_dailyWorkStatus.containsKey(day)) {
//                   return Container(
//                     margin:  EdgeInsets.all(9.0),
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

//   void _showTaskDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Mark task for ${_selectedDay.toLocal()}"),
//           content: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                   icon: Icon(Icons.check, color: Colors.green),
//                   onPressed: () {
//                     _updateTaskStatus("✔ Completed");
//                     Future.delayed(Duration(milliseconds: 700), () {
//                       Navigator.pop(context); // Close dialog after the delay
//                     });
//                   }),
//               IconButton(
//                   icon: Icon(Icons.clear, color: Colors.red),
//                   onPressed: () {
//                     _updateTaskStatus("✘ Not Completed");
//                     Future.delayed(Duration(milliseconds: 700), () {
//                       Navigator.pop(context); // Close dialog after the delay
//                     });
//                   }),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _updateTaskStatus(String status) async {
//     setState(() {
//       _dailyWorkStatus[_selectedDay] = status;
//     });

//     if (userEmail != null) {
//       log(userEmail.toString());

//       // Fetch the user's name from the 'users' collection
//       QuerySnapshot userSnapshot = await FirebaseFirestore.instance
//           .collection("users")
//           .where("email", isEqualTo: userEmail)
//           .get();

//       if (userSnapshot.docs.isNotEmpty) {
//         DocumentSnapshot userDoc = userSnapshot.docs.first;
//         String? userName = userDoc["fullName"];

//         // Update the daily_work collection with the task status
//         FirebaseFirestore.instance
//             .collection("daily_work")
//             .doc(userEmail)
//             .set(
//           {
//             "user_name": userName,
//             "name_of_work": nameOfWork,
//             _selectedDay.toIso8601String(): {"status": status},
//           },
//           SetOptions(merge: true),
//         );
//       }
//     }
//   }
// }
