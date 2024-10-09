import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              _showTaskDialog(_dailyWorkStatus);
            },
            calendarStyle: const CalendarStyle(
              
              selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                  ),
              todayTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              weekendTextStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                  fontSize: 16,

                color: Colors.orange, // Text color for weekends
              ),
              defaultTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
            titleTextStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Header title text color
            ),
            formatButtonVisible: false, // Hide format button
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Colors.black, // Left chevron icon color
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Colors.black, // Right chevron icon color
            ),
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: Colors.blue, 
                fontSize: 16,
              fontWeight: FontWeight.w600 // Text color for weekdays
            ),
            weekendStyle: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 16,
              fontWeight: FontWeight.w600 // Text color for weekends
            ),
          ),
        
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
                    color: _dailyWorkStatus[_selectedDay] == '✔ Completed'
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Seva for ${DateFormat('dd MMMM yyyy').format(_selectedDay)} is ${_dailyWorkStatus[_selectedDay] == '✔ Completed' ? '✔ Completed' : '✘ Not Completed'}",
                  style: Fonts.popins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: ColorPallete.blackColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showTaskDialog(Map<DateTime, String> _dailyWorkStatus) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seva for ${DateFormat('dd MMMM yyyy').format(_selectedDay)}",
                // style: Fonts.nunitoSans(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.black),
                style: Fonts.nunitoSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: ColorPallete.blackColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '${_dailyWorkStatus[_selectedDay]}',
                  style: Fonts.nunitoSans(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: _dailyWorkStatus[_selectedDay] == '✔ Completed'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              )
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 40,
                  ),
                  onPressed: () {
                    _updateTaskStatus("✔ Completed");
                    Future.delayed(Duration(milliseconds: 700), () {
                      Navigator.pop(context);
                    });
                  }),
              IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.red,
                    size: 40,
                  ),
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
