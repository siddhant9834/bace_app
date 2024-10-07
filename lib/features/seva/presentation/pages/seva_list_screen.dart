import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/side_drawer/presentation/pages/drawer.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/members/data/model/members_model.dart';
import 'package:mayapur_bace/features/members/domain/usecases/members_usecases.dart';
import 'package:mayapur_bace/features/seva/data/datasource/seva_list_datasource.dart';
import 'package:mayapur_bace/features/seva/data/model/seva_model.dart';
import 'package:mayapur_bace/features/seva/domain/usecases/user_list_usecases.dart';
import 'package:mayapur_bace/features/seva/presentation/bloc/seva_bloc.dart';

String? currentUsersSeva;

class SevaListScreen extends StatelessWidget {
  const SevaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

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
                      final SevaListModel sevaMember = sevaList[index];
                      currentUsersSeva = sevaMember.seva;
                      return Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: SizedBox(
                          height: 80,
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              if (globalRole == 'Seva Incharge') {
                                final TextEditingController sevaController =
                                    TextEditingController(
                                        text: sevaMember.seva);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BlocBuilder<SevaBloc, SevaState>(
                                      buildWhen: (previous, current) {
                                        return (previous is! SevaEditState ||
                                            previous is SevaHideEditState);

                                        // ||
                                        // (previous is SevaHideUpdateState &&
                                        //     current is SevaUpdateState);
                                      },
                                      builder: (context, state) {
                                        return AlertDialog(
                                          elevation: 4,
                                          backgroundColor:
                                              ColorPallete.whiteColor,
                                          title: Text('Seva Details'),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  'Name : ${sevaMember.fullName}',
                                                  style: Fonts.firasans(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        ColorPallete.blackColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              if (state is SevaEditState)
                                                TextField(
                                                  controller: sevaController,
                                                  decoration: InputDecoration(
                                                    focusColor: ColorPallete
                                                        .orangeColor,
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: ColorPallete
                                                                .whiteColor)),
                                                    labelStyle: Fonts.popins(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                    labelText: 'Enter New Seva',
                                                  ),
                                                )
                                              else
                                                Text(
                                                  'Seva: ${sevaMember.seva}',
                                                  style: Fonts.alata(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorPallete
                                                          .blackColor),
                                                )
                                            ],
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 15,
                                                          horizontal: 40),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              65,
                                                              135,
                                                              240),
                                                    ),
                                                    onPressed: () {
                                                      // context.read<SevaBloc>().add(SevaUpdateEvent());
                                                      BlocProvider.of<SevaBloc>(
                                                              context)
                                                          .add(SevaEditEvent());
                                                    },
                                                    child: Text(
                                                      'Edit',
                                                      style: Fonts.ubuntu(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 15,
                                                          horizontal: 30),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              65,
                                                              135,
                                                              240),
                                                    ),
                                                    onPressed: () async {
                                                      final newSevaValue =
                                                          sevaController.text
                                                              .trim();
                                                      if (newSevaValue
                                                          .isNotEmpty) {
                                                        try {
                                                          BlocProvider.of<
                                                                      SevaBloc>(
                                                                  context)
                                                              .add(UpdateSevaEvent(
                                                                  newSeva:
                                                                      newSevaValue,
                                                                  userEmail:
                                                                      sevaMember
                                                                          .email));
                                                          // currentUsersSeva=newSevaValue;
                                                        } catch (e) {
                                                          log('Error updating seva: $e');
                                                        }
                                                        Navigator.pop(context);
                                                      } else {
                                                        log('Please enter a valid Seva value');
                                                      }
                                                    },
                                                    child: Text(
                                                      'Submit',
                                                      style: Fonts.ubuntu(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Flexible(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 15,
                                                        horizontal: 30),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    backgroundColor:
                                                        ColorPallete
                                                            .logoutRedColor),
                                                onPressed: () {
                                                  BlocProvider.of<SevaBloc>(
                                                          context)
                                                      .add(HideEditSevaEvent());
                                                  // context.read<SevaBloc>().add(HideUpdateSevaEvent());
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: Fonts.ubuntu(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              }
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
                                                color: ColorPallete.blueColor),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Seva : ${sevaMember.seva}',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color:
                                                  Color.fromARGB(211, 0, 0, 0),
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

// class SevaListScreen extends StatelessWidget {
//   const SevaListScreen({super.key});

//   @override
//   @override
//   Widget build(BuildContext context) {
//     bool isUpdateSeva = false;
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
//         return Scrollbar(
//           trackVisibility: true,
//           thickness: 10,
//           child: FutureBuilder<List<SevaListModel>>(
//             future: locator<GetSevaListUseCase>().call(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                 List<SevaListModel> sevaList = snapshot.data!;
//                 return BlocBuilder<SevaBloc, SevaState>(
//                   builder: (context, state) {
//                     if (state is SevaUpdateState) {
//                       isUpdateSeva = true;
//                     }
//                   },
//                   child: Container(
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
//                                 log(globalRole.toString());
//                                 if (globalRole == 'Seva Incharge') {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         elevation: 4,
//                                         backgroundColor:
//                                             ColorPallete.whiteColor,
//                                         title: Text('Seva Details'),
//                                         content: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Flexible(
//                                               child: Text(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 'Name : ${sevaMember.fullName}',
//                                                 style: Fonts.firasans(
//                                                     fontSize: 20,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: ColorPallete
//                                                         .blackColor),
//                                               ),
//                                             ),
//                                             isUpdateSeva
//                                                 ? TextField(
//                                                     decoration: InputDecoration(
//                                                       focusColor: ColorPallete
//                                                           .orangeColor,
//                                                       border: OutlineInputBorder(
//                                                           borderSide: BorderSide(
//                                                               color: ColorPallete
//                                                                   .whiteColor)),
//                                                       labelStyle: Fonts.popins(
//                                                           fontSize: 20,
//                                                           fontWeight:
//                                                               FontWeight.w400,
//                                                           color: Colors.black),
//                                                       labelText:
//                                                           'Enter New Seva',
//                                                     ),
//                                                   )
//                                                 : Text(
//                                                     'Seva: ${sevaMember.seva}'),
//                                             // Flexible(
//                                             //   child: Text(
//                                             //     overflow: TextOverflow.ellipsis,
//                                             //     'Role : ${member.role}',
//                                             //     style: Fonts.firasans(
//                                             //         fontSize: 20,
//                                             //         fontWeight: FontWeight.w500,
//                                             //         color: ColorPallete
//                                             //             .blackColor),
//                                             //   ),
//                                             // ),
//                                           ],
//                                         ),
//                                         actions: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   BlocProvider.of<SevaBloc>(
//                                                           context)
//                                                       .add(SevaUpdateEvent());
//                                                 },
//                                                 child: Text('Edit Seva'),
//                                               ),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   isUpdateSeva = false;
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Cancle'),
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       );
//                                     },
//                                   );
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
//                   ),
//                 );
//               } else {
//                 return const Center(child: Text('No users found.'));
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }

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
