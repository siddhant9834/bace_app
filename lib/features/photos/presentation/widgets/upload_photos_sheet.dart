import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/features/photos/data/datasource/firebase_datasource.dart';

void showImagePickerOption(BuildContext context, List<String> categories) {
  String? selectedCategory;
  final TextEditingController _imageNameController = TextEditingController();
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: ColorPallete.liteOffWhiteTextColor,
    context: context,
    builder: (builder) {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5,
          // height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          pickImage(ImageSource.gallery, context,
                              selectedCategory!, _imageNameController.text);
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
                          pickImage(ImageSource.camera, context,
                              selectedCategory!, _imageNameController.text);
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
                const SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  hint: const Text("Select Category"),
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    selectedCategory = newValue!;
                  },
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _imageNameController,
                  decoration: InputDecoration(
                    labelText: "Enter Image Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
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

Future<void> pickImage(ImageSource source, BuildContext context,
    String selectedCategory, String nameOfImage) async {
  final pickedFile = await ImagePicker().pickImage(source: source);
  if (pickedFile == null) return;
  Navigator.pop(context);

  await uploadImageToFirestore(
      File(pickedFile.path), context, selectedCategory, nameOfImage);
}

Future<void> uploadImageToFirestore(File image, BuildContext context,
    String selectedCategory, String nameOfImage) async {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseDatasource firebaseDatasource = FirebaseDatasource();

  try {
    // String fileName = image.path.split('/').last;
    String fileName =
        nameOfImage.isNotEmpty ? nameOfImage : image.path.split('/').last;

    Reference ref = _storage.ref().child('$selectedCategory/$fileName');
    UploadTask uploadTask = ref.putFile(image);

    await uploadTask.whenComplete(() => null);

    String imageUrl = await ref.getDownloadURL();
    firebaseDatasource.addImage(imageUrl, selectedCategory, nameOfImage);

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
