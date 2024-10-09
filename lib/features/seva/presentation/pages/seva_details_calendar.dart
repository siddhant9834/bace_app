import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/seva/presentation/widgets/edit_seva_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// class SevaDetailsArguments {
//   final String inputEmail;
//   final String seva;
//   final String fullName;

//   SevaDetailsArguments({
//     required this.inputEmail,
//     required this.seva,
//     required this.fullName,
//   });
// }

class SevaDetailsScreen extends StatefulWidget {
  // const SevaDetailsScreen({super.key, required this.inputEmail, required this.seva, required this.fullName});
  // final String inputEmail;
  
  // final String  seva;
  
  final String fullName;
    final String inputEmail;
  final String seva;

  const SevaDetailsScreen({
    Key? key,
    required this.inputEmail,
    required this.seva,
    required this.fullName,
  }) : super(key: key);


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
      appBar: AppBar(title: const Text("Daily Seva Details")),
      body: Column(
        children: [
            Flexible(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    'Name : ${widget.fullName}',
                    style: Fonts.firasans(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: ColorPallete.blackColor,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    'Seva : ${widget.seva}',
                    style: Fonts.firasans(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: ColorPallete.blackColor,
                    ),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Container(
                decoration: BoxDecoration(
                    // color: ColorPallete.blueColor,
                        color: _dailyWorkStatus[_selectedDay] == '✔ Completed' ? Colors.green : Colors.red, // Change color based on status

                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Seva for ${DateFormat('dd MMMM yyyy').format(_selectedDay)} is ${_dailyWorkStatus[_selectedDay] == '✔ Completed' ? '✔ Completed' : '✘ Not Completed'}",

                  // "Seva for ${_selectedDay.toLocal()} is ${_dailyWorkStatus[_selectedDay] == '✔ Completed' ? '✔ Completed' : '✘ Not Completed'}",
                  style: Fonts.popins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ),

            ElevatedButton(
               style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 65, 135, 240),
                      ),
              onPressed: (){
                sevaUpdateDialog(context, widget.inputEmail, widget.seva, widget.fullName);
                
              },
              child: Text('Change Seva', style: Fonts.ubuntu(fontSize: 20, fontWeight: FontWeight.w500, color: ColorPallete.blackColor),),
              
            ),

            
        ],
      ),
    );
  }
}
