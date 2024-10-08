import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/features/seva/presentation/bloc/seva_bloc.dart';

void sevaUpdateDialog(BuildContext context, String inputEmail, String seva, String fullName) {
  final TextEditingController sevaController =
      TextEditingController(text: seva);

  showDialog(
    context: context,
    builder: (context) {
      return BlocBuilder<SevaBloc, SevaState>(
        buildWhen: (previous, current) {
          return current is SevaEditState || current is SevaHideEditState;
        },
        builder: (context, state) {
          return AlertDialog(
            elevation: 4,
            backgroundColor: ColorPallete.whiteColor,
            title: Text('Seva Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    'Name : ${fullName}',
                    style: Fonts.firasans(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: ColorPallete.blackColor,
                    ),
                  ),
                ),
               
                SizedBox(
                  height: 10,
                ),
                if (state is SevaEditState)
                  TextField(
                    
                    controller: sevaController,
                    decoration: InputDecoration(
                      focusColor: ColorPallete.orangeColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorPallete.whiteColor),
                      ),
                      labelStyle: Fonts.popins(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      labelText: 'Enter New Seva',
                    ),
                  )
                else
                  Flexible(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    'Seva : ${seva}',
                    style: Fonts.firasans(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorPallete.blackColor,
                    ),
                  ),
                )
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 65, 135, 240),
                      ),
                      onPressed: () {
                        BlocProvider.of<SevaBloc>(context).add(SevaEditEvent());
                      },
                      child: Text(
                        'Edit',
                       style: Fonts.ubuntu(fontSize: 20, fontWeight: FontWeight.w500, color: ColorPallete.blackColor)
                      ),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 65, 135, 240),
                      ),
                      onPressed: () async {
                        final newSevaValue = sevaController.text.trim();
                        if (newSevaValue.isNotEmpty) {
                          try {
                            // log(sevaMember.email);
                            BlocProvider.of<SevaBloc>(context).add(
                              UpdateSevaEvent(
                                newSeva: newSevaValue,
                                userEmail: inputEmail,
                              ),
                            );
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
                       style: Fonts.ubuntu(fontSize: 20, fontWeight: FontWeight.w500, color: ColorPallete.blackColor)
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: ColorPallete.logoutRedColor,
                  ),
                  onPressed: () {
                    // BlocProvider.of<SevaBloc>(context).add(HideEditSevaEvent());
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                   style: Fonts.ubuntu(fontSize: 20, fontWeight: FontWeight.w500, color: ColorPallete.blackColor)
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
