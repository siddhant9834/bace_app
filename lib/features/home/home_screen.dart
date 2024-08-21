import 'package:flutter/material.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              // width: 800,
              // height: 800,
              padding: new EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: ColorPallete.orangeColor,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Column(
                        children: [
                          Text(
                            'Todays Prabhupad Quote',
                            textAlign: TextAlign.center,
                            style: Fonts.nunitoSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: ColorPallete.blackColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "hari bol hare krishna Hare Krishna Krishna Krishna Hare Hare Hare ram Hare Ram Ram RaM ram ram hare hare ",
                            style: Fonts.nunitoSans(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: ColorPallete.blackColor),
                          ),
                        ],
                      ),
                      subtitle: Align(
                        heightFactor: 2,
                        alignment: Alignment.bottomRight,
                        child: Text('- 20th-Aug-2022',
                            style: TextStyle(fontSize: 20.0)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Positioned(
                            child: Image.asset(
                          'assets/images/hhprabhupad.png',
                          height: 100,
                        )),
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
                SizedBox(
                  // width: double.infinity,
                  child: ElevatedButton( 
                    
                    onPressed: () {},
                    child: Text(
                      "Today's special occasion ",
                      style:   
                      TextStyle(
                          fontSize: 18,
                          color: ColorPallete.blueColor), // Increase font size
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal:14, vertical: 12),
                      // Increase button size
                    ),
                  ),
                ),
                SizedBox(width: 20), // Space between buttons
                SizedBox(
                  // width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // Adjust the size to fit content
                      children: [
                        Text(
                          'More Quotes',
                          style: TextStyle(fontSize: 18), // Increase font size
                        ),
                        SizedBox(width: 8), // Space between text and icon
                        Icon(Icons.arrow_forward), // Add arrow icon
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 11), // Increase button size
                    ),
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
