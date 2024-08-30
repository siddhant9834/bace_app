// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
// import 'package:mayapur_bace/core/theme/color_pallet.dart';
// import 'package:mayapur_bace/features/authentication/domain/usecases/auth_usecases.dart';
// import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_bloc.dart';
// import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_state.dart';

// void showProfileImagePickerOption(BuildContext context) {
//   showModalBottomSheet(
//     backgroundColor: ColorPallete.orangeColor,
//     context: context,
//     builder: (builder) {
//       return Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height / 3.8,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 30),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       _pickProfileImage(ImageSource.gallery, context);
//                     },
//                     child: const SizedBox(
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.image,
//                             size: 70,
//                           ),
//                           Text("Gallery")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       _pickProfileImage(ImageSource.camera, context);
//                     },
//                     child: const SizedBox(
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.camera_alt,
//                             size: 70,
//                           ),
//                           Text("Camera")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// Future<void> _pickProfileImage(ImageSource source, context) async {
//   final pickedFile = await ImagePicker().pickImage(source: source);
//   if (pickedFile == null) return;

//   await uploadProfileImageToFirestore(File(pickedFile.path), context);
// }

// Future<void> uploadProfileImageToFirestore(
//     File image, BuildContext context) async {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   // final FirebaseDatasource firebaseDatasource = FirebaseDatasource();

//   try {
//     String fileName = image.path.split('/').last;
//     Reference ref = _storage.ref().child('users_profile_image/$fileName');
//     UploadTask uploadTask = ref.putFile(image);

//     await uploadTask.whenComplete(() => null);

//     String imageUrl = await ref.getDownloadURL();
//     // firebaseDatasource.updateProfileUrl(imageUrl);
//     // locator<AuthUseCases>().updateProfilePic(imageUrl);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Image uploaded successfully'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   } catch (e) {
//     print('Image uploading failed: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Failed to upload image'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }












// // class PickImage extends StatefulWidget {
// //   const PickImage({super.key});

// //   @override
// //   State<PickImage> createState() => _PickImageState();
// // }

// // class _PickImageState extends State<PickImage> {
// //   File? selectedImage;
// //   final FirebaseStorage _storage = FirebaseStorage.instance;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.deepPurple[100],
// //       body: Center(
// //         child: Stack(
// //           children: [
// //             Container(
// //               width: 300,
// //               height: 400,
// //               decoration: BoxDecoration(
// //                 image: DecorationImage(
// //                   fit: BoxFit.cover,
// //                   image: selectedImage != null
// //                       ? FileImage(selectedImage!)
// //                       : const NetworkImage(
// //                           "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
// //                         ) as ImageProvider,
// //                 ),
// //               ),
// //             ),
// //             Positioned(
// //               bottom: -5,
// //               left: 125,
// //               child: IconButton(
// //                 onPressed: () {
// //                   showImagePickerOption(context);
// //                 },
// //                 icon: const Icon(Icons.add_a_photo, size: 50,),
// //               ),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void showImagePickerOption(BuildContext context) {
// //     showModalBottomSheet(
// //       backgroundColor: Colors.blue[100],
// //       context: context,
// //       builder: (builder) {
// //         return Padding(
// //           padding: const EdgeInsets.all(18.0),
// //           child: SizedBox(
// //             width: MediaQuery.of(context).size.width,
// //             height: MediaQuery.of(context).size.height / 4.5,
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                   child: InkWell(
// //                     onTap: () {
// //                       _pickImage(ImageSource.gallery);
// //                     },
// //                     child: const SizedBox(
// //                       child: Column(
// //                         children: [
// //                           Icon(
// //                             Icons.image,
// //                             size: 70,
// //                           ),
// //                           Text("Gallery")
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 Expanded(
// //                   child: InkWell(
// //                     onTap: () {
// //                       _pickImage(ImageSource.camera);
// //                     },
// //                     child: const SizedBox(
// //                       child: Column(
// //                         children: [
// //                           Icon(
// //                             Icons.camera_alt,
// //                             size: 70,
// //                           ),
// //                           Text("Camera")
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Future<void> _pickImage(ImageSource source) async {
// //     final pickedFile = await ImagePicker().pickImage(source: source);
// //     if (pickedFile == null) return;

// //     setState(() {
// //       selectedImage = File(pickedFile.path);
// //     });

// //     await uploadImageToFirestore(selectedImage!);
// //   }

// //   Future<void> uploadImageToFirestore(File image) async {
// //     try {
// //       String fileName = image.path.split('/').last;
// //       Reference ref = _storage.ref().child('user_images/$fileName');
// //       UploadTask uploadTask = ref.putFile(image);

// //       await uploadTask.whenComplete(() => null);

// //       String imageUrl = await ref.getDownloadURL();
// //       print('************Image uploaded to Firestore****************: $imageUrl');

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: const Text('Image uploaded successfully'),
// //           backgroundColor: Colors.green,
// //         ),
// //       );
// //     } catch (e) {
// //       print('Error uploading image to Firestore: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: const Text('Failed to upload image'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }
// // }

