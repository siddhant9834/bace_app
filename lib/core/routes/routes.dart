import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/features/calendar/presentation/pages/calendar_screen.dart';
import 'package:mayapur_bace/features/home/presentation/pages/home_screen.dart';
import 'package:mayapur_bace/features/photos/presentation/pages/photos_category.dart';
import 'package:mayapur_bace/features/seva/presentation/pages/seva_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
          // pageBuilder: (context, state) {
          //       return MaterialPage(
          //         key: state.pageKey,
          //         child: HomeScreen(),
          //       );
          //     },
    ),
    GoRoute(
      path: '/photos',
      builder: (context, state) => PhotosCategory(),
          // pageBuilder: (context, state) {
          //       return MaterialPage(
          //         key: state.pageKey,
          //         child: PhotosCategory(),
          //       );
          //     },
    ),
    GoRoute(
      path: '/seva',
      builder: (context, state) => SevaScreen(),
          // pageBuilder: (context, state) {
          //       return MaterialPage(
          //         key: state.pageKey,
          //         child: SevaScreen(),
          //       );
          //     },
    ),
    GoRoute(
      path: '/calendar',
      builder: (context, state) => CalendarScreen(),
          // pageBuilder: (context, state) {
          //       return MaterialPage(
          //         key: state.pageKey,
          //         child: CalendarScreen(),
          //       );
          //     },
    ),
  ],
  initialLocation: '/home',
);
