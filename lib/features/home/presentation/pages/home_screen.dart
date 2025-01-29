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
    TextEditingController noticeController= TextEditingController(text: 'No notice for today');
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
          child: Column(
            children: [
              BlocProvider(
                create: (context) => HomeBloc(quoteDetails: quoteDetails)
                  ..add(
                      ShowQuoteEvent(formattedDate: formattedDate.toString())),
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
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Expanded(
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //       shape: ContinuousRectangleBorder(
                  //           borderRadius: BorderRadius.circular(25)),
                  //       elevation: 5,
                  //       backgroundColor: ColorPallete.purpleButtonColor,
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  //     ),
                  //     child: Text(
                  //       textAlign: TextAlign.center,
                  //       "Today's special occasion",
                  //       style: Fonts.ubuntu(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w500,
                  //           color: Colors.black),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: 20),
                  ElevatedButton(
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
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
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
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2,
                color: ColorPallete.orangeColor,
                margin: const EdgeInsets.symmetric(
                  vertical: 4,
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Notice',
                            textAlign: TextAlign.start,
                            style: Fonts.firasans(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: ColorPallete.blackColor,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          // IconButton(padding: EdgeInsets.zero,iconSize: 20,onPressed: (){}, icon: Icon(Icons.edit_document)),
                          Text(
                            '18-11-2024 12:00',
                            textAlign: TextAlign.start,
                            style: Fonts.firasans(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: ColorPallete.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      endIndent: 6,
                      indent: 6,
                      height: 2,
                      color: ColorPallete.blackColor,
                      thickness: 2,
                    ),
                    Container(
                      // height: 160,
                      padding: EdgeInsets.all(8),
                      // decoration: BoxDecoration(
                      // color: ColorPallete.whiteColor,
                      // border: Border.all(
                      //     color: ColorPallete.greyColor, width: 2),
                      // borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: [
                          Text(
                            noticeController.text,
                              // 'You are in Mayapur BACE for your selfimprovement You are in Mayapur BACE for your selfimprovement You are in Mayapur BACE for your selfimprovement',
                              style: Fonts.alata(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: ColorPallete.blackColor)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 22,
                                  onPressed: () {},
                                  icon: Icon(Icons.edit_document)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(12.0),
              //   ),
              //   elevation: 2,
              //   color: ColorPallete.orangeColor,
              //   margin: EdgeInsets.symmetric(
              //     vertical: 4,
              //   ),
              //   child: Column(
              //     children: [
              //       Align(
              //         alignment: Alignment.topRight,
              //         child: Padding(
              //           padding: const EdgeInsets.all(2.0),
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(
              //                 vertical: 1.0, horizontal: 8.0),
              //             child: Text(
              //               '18-11-2024',
              //               textAlign: TextAlign.start,
              //               style: Fonts.firasans(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w400,
              //                 color: ColorPallete.blackColor,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(4.0),
              //         child: Container(
              //           height: 160,
              //           padding: EdgeInsets.all(8),
              //           decoration: BoxDecoration(
              //               color: ColorPallete.whiteColor,
              //               border: Border.all(
              //                   color: ColorPallete.greyColor, width: 2),
              //               borderRadius: BorderRadius.circular(10.0)),
              //           child: const TextField(
              //             cursorHeight: 30,
              //             autofocus: true,
              //             style: TextStyle(color: Colors.white, fontSize: 30),
              //             decoration: InputDecoration.collapsed(
              //               hintText: "Notice",
              //               // hintStyle: Fonts.alata(fontSize: 10, fontWeigh, color: color)
              //               border: InputBorder.none,
              //             ),
              //             maxLines: 1,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // )
              // Container(
              //   height: 180,
              //   padding: EdgeInsets.all(8),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: ColorPallete.greyColor, width: 2),
              //       borderRadius: BorderRadius.circular(10.0)),
              //   child: const TextField(
              //     cursorHeight: 30,
              //     autofocus: true,
              //     style: TextStyle(color: Colors.white, fontSize: 30),
              //     decoration: InputDecoration.collapsed(

              //       hintText: "Notice",
              //       // hintStyle: Fonts.alata(fontSize: 10, fontWeigh, color: color)
              //       border: InputBorder.none,
              //     ),
              //     maxLines: 1,
              //   ),
              // )
            ],
          ),
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
