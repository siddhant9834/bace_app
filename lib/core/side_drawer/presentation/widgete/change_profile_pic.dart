import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mayapur_bace/core/side_drawer/data/datasource/FB_services.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';

void showProfileImagePickerOption(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (builder) {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImage(ImageSource.gallery, context);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImage(ImageSource.camera, context);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                          ),
                          Text("Camera")
                        ],
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
  );
}

Future<void> _pickImage(ImageSource source, context) async {
  final pickedFile = await ImagePicker().pickImage(source: source);
  if (pickedFile == null) return;
  Navigator.pop(context);

  await uploadImageToFirestore(File(pickedFile.path), context);
}

Future<void> uploadImageToFirestore(File image, BuildContext context) async {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ProfileService profieDataSource = ProfileService();

  try {
    String fileName = image.path.split('/').last;
    Reference ref = _storage.ref().child('users_profile_images/$fileName');
    UploadTask uploadTask = ref.putFile(image);

    await uploadTask.whenComplete(() => null);

    String imageUrl = await ref.getDownloadURL();
    profieDataSource.updateProfileImageUrl(imageUrl);
    log(imageUrl);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image uploaded successfully'),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    print('Image uploading failed: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to upload image'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
