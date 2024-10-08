import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/seva/presentation/pages/seva_list_screen.dart';
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
          if (currentUsersSeva != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Assigned Seva: $currentUsersSeva",
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
              child: Container(
                decoration: BoxDecoration(
                    color: ColorPallete.blueColor,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Seva for ${_selectedDay.toLocal()} is ${_dailyWorkStatus[_selectedDay] == '✔ Completed' ? '✔ Completed' : '✘ Not Completed'}",
                  style: Fonts.alata(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
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
          title: Text("Seva for ${_selectedDay.toLocal()}"),
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

      FirebaseFirestore.instance.collection("seva_calendar").doc(userEmail).set(
        {
          _selectedDay.toIso8601String(): {"status": status},
        },
        SetOptions(merge: true),
      );
    }
  }
}
