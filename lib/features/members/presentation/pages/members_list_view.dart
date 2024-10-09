import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/side_drawer/presentation/pages/drawer.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/members/data/model/members_model.dart';
import 'package:mayapur_bace/features/members/domain/usecases/members_usecases.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    // User? getCurrentUser() {
    //   return _auth.currentUser;
    // }

    String? getEmail() {
      User? user = _auth.currentUser;
      return user?.email;
    }

    Future<String?> getCurrentUserRole(String? email) async {
      if (email == null) return null;

      final List<MembersModel> members =
          await locator<GetMembersUseCase>().call();
      final currentUser = members.firstWhere((member) => member.email == email);

      return currentUser.role;
    }

    // return FutureBuilder<String?>(
    // future: getCurrentUserRole(getEmail()),
    // builder: (context, snapshot) {
    // if (snapshot.connectionState == ConnectionState.waiting) {
    //   return const Center(child: CircularProgressIndicator());
    // } else if (snapshot.hasError) {
    //   return Center(child: Text('Error: ${snapshot.error}'));
    // } else if (snapshot.hasData) {
    //   final userRole = snapshot.data;

    return Scaffold(
            backgroundColor: ColorPallete.offWhiteBackgroundColor,

      body: Scrollbar(
        trackVisibility: true,
        thickness: 10,
        child: FutureBuilder<List<MembersModel>>(
          future: locator<GetMembersUseCase>().call(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<MembersModel> members = snapshot.data!;
              int memberCount = 0;
              for (var member in members) {
                bool latestStatus =
                    member.status.isNotEmpty ? member.status.last : false;
                if (latestStatus) {
                  memberCount++;
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Total IN Count: ',
                        style: Fonts.firasans(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: ColorPallete.blackColor),
                        children: <TextSpan>[
                          TextSpan(
                              text: '$memberCount',
                              style: Fonts.ubuntu(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: ColorPallete.greenColor)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ListView.builder(
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          final MembersModel member = members[index];
                          bool latestStatus = member.status.isNotEmpty
                              ? member.status.last
                              : false;
      
                          return Padding(
                            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                            child: SizedBox(
                              height: 80,
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  if (globalRole == 'Admin' ||
                                      globalRole == 'Authority' ||
                                      globalRole == 'OC') {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          elevation: 4,
                                          backgroundColor:
                                              ColorPallete.whiteColor,
                                          title: Text('Details'),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  'Name : ${member.fullName}',
                                                  style: Fonts.firasans(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorPallete
                                                          .blackColor),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  'Email : ${member.email}',
                                                  style: Fonts.firasans(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorPallete
                                                          .blackColor),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  'Ph : ${member.phoneNumber}',
                                                  style: Fonts.firasans(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorPallete
                                                          .blackColor),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  'Role : ${member.role}',
                                                  style: Fonts.firasans(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorPallete
                                                          .blackColor),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  latestStatus ? 'IN' : 'OUT',
                                                  style: Fonts.popins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: latestStatus
                                                        ? Colors.green
                                                        : ColorPallete.redColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Edit Role'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 4,
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(1.5),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorPallete.orangeColor,
                                              ),
                                              child: ClipOval(
                                                child: CachedNetworkImage(
                                                  imageUrl: member.profilePic,
                                                  fit: BoxFit.cover,
                                                  width: 50,
                                                  height: 50,
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        width: 2,
                                        height: 50,
                                        color:
                                            const Color.fromARGB(255, 75, 69, 69),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Name: ',
                                                  style: Fonts.firasans(
                                                      fontSize: 19,
                                                      fontWeight: FontWeight.w400,
                                                      color:
                                                          ColorPallete.blueColor),
      
                                                  /*defining default style is optional */
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: member.fullName,
                                                      style: Fonts.firasans(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: ColorPallete
                                                              .blackColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // child: Text(
                                              //   'Name : ${member.fullName}',
                                              //   style: Fonts.firasans(
                                              //       fontSize: 20,
                                              //       fontWeight:
                                              //           FontWeight.w500,
                                              //       color: ColorPallete
                                              //           .blueColor),
                                              // ),
                                            ),
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: 'Ph: ',
                                                      style: Fonts.firasans(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: ColorPallete
                                                              .blueColor),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              member.phoneNumber,
                                                          style: Fonts.firasans(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              color: ColorPallete
                                                                  .blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
      
                                                  // Text(
                                                  //   'Ph : ${member.phoneNumber}',
                                                  //   overflow: TextOverflow
                                                  //       .ellipsis,
                                                  //   style: const TextStyle(
                                                  //     fontSize: 17,
                                                  //     color: Color.fromARGB(
                                                  //         211, 0, 0, 0),
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    child: SizedBox(),
                                                  ),
                                                  Text(
                                                    latestStatus ? 'IN' : 'OUT',
                                                    style: Fonts.ubuntu(
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w500,
                                                      color: latestStatus
                                                          ? Colors.green
                                                          : ColorPallete.redColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No users found.'));
            }
          },
        ),
      ),
    );
  }
  // else {
  //   return const Center(child: Text('Unable to determine user role.'));
  // }
  // },
  // );
}
// }

// class UserListView extends StatelessWidget {
//   const UserListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//       final FirebaseAuth _auth = FirebaseAuth.instance;

//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }

//   String? getEmail() {
//     User? user = _auth.currentUser;
//     return user?.email;
//   }
//    Future<ProfileModel> getProfile(String userEmail) async {
//       final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//     try {
//       // log(userEmail.toString());

//       QuerySnapshot querySnapshot = await _firestore
//           .collection('users')
//           .where('email', isEqualTo: userEmail)
//            .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         return ProfileModel.fromMap(
//             querySnapshot.docs.first.data() as Map<String, dynamic>);
//       } else {
//         throw Exception('No user found with this email.');
//       }
//     } catch (e) {
//       print('Error in getting profile: $e');
//       throw e;
//     }
//   }
//     return Scrollbar(
//       trackVisibility: true,
//       thickness: 10,
//       child: FutureBuilder<List<MembersModel>>(
//         future: locator<GetMembersUseCase>().call(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//             List<MembersModel> members = snapshot.data!;
//             return Container(
//               padding: EdgeInsets.symmetric(horizontal: 4),
//               child: ListView.builder(
//                   itemCount: members.length,
//                   itemBuilder: (context, index) {
//                     final MembersModel member = members[index];
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
//                       child: SizedBox(
//                         height: 130,
//                         width: double.infinity,
//                         child: InkWell(
//                           onTap: () {
//                             if(getProfile(getEmail())==)
//                           },
//                           child: Card(
//                             elevation: 4,
//                             color: ColorPallete.offWhiteListTileColor,
//                             child: Row(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.all(5),
//                                   child: Column(
//                                     // crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.all(2),
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: ColorPallete.orangeColor,
//                                         ),
//                                         child: ClipOval(
//                                           child: CachedNetworkImage(
//                                             imageUrl: member.profilePic,
//                                             fit: BoxFit.cover,
//                                             width: 90,
//                                             height: 90,
//                                             placeholder: (context, url) =>
//                                                 CircularProgressIndicator(),
//                                             errorWidget:
//                                                 (context, url, error) =>
//                                                     Icon(Icons.error),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 Container(
//                                   width: 2,
//                                   height: 100,
//                                   color: const Color.fromARGB(255, 75, 69, 69),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Flexible(
//                                         child: Text(
//                                           'Name : ${member.fullName}',
//                                           style: const TextStyle(
//                                             fontSize: 20,
//                                             color: Color.fromARGB(
//                                                 255, 26, 82, 200),
//                                           ),
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                             // widget.userInfo.email,
//                                             'Email : ${member.email}',
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 color: Color.fromARGB(
//                                                     213, 0, 0, 0))),
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                             // widget.userInfo.phoneNumber,
//                                             'Ph : ${member.phoneNumber}',
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 color: Color.fromARGB(
//                                                     211, 0, 0, 0))),
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                             // widget.userInfo.address,
//                                             'Role : ${member.role}',
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 color: Color.fromARGB(
//                                                     213, 0, 0, 0))),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//             );
//           } else {
//             return const Center(child: Text('No users found.'));
//           }
//         },
//       ),
//     );
//   }
// }
