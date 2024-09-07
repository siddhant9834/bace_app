// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:intl/intl.dart';
import 'package:mayapur_bace/features/home/data/model/quote_model.dart';
import 'package:mayapur_bace/features/home/presentation/bloc/home_bloc.dart';
import 'package:mayapur_bace/features/home/presentation/pages/quote_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    var formatter = DateFormat('dd-MMM');
    String formattedDate = formatter.format(now);
    log(formattedDate);
    QuoteDetails? quoteDetails = QuoteDetails.getQuoteForDate(formattedDate);

    return Scaffold(
      //  appBar: ApplicationToolbar(title: 'Mayapur Bace', color: ColorPallete.pinkColor,),
      // drawer: NavigationDrawerCustom(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            BlocProvider(
              create: (context) => HomeBloc(quoteDetails: quoteDetails)
                ..add(ShowQuoteEvent(formattedDate: formattedDate.toString())),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is ShowQuoteState) {
                    return Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: ColorPallete.orangeColor,
                        elevation: 5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Column(
                                children: [
                                  Text(
                                    'Today\'s Prabhupad Quote',
                                    textAlign: TextAlign.center,
                                    style: Fonts.nunitoSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: ColorPallete.blackColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    textAlign: TextAlign.justify,
                                    state.quoteDetails.quote ??
                                        'No quote available for today',
                                    style: Fonts.nunitoSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: ColorPallete.blackColor),
                                  ),
                                ],
                              ),
                              subtitle: Align(
                                heightFactor: 1.3,
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '- ${state.quoteDetails.location ?? ''}',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/hhprabhupad.png',
                                  height: 100,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  // Initial or fallback UI
                  return Center(child: Text('No quote available'));
                },
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: ColorPallete.purpleButtonColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Today's special occasion",
                      style: Fonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // showCalenderSelectionDialog(context);
                      // DatePickerWidget();
                      selectDate(context);

                      // selectDate(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DatePickerExample()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: ColorPallete.orangeColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                    child: Text(
                        textAlign: TextAlign.center,
                        'Find More Quotes',
                        style: Fonts.ubuntu(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  DateTime? selectedDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      // Navigate to the ShowPerticularQuoteScreen with the selected date
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ShowPerticularQuoteScreen(selectDate: selectedDate!),
        ),
      );
      // context.push('/home/show_quote', extra: selectedDate);

      // log(selectedDate.toString());
    }
  }
}
