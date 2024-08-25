import 'package:flutter/material.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';

// Widget customAppBar(String title) {
//   return AppBar(
//     backgroundColor: ColorPallete.blueColor,
//     elevation: 2,
//     title: Text(
//       title,
//       // 'Photos Categories',
//       style: Fonts.alata(
//           fontSize: 22,
//           fontWeight: FontWeight.w400,
//           color: ColorPallete.blackColor),
//     ),
//   );
// }
class ApplicationToolbar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  
  final Color color;

   ApplicationToolbar({super.key, required this.title, required this.color});

  
  @override
  Widget build(BuildContext context) {

    return AppBar(
    backgroundColor: color,
    elevation: 2,
    title: Text(
      title,
      // 'Photos Categories',
      style: Fonts.alata(
          fontSize: 25,
          fontWeight: FontWeight.w400,
          color: ColorPallete.blackColor),
    ),
  );
  
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}