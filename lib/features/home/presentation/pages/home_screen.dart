// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mayapur_bace/core/side_drawer/pages/drawer.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:intl/intl.dart';
import 'package:mayapur_bace/features/home/data/model/quote_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    var formatter = DateFormat('dd-MMM');
    String formattedDate = formatter.format(now);
  
    QuoteDetails? quoteDetails = QuoteDetails.getQuoteForDate(formattedDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.logoutRedColor,
        elevation: 2,
        title: Text(
          'Mayapur Bace',
          style: Fonts.alata(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: ColorPallete.blackColor),
        ),
      ),
      drawer: NavigationDrawerCustom(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
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
                            quoteDetails?.quote ?? 'No quote available for today',
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
                          '- ${quoteDetails?.location ?? ''}',
                          style: TextStyle(fontSize: 20.0),
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
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: ColorPallete.orangeColor,
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
}
