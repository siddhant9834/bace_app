import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/routes/routes.dart';
import 'package:mayapur_bace/core/side_drawer/domain/usecases/get_profile_usecases.dart';
import 'package:mayapur_bace/core/side_drawer/presentation/bloc/drawer_bloc.dart';
import 'package:mayapur_bace/core/side_drawer/presentation/widgete/change_profile_pic.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/core/widgets/app_bar.dart';
import 'package:mayapur_bace/core/side_drawer/data/datasource/FB_services.dart';
import 'package:mayapur_bace/core/side_drawer/data/model/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? globalRole = "Member";

class NavigationDrawerCustom extends StatelessWidget {
  final dynamic navigationShell;
  final String appBarTitle;

  const NavigationDrawerCustom(
      {super.key, this.navigationShell, required this.appBarTitle});
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
//  bool latestStatus;

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: navigationShell,
      appBar:
          ApplicationToolbar(title: appBarTitle, color: ColorPallete.pinkColor),
      drawer: Drawer(
        width: screenWidth * .8,
        child: BlocListener<DrawerBloc, DrawerState>(
          listener: (context, state) {
            if (state is HomeButtonClickedState) {
              context.pushReplacement('/home', extra: "Mayapur Bace");
            } else if (state is PhotosButtonClickedState) {
              context.pushReplacement('/images', extra: "Photos Category");
            } else if (state is MembersButtonClickedState) {
              context.pushReplacement('/members', extra: "Members");
            } else if (state is SevaButtonClickedState) {
              context.pushReplacement('/seva', extra: "Seva Chart");
            } else if (state is SevaListButtonClickedState) {
              context.pushReplacement('/seva_list', extra: "Seva List");
            } else if (state is MorningProgramButtonClickedState) {
              context.pushReplacement('/morning_program',
                  extra: "Morning Program");
            }
       
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // HeaderWidget(),
                buildHeader(context, user!),
                // Center(child: Text(user!.phoneNumber.toString())),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: Icon(Icons.home_outlined),
          title: Text(
            'Home',
            style: Fonts.ubuntu(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorPallete.blackColor),
          ),
          onTap: () {
            BlocProvider.of<DrawerBloc>(context).add(HomeButtonClickedEvent());
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_sharp),
          title: Text(
            'Photos',
            style: Fonts.ubuntu(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorPallete.blackColor),
          ),
          onTap: () {
            BlocProvider.of<DrawerBloc>(context)
                .add(PhotosButtonClickedEvent());
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(Icons.calendar_month),
          title: Text(
            'Seva Calendar',
            style: Fonts.ubuntu(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorPallete.blackColor),
          ),
          onTap: () {
            BlocProvider.of<DrawerBloc>(context).add(SevaButtonClickedEvent());
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(Icons.cleaning_services),
          title: Text(
            'Seva List',
            style: Fonts.ubuntu(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorPallete.blackColor),
          ),
          onTap: () {
            BlocProvider.of<DrawerBloc>(context)
                .add(SevaListButtonClickedEvent());
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(Icons.people_sharp),
          title: Text(
            'Members of BACE',
            style: Fonts.ubuntu(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorPallete.blackColor),
          ),
          onTap: () {
            BlocProvider.of<DrawerBloc>(context)
                .add(MembersButtonClickedEvent());
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(Icons.people_sharp),
          title: Text(
            'Morning Program',
            style: Fonts.ubuntu(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorPallete.blackColor),
          ),
          onTap: () {
            BlocProvider.of<DrawerBloc>(context)
                .add(MorningProgramButtonClickedEvent());
            Navigator.of(context).pop();
          },
        ),
        SizedBox(
          height: 300,
        ),
        Divider(
          color: ColorPallete.greyColor,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            'Logout',
            style: Fonts.ubuntu(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorPallete.blackColor),
          ),
          onTap: () async {
            final sharedPref = await SharedPreferences.getInstance();
            await sharedPref.setBool(KEYLOGIN, false);
            context.go('/login');
            // Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

Widget buildHeader(BuildContext context, User user) {
  String? email = ProfileService().getEmail();

  return Container(
    color: ColorPallete.blueColor,
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top * 1.5,
      bottom: MediaQuery.of(context).padding.top * .30,
    ),
    child: FutureBuilder<ProfileModel>(
      future: locator<GetProfileUseCase>().call(email.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Loading User Data...'));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          final profile = snapshot.data!;
          globalRole = profile.role;
              List<dynamic>statusList=profile.status;
              bool latestStatus=statusList.last;
         
          log(latestStatus.toString());
          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPallete.liteOffWhiteTextColor,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: profile.profilePic,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/default_dp_img.jpg',
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 65,
                    child: InkWell(
                      onTap: () {
                        showProfileImagePickerOption(context);
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: ColorPallete.greenColor,
                        child: SvgPicture.asset('assets/icons/edit_pencil.svg'),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                profile.fullName,
                style: Fonts.popins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ColorPallete.blackColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 43),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: ColorPallete.greyColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        latestStatus ? 'IN' : 'OUT',
                        style: Fonts.popins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: latestStatus
                                ? Colors.green
                                : ColorPallete.redColor),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onDoubleTap: () {



                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.all(20),
                                backgroundColor: ColorPallete.whiteColor,
                                actionsAlignment: MainAxisAlignment.center,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Edit'), // Dialog title
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    ),
                                  ],
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    latestStatus ? 
                                       Text(
                                            'Want to get out...???',
                                            style: Fonts.nunitoSans(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ):
                                        // ? TextField(
                                        //     decoration: InputDecoration(
                                        //       focusColor:
                                        //           ColorPallete.orangeColor,
                                        //       border: OutlineInputBorder(
                                        //           borderSide: BorderSide(
                                        //               color: ColorPallete
                                        //                   .whiteColor)),
                                        //       labelStyle: Fonts.popins(
                                        //           fontSize: 20,
                                        //           fontWeight: FontWeight.w400,
                                        //           color: Colors.black),
                                        //       labelText: 'Enter Reason for Out',
                                        //     ),
                                        //   )
                                        // : 
                                        Text(
                                            'Want to getin...???',
                                            style: Fonts.nunitoSans(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                  ],
                                ),
                                actions: [
                                  SizedBox(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: const Color.fromARGB(
                                            255, 65, 135, 240),
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<DrawerBloc>(context)
                                            .add(StatusButtonClickedEevent(status: latestStatus ? false : true));
                                            log('status event clicked');
                                            
                                            Navigator.pop(context);
                                      },
                                      child: Text(
                                        latestStatus ? 'Confirm OUT' : 'IN',
                                        style: Fonts.ubuntu(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: ColorPallete.redColor),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 25.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '- $globalRole',
                style: Fonts.popins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: ColorPallete.blackColor),
              ),
            ],
          );
        } else {
          return const Text('No data available');
        }
      },
    ),
  );
}

