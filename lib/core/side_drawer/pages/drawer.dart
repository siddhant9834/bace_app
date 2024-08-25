import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/core/side_drawer/bloc/drawer_bloc.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';
import 'package:mayapur_bace/core/widgets/app_bar.dart';
import 'package:mayapur_bace/features/home/presentation/pages/home_screen.dart';
import 'package:mayapur_bace/features/photos/presentation/pages/photos_category.dart';

class NavigationDrawerCustom extends StatelessWidget {
  final dynamic navigationShell;
  final String appBarTitle;

  const NavigationDrawerCustom({super.key,  this.navigationShell, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: navigationShell,
      appBar: ApplicationToolbar(title: appBarTitle, color: ColorPallete.pinkColor),
      drawer:

          // switch (state.runtimeType) {
          //   case HomeButtonClickedState:
          //     final homeState = state as HomeButtonClickedState;

          //     context.go('/home');
          //     break;
          //   case PhotosButtonClickedState:
          //     final photoState = state as PhotosButtonClickedState;
          //     context.go('/photos');
          //     break;
          //   case SevaButtonClickedState:
          //     final sevaState = state as SevaButtonClickedState;
          //     context.go('/seva');
          //     break;
          //   case CalendarButtonClickedState:
          //     final CalendarState = state as CalendarButtonClickedState;
          //     context.go('/calendar');
          //     break;
          //   // default:
          //   //   break;
          // }

          Drawer(
        width: screenWidth * .8,
        child: BlocListener<DrawerBloc, DrawerState>(
          listener: (context, state) {
           if (state is HomeButtonClickedState) {
              context.push('/home', extra: "Mayapur Bace");
            } else if (state is PhotosButtonClickedState) {
              context.push('/images', extra: "Photos Category");
            } else if (state is SevaButtonClickedState) {
              context.push('/seva', extra: "Seva");
            } else if (state is CalendarButtonClickedState) {
              context.push('/calendar', extra: "Calendar");
            }
        },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildHeader(context),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
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
            'HH Srila Prabhupad',
            style: Fonts.popins(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: ColorPallete.blackColor),
          ),
          Text(
            'Incharge Designation',
            style: Fonts.popins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: ColorPallete.blackColor),
          ),
        ],
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
          leading: Icon(Icons.cleaning_services),
          title: Text(
            'Seva',
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
          leading: Icon(Icons.calendar_month),
          title: Text(
            'Vaishnav Calendar',
            style: Fonts.ubuntu(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorPallete.blackColor),
          ),
          onTap: () {
            BlocProvider.of<DrawerBloc>(context)
                .add(CalendarButtonClickedEvent());
                        Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
