import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/core/widgets/app_bar.dart';
import 'package:mayapur_bace/features/home/data/model/quote_model.dart';

class ShowPerticularQuoteScreen extends StatelessWidget {
  final DateTime selectDate;

  const ShowPerticularQuoteScreen({super.key, required this.selectDate});

  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat('dd-MMM');
    String formattedDate = formatter.format(selectDate);
    // log(selectDate.toString());
    QuoteDetails? quoteDetails = QuoteDetails.getQuoteForDate(formattedDate);
    return Scaffold(
            // appBar: ApplicationToolbar(title: 'Quote Screen', color: ColorPallete.blueColor,),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: ColorPallete.registerPageTitleColor,
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Column(
                  children: [
                    Text(
                      'Quote for ${formatter.format(selectDate)}',
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
                      quoteDetails!.quote ?? 'No quote available for today',
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
                    '- ${quoteDetails!.location ?? ''}',
                    style:
                        TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
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
        // child: Card(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(15.0),
        //   ),
        //   color: ColorPallete.orangeColor,
        //   elevation: 5,
        //   child: ListTile(
        //     contentPadding: EdgeInsets.all(16),
        //     title: Column(
        //       children: [
        //         Text(
        //           'Quote for ${formatter.format(selectDate)}',
        //           textAlign: TextAlign.center,
        //           style: Fonts.nunitoSans(
        //               fontSize: 20,
        //               fontWeight: FontWeight.w500,
        //               color: ColorPallete.blackColor),
        //         ),
        //         const SizedBox(height: 10),
        //         Text(
        //           textAlign: TextAlign.justify,
        //           quoteDetails?.quote ?? 'No quote available for this day',
        //           style: Fonts.nunitoSans(
        //               fontSize: 18,
        //               fontWeight: FontWeight.w400,
        //               color: ColorPallete.blackColor),
        //         ),
        //       ],
        //     ),
        //     subtitle: Align(
        //       heightFactor: 1.3,
        //       alignment: Alignment.bottomRight,
        //       child: Text(
        //         '- ${quoteDetails?.location ?? ''}',
        //         style: TextStyle(
        //             fontSize: 16.0,
        //             fontStyle: FontStyle.italic,
        //             color: ColorPallete.blackColor),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
