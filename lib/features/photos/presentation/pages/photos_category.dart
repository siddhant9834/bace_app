import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/photos/presentation/widgets/upload_photos_sheet.dart';

class PhotosCategory extends StatelessWidget {
  const PhotosCategory({super.key});

  @override
  Widget build(BuildContext context) {
    // List<String> photoCategory = [
    //   'Yatra',
    //   'Jagannath Festival',
    //   'Temple',
    //   'Life at Bace,',
    //   'Seva',
    //   'Memories'
    // ];
    Map<String, String> imageDetails = {
      'Yatra': 'assets/images/thumbnail_images/yatra.jpg',
      'Jagannath Festival':
          'assets/images/thumbnail_images/jagannathfestival.jpg',
      'Temple': 'assets/images/thumbnail_images/temple.jpg',
      'Life at Bace': 'assets/images/thumbnail_images/lifeatbace.jpg',
      'Seva': 'assets/images/thumbnail_images/seva.jpg',
      'Memories': 'assets/images/thumbnail_images/memories.jpg',
    };

    return Scaffold(
      // appBar: ApplicationToolbar(
      //   title: 'Photos Categories',
      //   color: ColorPallete.blueColor,
      // ),
      // drawer: NavigationDrawerCustom(),
      body: ListView.builder(
          padding: EdgeInsets.all(3),
          itemCount: imageDetails.length,
          itemBuilder: (ctx, index) {
            final category = imageDetails.keys.elementAt(index);
            final imageUrl = imageDetails[category]!;
            return GestureDetector(
              onTap: () {
                // context.go('/seva');
                // context.go('/images_screen');
                final selectedCategory =
                    category; // Replace with the actual category
                context.go(
                  '/images/image_screen',
                  extra: selectedCategory,
                );

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         CategoryImagesPage(category: category),
                //   ),
                // );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                //           color: ColorPallete.offWhiteListTileColor,
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        child: Image.asset(
                          imageUrl,
                          //  'assets/images/thumbnail_images/lifeatbace.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 8.0),
                        child: Text(
                          category,
                          textAlign: TextAlign.start,
                          style: Fonts.firasans(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: ColorPallete.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => PostPhoto()),
          // );
          showImagePickerOption(context, imageDetails.keys.toList());
        },
        label: Text(
          'Add Photo',
          style: Fonts.ubuntu(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: ColorPallete.whiteColor),
        ),
        icon: Icon(Icons.add_a_photo_outlined),
        backgroundColor: ColorPallete.greenColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
