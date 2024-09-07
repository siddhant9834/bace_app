import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/members/data/model/members_model.dart';
import 'package:mayapur_bace/features/members/domain/usecases/members_usecases.dart';
import 'package:mayapur_bace/features/seva/data/model/seva_model.dart';
import 'package:mayapur_bace/features/seva/domain/usecases/user_list_usecases.dart';

class SevaListScreen extends StatelessWidget {
  const SevaListScreen({super.key});

  @override
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
      log(email.toString());
      if (email == null) return null;

      final List<MembersModel> members =
          await locator<GetMembersUseCase>().call();
      final currentUser = members.firstWhere((member) => member.email == email);

      return currentUser.role;
    }

    return FutureBuilder<String?>(
      future: getCurrentUserRole(getEmail()),
      builder: (context, snapshot) {

          return Scrollbar(
            trackVisibility: true,
            thickness: 10,
            child: FutureBuilder<List<SevaListModel>>(
              future: locator<GetSevaListUseCase>().call(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<SevaListModel> sevaList = snapshot.data!;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: ListView.builder(
                      itemCount: sevaList.length,
                      itemBuilder: (context, index) {
                        log('in builder 3');
                        final SevaListModel sevaMember = sevaList[index];
                        log(sevaMember.fullName);
                        return Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                
                              },
                              child: Card(
                                elevation: 4,
                                color: ColorPallete.offWhiteListTileColor,
                                child: Row(
                                  children: [
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
                                            child: Text(
                                              'Name : ${sevaMember.fullName}',
                                              style: Fonts.firasans(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ColorPallete.blueColor),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Seva : ${sevaMember.seva}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                color: Color.fromARGB(
                                                    211, 0, 0, 0),
                                              ),
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
                  );
                } else {
                  return const Center(child: Text('No users found.'));
                }
              },
            ),
          );
       
      },
    );
  }
}


// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
// import 'package:mayapur_bace/core/theme/color_pallet.dart';
// import 'package:mayapur_bace/core/theme/fonts.dart';
// import 'package:mayapur_bace/features/members/data/model/members_model.dart';
// import 'package:mayapur_bace/features/members/domain/usecases/members_usecases.dart';
// import 'package:mayapur_bace/features/seva/data/model/seva_model.dart';
// import 'package:mayapur_bace/features/seva/domain/usecases/user_list_usecases.dart';

// class SevaListScreen extends StatelessWidget {
//   const SevaListScreen({super.key});

//   @override
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;

//     // User? getCurrentUser() {
//     //   return _auth.currentUser;
//     // }

//     String? getEmail() {
//       User? user = _auth.currentUser;
//       return user?.email;
//     }

//     Future<String?> getCurrentUserRole(String? email) async {
//       log(email.toString());
//       if (email == null) return null;

//       final List<MembersModel> members =
//           await locator<GetMembersUseCase>().call();
//       final currentUser = members.firstWhere((member) => member.email == email);

//       return currentUser.role;
//     }

//     return FutureBuilder<String?>(
//       future: getCurrentUserRole(getEmail()),
//       builder: (context, snapshot) {
//         log('in builder 1');

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (snapshot.hasData) {
//           final userRole = snapshot.data;
//           log('in builder 2');

//           return Scrollbar(
//             trackVisibility: true,
//             thickness: 10,
//             child: FutureBuilder<List<SevaListModel>>(
//               future: locator<GetSevaListUseCase>().call(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                   List<SevaListModel> sevaList = snapshot.data!;
//                   return Container(
//                     padding: EdgeInsets.symmetric(horizontal: 4),
//                     child: ListView.builder(
//                       itemCount: sevaList.length,
//                       itemBuilder: (context, index) {
//                         log('in builder 3');
//                         final SevaListModel sevaMember = sevaList[index];
//                         log(sevaMember.fullName);
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
//                           child: SizedBox(
//                             height: 80,
//                             width: double.infinity,
//                             child: InkWell(
//                               onTap: () {
//                                 if (userRole == 'Admin' ||
//                                     userRole == 'Authority' ||
//                                     userRole == 'Overall Coordinator' ||
//                                     userRole == 'Overall Manager') {
//                                   GoRouter.of(context).push(
//                                       '/seva_list/seva_details_screen',
//                                       extra: sevaMember.email);
//                                 }
//                               },
//                               child: Card(
//                                 elevation: 4,
//                                 color: ColorPallete.offWhiteListTileColor,
//                                 child: Row(
//                                   children: [
//                                     const SizedBox(width: 5),
//                                     Container(
//                                       width: 2,
//                                       height: 50,
//                                       color:
//                                           const Color.fromARGB(255, 75, 69, 69),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Flexible(
//                                             child: Text(
//                                               'Name : ${sevaMember.fullName}',
//                                               style: Fonts.firasans(
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.w500,
//                                                   color:
//                                                       ColorPallete.blueColor),
//                                             ),
//                                           ),
//                                           Flexible(
//                                             child: Text(
//                                               'Seva : ${sevaMember.seva}',
//                                               overflow: TextOverflow.ellipsis,
//                                               style: const TextStyle(
//                                                 fontSize: 17,
//                                                 color: Color.fromARGB(
//                                                     211, 0, 0, 0),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 } else {
//                   return const Center(child: Text('No users found.'));
//                 }
//               },
//             ),
//           );
//         } else {
//           return const Center(child: Text('Unable to determine user role.'));
//         }
//       },
//     );
//   }
// }
