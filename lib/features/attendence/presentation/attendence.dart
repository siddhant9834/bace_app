import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/seva/presentation/pages/seva_list_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';

class AttendenceCalendar extends StatefulWidget {
  const AttendenceCalendar({super.key});

  @override
  _DailyWorkScreenState createState() => _DailyWorkScreenState();
}

class _DailyWorkScreenState extends State<AttendenceCalendar> {
  // DateTime _selectedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  // Map<DateTime, String> _dailyAttendenceStatus = {};
  Map<DateTime, Map<String, String>> _dailyAttendenceStatus = {};
  String? userEmail;
  late String formattedTime;
  String presentTimeStart = "04:00";
  String presentTimeEnd = "04:30";
  String lateTimeStart = "04:30";
  String lateTimeEnd = "04:45";
  // late String cleanFormattedTime;
  late String formattedTimeWithDate;
  @override
  void initState() {
    super.initState();
    formattedTime = DateFormat('hh:mm').format(_selectedDay);
    log(formattedTime.toString());
    _fetchUserEmail();
  }

  Future<void> _fetchUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email;
      });
      _fetchDailyAttendenceStatus();
    }
  }

  void _fetchDailyAttendenceStatus() {
    if (userEmail != null) {
      FirebaseFirestore.instance
          .collection("morning_program_attendence")
          .doc(userEmail)
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
              // _dailyAttendenceStatus[date] = value["status"];
            });
          });
        }
      });
    }
  }

  void showMessageDialog(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Message',
              style: TextStyle(fontSize: 30),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: Fonts.nunitoSans(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: ColorPallete.blackColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(255, 65, 135, 240),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: Fonts.ubuntu(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: ColorPallete.blackColor),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.fadeYellow,
      appBar: AppBar(
        title: Text(
          "Attendence",
          style: Fonts.nunitoSans(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: ColorPallete.blackColor,
          ),
        ),
        backgroundColor: ColorPallete.fadeYellow,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Your Daily Attendence",
                style: Fonts.firasans(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: ColorPallete.skyBlueColorDark),
              ),
            ),
            if (currentUsersSeva != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    children: [],
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
//  if (currentUsersSeva == "NA") {
//                   showMessageDialog(
//                       "You can update only between 4:00 AM to 4:45 AM (Morning Only)");
//                 }
                if(DateFormat('dd MMM yyyy').format(_selectedDay) == DateFormat('dd MMM yyyy').format(DateTime.now())){
                  _showTaskDialog(_dailyAttendenceStatus);

                  // _showTaskDialog(
                  //     _dailyWorkStatus); // Show the dialog to update the status
                }
                else{
                      showMessageDialog(
                      "You can mark only todays (${DateFormat('dd-MMM').format(DateTime.now())}) attendence ");
                }

                // if (currentUsersSeva == "NA") {
                //   showMessageDialog(
                //       "You cannot update seva as it is not assigned. If you want Seva, contact the Seva Incharge or OC.");
                // } else {
                // _showTaskDialog(_dailyAttendenceStatus);
                // }
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
                  color: Colors.orange,
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
                      margin: EdgeInsets.all(9.0),
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
                          style: TextStyle(color: Colors.white, fontSize: 15),
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
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
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "Attendence for ${DateFormat('dd-MMM-yy').format(_selectedDay)} is ${_dailyAttendenceStatus[_selectedDay]?['status'] == '✔ Present' ? '✔ Present' : _dailyAttendenceStatus[_selectedDay]?['status'] == 'Late' ? 'Late' : _dailyAttendenceStatus[_selectedDay]?['status'] == '✘ Absent' ? '✘ Absent' : 'Pending'}",
                    style: Fonts.popins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorPallete.blackColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showTaskDialog(
      Map<DateTime, Map<String, String>> _dailyAttendenceStatus) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Attendence for ${DateFormat('dd MMMM yy').format(_selectedDay)}  Marking Time: ${_dailyAttendenceStatus[_selectedDay]?["markingTime"] ?? formattedTime}",
                // DateFormat("yyyy-MM-dd HH:mm:ss")
                // DateFormat.yMd(_selectedDay).add_jm().toString(),
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
                  // ${_dailyAttendenceStatus[_selectedDay]?["status"]}
                  _dailyAttendenceStatus[_selectedDay]?["status"] ?? 'Pending',
                  style: Fonts.nunitoSans(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: _dailyAttendenceStatus[_selectedDay]?["status"] ==
                            '✔ Present'
                        ? Colors.green
                        : _dailyAttendenceStatus[_selectedDay]?["status"] ==
                                'Late'
                            ? Colors.orange
                            : _dailyAttendenceStatus[_selectedDay]?["status"] ==
                                    '✘ Absent'
                                ? Colors.red
                                : Colors.blue,

                    // _dailyAttendenceStatus[_selectedDay]?["status"] == '✔ Present'
                    //     ? Colors.green:
                    //     _dailyAttendenceStatus[_selectedDay]?["status"] == 'Late' ?Colors.orange:

                    //     _dailyAttendenceStatus[_selectedDay]?["status"] == '✔ Absent'
                    //         ? Colors.red
                    //         : Colors.blue,
                  ),
                ),
                // child: Text(
                //   '${_dailyWorkStatus[_selectedDay]}',
                //   style: Fonts.nunitoSans(
                //     fontSize: 30,
                //     fontWeight: FontWeight.w500,
                //     color: _dailyWorkStatus[_selectedDay] == '✔ Completed'
                //         ? Colors.green
                //         : Colors.red,
                //   ),
                // ),
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
                    formattedTimeWithDate =
                        DateFormat('dd-MMM-yyyy hh:mm a').format(DateTime.now());

                    if (DateFormat("HH:mm").parse(formattedTime).isAfter(
                            DateFormat("HH:mm").parse(presentTimeStart)) &&
                        DateFormat("HH:mm").parse(formattedTime).isBefore(
                            DateFormat("HH:mm").parse(presentTimeEnd))) {
                      _updateTaskStatus("✔ Present", formattedTimeWithDate);
                    } else if (DateFormat("hh:mm").parse(formattedTime).isAfter(
                            DateFormat("hh:mm").parse(lateTimeStart)) &&
                        DateFormat("hh:mm")
                            .parse(formattedTime)
                            .isBefore(DateFormat("hh:mm").parse(lateTimeEnd))) {
                      _updateTaskStatus("Late", formattedTimeWithDate);
                    } else {
                      _updateTaskStatus("✘ Absent", formattedTimeWithDate);
                    }

                    Future.delayed(Duration(milliseconds: 200), () {
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
                    formattedTimeWithDate =
                        DateFormat('hh:mm dd-MMM-yyyy').format(DateTime.now());

                    _updateTaskStatus("✘ Absent", formattedTimeWithDate);

                    Future.delayed(Duration(milliseconds: 200), () {
                      Navigator.pop(context);
                    });
                  }),
              IconButton(
                  icon: Icon(
                    Icons.running_with_errors_sharp,
                    color: ColorPallete.orangeColor,
                    size: 40,
                  ),
                  onPressed: () {
                    formattedTimeWithDate =
                        DateFormat('hh:mm dd-MMM-yyyy').format(DateTime.now());
                    if (DateFormat("HH:mm").parse(formattedTime).isAfter(
                            DateFormat("HH:mm").parse(presentTimeStart)) &&
                        DateFormat("HH:mm").parse(formattedTime).isBefore(
                            DateFormat("HH:mm").parse(presentTimeEnd))) {
                      _updateTaskStatus("✔ Present", formattedTimeWithDate);
                    } else if (DateFormat("hh:mm").parse(formattedTime).isAfter(
                            DateFormat("hh:mm").parse(lateTimeStart)) &&
                        DateFormat("hh:mm")
                            .parse(formattedTime)
                            .isBefore(DateFormat("hh:mm").parse(lateTimeEnd))) {
                      log("berfore late");
                      _updateTaskStatus("Late", formattedTimeWithDate);
                      log("berfore late");

                      Future.delayed(Duration(milliseconds: 200), () {
                        Navigator.pop(context);
                      });
                      log("berfore late");
                    }
                    else{
                          showMessageDialog(
                      "You can mark late in between 4:30 AM to 4:45 AM");
                    }
               
                    log("Current Time: $formattedTime");
                    log("Late Start: $lateTimeStart, Late End: $lateTimeEnd");

                    // _updateTaskStatus("Late", formattedTime);
                  }),
            ],
          ),
        );
      },
    );
  }

  void _updateTaskStatus(String status, String time) async {
    // final formattedDateTime = DateFormat('dd-MM-yy' 'HH:mm:ss').format(_selectedDay);
    log(_selectedDay.toString());
    setState(() {
      _dailyAttendenceStatus[_selectedDay]?["status"] = status;
      _dailyAttendenceStatus[_selectedDay]?["markingTime"] = time;
      log(_dailyAttendenceStatus[_selectedDay].toString());
    });

    if (userEmail != null) {
      log(userEmail.toString());

      FirebaseFirestore.instance
          .collection("morning_program_attendence")
          .doc(userEmail)
          .set(
        {
          _selectedDay.toIso8601String(): {
            "status": status,
            "markingTime": time
          },
        },
        SetOptions(merge: true),
      );
      _fetchDailyAttendenceStatus();
    }
  }
}
