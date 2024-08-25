import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addImage(
      String imageUrl, String category, String nameOfImage) async {
    try {
      // Add a new document to the 'photos' collection with the image details
      DocumentReference imageDoc =
          _firestore.collection('photos').doc(nameOfImage);
      await imageDoc.set({
        'url': imageUrl,
        'category': category,
        'name': nameOfImage,
        'uploadedAt': FieldValue.serverTimestamp(),
      });
      // await _firestore.collection('photos').add({
      //   'url': imageUrl,
      //   'category': category,
      //   'name': nameOfImage,
      //   'uploadedAt': FieldValue.serverTimestamp(),
      // });
      print('Image added successfully');
    } catch (e) {
      print('Error adding image: $e');
      throw e;
    }
  }

  Future<List<Map<String, String>>> fetchImages(
     String category) async {
    // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final List<Map<String, String>> imagesData = [];

    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('photos')
          .where('category', isEqualTo: category)
          .get();

      for (var doc in snapshot.docs) {
        if (doc.exists && doc.data() != null) {
          final data = doc.data() as Map<String, dynamic>;
          final imageUrl = data['url'] as String?;
          final name = data['name'] as String?;
          if (imageUrl != null && name != null) {
            imagesData.add({
              'url': imageUrl,
              'name': name,
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching images: $e');
    }

    return imagesData;
  }

  // Future<void> updateImageUrl(String imageUrl, String category, String nameOfImage) async {
  //   try {
  //     DocumentReference profileRef = _firestore
  //         .collection('photos')
  //         .doc('nameOfImage');
  //     print('In upadate image url*********');
  //     print(imageUrl);
  //     await profileRef.update({'url': imageUrl});
  //   } catch (e) {
  //     print('Error updating url: $e');
  //     throw e;
  //   }
  // }
}
