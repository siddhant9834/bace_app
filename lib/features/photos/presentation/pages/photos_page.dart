// import 'package:flutter/material.dart';
// import 'package:mayapur_bace/core/theme/color_pallet.dart';
// import 'package:mayapur_bace/core/theme/fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/photos/data/datasource/firebase_datasource.dart';
import 'package:mayapur_bace/features/photos/domain/usecases/update_image_url.dart';



class CategoryImagesPage extends StatelessWidget {
  final String category;
  final FirebaseDatasource firebaseDatasource = FirebaseDatasource();

  CategoryImagesPage({super.key, required this.category});
//   Future<List<Map<String, String>>> _fetchImages() async {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final List<Map<String, String>>imagesData = [];

//   try {
//     final QuerySnapshot snapshot = await _firestore
//         .collection('photos')
//         .where('category', isEqualTo: category)
//         .get();

//     for (var doc in snapshot.docs) {
//       if (doc.exists && doc.data() != null) {
//         final data = doc.data() as Map<String, dynamic>;
//         final imageUrl = data['url'] as String?;
//         final name= data['name'] as String?;
//          if (imageUrl != null && name != null) {
//           imagesData.add({
//             'url': imageUrl,
//             'name': name,
//           });
//         }
//       }
//     }
//   } catch (e) {
//     print('Error fetching images: $e');
//   }

//   return imagesData;
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ColorPallete.blueColor,
      //   elevation: 2,
      //   title: Text(
      //     '$category Photos',
      //     style: Fonts.alata(
      //         fontSize: 22,
      //         fontWeight: FontWeight.w400,
      //         color: ColorPallete.blackColor),
      //   ),
      // ),
      body: FutureBuilder<List<Map<String, String>>>(
        // future: firebaseDatasource.fetchImages(category),
        future: locator<FetchImage>().call(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading images'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No images available'));
          }

          final imagesData = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(3),
            itemCount: imagesData.length,
            itemBuilder: (ctx, index) => GestureDetector(
              onTap: () {
                // Handle image tap if needed
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: ColorPallete.offWhiteListTileColor,
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        child: Image.network(
                          imagesData[index]['url'].toString(),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 8.0),
                        child: Text(
                          imagesData[index]['name'].toString(),
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
            ),
          );
        },
      ),
    );
  }
}
// class CategoryImagesPage extends StatelessWidget {
//   final String category;
//   final FirebaseDatasource firebaseDatasource = FirebaseDatasource();

//   CategoryImagesPage({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorPallete.blueColor,
//         elevation: 2,
//         title: Text(
//           '$category Photos',
//           style: Fonts.alata(
//               fontSize: 22,
//               fontWeight: FontWeight.w400,
//               color: ColorPallete.blackColor),
//         ),
//       ),
//       body: FutureBuilder<List<Map<String, String>>>(
//         future: locator<FetchImage>().call(category),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Error loading images'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No images available'));
//           }

//           final imagesData = snapshot.data!;

//           return ListView.builder(
//             padding: const EdgeInsets.all(3),
//             itemCount: imagesData.length,
//             itemBuilder: (ctx, index) => GestureDetector(
//               onTap: () {
//                 // Handle image tap if needed
//               },
//               child: Card(
//                 color: ColorPallete.offWhiteListTileColor,
//                 elevation: 2,
//                 margin: const EdgeInsets.symmetric(vertical: 4),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     AspectRatio(
//                       aspectRatio: 16 / 9,
//                       child: Image.network(
//                         imagesData[index]['url'].toString(),
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Icon(Icons.error, color: Colors.red);
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Text(
//                         imagesData[index]['name'].toString(),
//                         textAlign: TextAlign.start,
//                         style: Fonts.firasans(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w400,
//                           color: ColorPallete.blackColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }