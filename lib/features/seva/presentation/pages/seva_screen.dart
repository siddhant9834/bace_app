import 'package:flutter/material.dart';
import 'package:mayapur_bace/core/side_drawer/pages/drawer.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';

class SevaScreen extends StatelessWidget {
  const SevaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.blueColor,

        elevation: 2,
        title: Text(
          'Seva',
          style: Fonts.alata(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: ColorPallete.blackColor),
        ),
      ),
      drawer: NavigationDrawerCustom(),
    );
  }
}