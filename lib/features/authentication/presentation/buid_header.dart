
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/core/side_drawer/data/model/user_profile_model.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_state.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
      if (state is ProfileFetchSuccessState) {
                  final profile = state.userData as ProfileModel; 
        log(profile.fullName);

           return Container(
          color: ColorPallete.blueColor,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top * 1.5,
            bottom: MediaQuery.of(context).padding.top * .30,
          ),
          child: Column(
            children: [
              
              const CircleAvatar(
                radius: 52,
                backgroundImage: AssetImage('assets/images/hhprabhupad.png'),
              ),
              Text(
                profile.fullName,
                style: Fonts.popins(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: ColorPallete.blackColor),
              ),
              Text(
                profile.role,
                style: Fonts.popins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: ColorPallete.blackColor),
              ),
            ],
          ),
        );
      }
      else{
        return Center(child: Text('Somthing went wrong'),);
      }
      }
    );
  }
}
  //  return Container(
  //         color: ColorPallete.blueColor,
  //         padding: EdgeInsets.only(
  //           top: MediaQuery.of(context).padding.top * 1.5,
  //           bottom: MediaQuery.of(context).padding.top * .30,
  //         ),
  //         child: Column(
  //           children: [
  //             const CircleAvatar(
  //               radius: 52,
  //               backgroundImage: AssetImage('assets/images/hhprabhupad.png'),
  //             ),
  //             Text(
  //               'HH Srila Prabhupad',
  //               style: Fonts.popins(
  //                   fontSize: 23,
  //                   fontWeight: FontWeight.w500,
  //                   color: ColorPallete.blackColor),
  //             ),
  //             Text(
  //               'Incharge Designation',
  //               style: Fonts.popins(
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.w500,
  //                   color: ColorPallete.blackColor),
  //             ),
  //           ],
  //         ),
  //       );