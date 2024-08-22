import 'package:flutter/material.dart';
import 'package:mayapur_bace/core/side_drawer/pages/drawer.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';

class PhotosCategory extends StatelessWidget {
  const PhotosCategory({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.blueColor,
        elevation: 2,
        title: Text(
          'Photos',
          style: Fonts.alata(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: ColorPallete.blackColor),
        ),
      ),
      drawer: NavigationDrawerCustom(),
      body: GridView.builder(
        padding: EdgeInsets.all(3),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: 8,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () {
          },
          child: Card(
            color: ColorPallete.offWhiteListTileColor,
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    'assets/images/nature.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('Category ${index++}',
                      textAlign: TextAlign.start,
                      style: Fonts.firasans(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: ColorPallete.blackColor,
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
