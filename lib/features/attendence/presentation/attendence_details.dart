import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
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

class AttendenceDetailsScreen extends StatefulWidget {
  // const AttendenceDetailsScreen({super.key, required this.inputEmail, required this.seva, required this.fullName});
  // final String inputEmail;

  // final String  seva;
  final String inputEmail;
  final String fullName;

  const AttendenceDetailsScreen({
    Key? key,
    required this.inputEmail,
    required this.fullName,
  }) : super(key: key);

  @override
  State<AttendenceDetailsScreen> createState() => _AttendenceDetailsState();
}

class _AttendenceDetailsState extends State<AttendenceDetailsScreen> {
  Map<DateTime, Map<String, String>> _dailyAttendenceStatus = {};
  DateTime _selectedDay = DateTime.now();
  late String formattedTime;

  @override
  void initState() {
    super.initState();
    formattedTime = DateFormat('hh:mm').format(_selectedDay);

    _fetchDailyWorkStatus(widget.inputEmail);
  }

  void _fetchDailyWorkStatus(String inputEmail) {
    FirebaseFirestore.instance
        .collection("morning_program_attendence")
        .doc(inputEmail)
        .get()
        .then((doc) {
      if (doc.exists) {
        setState(() {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data.forEach((key, value) {
            DateTime date = DateTime.parse(key);
            _dailyAttendenceStatus[date] = {
              "status": value["status"],
              "markingTime": value["markingTime"]
            };
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Attendence Details",
          style: Fonts.nunitoSans(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: ColorPallete.blackColor,
          ),
        ),
        backgroundColor: ColorPallete.whiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: ListView(
          // shrinkWrap: true,
          // child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Name: ',
                    style: Fonts.firasans(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: ColorPallete.blackColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.fullName,
                        style: Fonts.firasans(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: ColorPallete.darkDlueColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                    fontWeight: FontWeight.w600),
                todayTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                weekendTextStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.orange,
                ),
                defaultTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                selectedDecoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.red,
                          width: 5,
                          strokeAlign: BorderSide.strokeAlignCenter)),
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                formatButtonVisible: false,
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                weekendStyle: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  if (_dailyAttendenceStatus.containsKey(day)) {
                    return Container(
                      margin: const EdgeInsets.all(9.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _dailyAttendenceStatus[day]?["status"] ==
                                '✔ Present'
                            ? Colors.green
                            : _dailyAttendenceStatus[day]?["status"] == 'Late'
                                ? Colors.orange
                                : _dailyAttendenceStatus[day]?["status"] ==
                                        '✘ Absent'
                                    ? Colors.red
                                    : null,
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
            if (_dailyAttendenceStatus[_selectedDay] != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Container(
                  decoration: BoxDecoration(
                      // color: ColorPallete.blueColor,
                      color: _dailyAttendenceStatus[_selectedDay]?["status"] ==
                              '✔ Present'
                          ? Colors.green
                          : _dailyAttendenceStatus[_selectedDay]?["status"] ==
                                  'Late'
                              ? Colors.orange
                              : _dailyAttendenceStatus[_selectedDay]
                                          ?["status"] ==
                                      '✘ Absent'
                                  ? Colors.red
                                  : Colors.blue,
                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "Attendence for ${DateFormat('dd MMMM yy').format(_selectedDay)} is ${_dailyAttendenceStatus[_selectedDay]?['status'] == '✔ Present' ? '✔ Present' : _dailyAttendenceStatus[_selectedDay]?['status'] == 'Late' ? 'Late' : _dailyAttendenceStatus[_selectedDay]?['status'] == '✘ Absent' ? '✘ Absent' : 'Pending'} is Marked on: ${_dailyAttendenceStatus[_selectedDay]?['markingTime']}",

                    // "Seva for ${_selectedDay.toLocal()} is ${_dailyAttendenceStatus[_selectedDay] == '✔ Completed' ? '✔ Completed' : '✘ Not Completed'}",
                    style: Fonts.popins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
