import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/core/routes/page_route_constants.dart';
import 'package:mayapur_bace/core/side_drawer/pages/drawer.dart';
import 'package:mayapur_bace/features/authentication/presentation/pages/login_page.dart';
import 'package:mayapur_bace/features/authentication/presentation/pages/registration_screen.dart';
import 'package:mayapur_bace/features/home/presentation/pages/home_screen.dart';
import 'package:mayapur_bace/features/home/presentation/pages/quote_screen.dart';
import 'package:mayapur_bace/features/photos/presentation/pages/photos_category.dart';
import 'package:mayapur_bace/features/photos/presentation/pages/photos_page.dart';


final homeTabNavigatorKey = GlobalKey<NavigatorState>();
final imageTabNavigationKey = GlobalKey<NavigatorState>();
final booksTabNavigatorKey = GlobalKey<NavigatorState>();
final settingsTabNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final onboardingTabNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/login',
        name: MyAppRouteConstants.loginRouteName,
        builder: (context, state) => Login(),
      ),
      GoRoute(
        path: '/register',
        name: MyAppRouteConstants.registerRouteName,
        builder: (context, state) => Registration(),
      ),
      StatefulShellRoute.indexedStack(
          // builder: (context, state, navigationShell) =>
          //     NavigationDrawerCustom(navigationShell: navigationShell),
        builder: (context, state, navigationShell) {
        final title = state.extra as String? ?? "Mayapur Bace";
        log(title);
        return NavigationDrawerCustom(
          navigationShell: navigationShell,
          appBarTitle: title,
        );
      },
          branches: [
            StatefulShellBranch(
              navigatorKey: homeTabNavigatorKey, 
              routes: [
              GoRoute(
                  path: '/home',
                  name: MyAppRouteConstants.homeRouteName,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: HomeScreen(),
                    );
                  },
                  routes: [
                      GoRoute(
                          path: 'show_quote',
                          name: MyAppRouteConstants.moreQuotesScreen,
                          pageBuilder: (context, state) {
                      
                          final selectDate = state.extra as DateTime?;
                          return MaterialPage(
                          key: state.pageKey,
                          child: ShowPerticularQuoteScreen(selectDate: selectDate ?? DateTime.now()),

                      );
                          //  selectDate(context);
                    }
                  )
                ]
              )
            ]
          ),
          StatefulShellBranch(
              navigatorKey: imageTabNavigationKey, 
              routes: [
              GoRoute(
                  path: '/images',
                  name: MyAppRouteConstants.imagesRouteName,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: PhotosCategory(),
                    );
                  },
                  // routes: [
                      // GoRoute(
                          // path: 'image_category',
                          // name: MyAppRouteConstants.imageCategoryScreen,
                          // pageBuilder: (context, state) {
                          // // final selectDate = state.extra as DateTime;
                          //   return MaterialPage(
                          //     key: state.pageKey,
                          //     child: PhotosCategory(),

                          //   );
                          
                          // //  selectDate(context);
                          // },
                          routes: [
                            GoRoute(
                                path: 'image_screen',
                                name: MyAppRouteConstants.imageDispalyScreen,
                                pageBuilder: (context, state) {
                          
                                // final selectedCategory = state.extra as String;
                                                    final selectedCategory = state.pathParameters['categoryId'] ?? '';

                                return MaterialPage(
                                  key: state.pageKey,
                                  child: CategoryImagesPage(category: selectedCategory),
                                );
                            //  selectDate(context);
                              }
                            )
                          ]
                      // )
                // ]
              )
            ]
          ),
        ]
      )
    ]
  );



    // GoRoute(
    //   path: '/home',
    //   builder: (context, state) => HomeScreen(),
    //       // pageBuilder: (context, state) {
    //       //       return MaterialPage(
    //       //         key: state.pageKey,
    //       //         child: HomeScreen(),
    //       //       );
    //       //     },
    // ),
    // GoRoute(
    //   path: '/photos',
    //   builder: (context, state) => PhotosCategory(),
    //       // pageBuilder: (context, state) {
    //       //       return MaterialPage(
    //       //         key: state.pageKey,
    //       //         child: PhotosCategory(),
    //       //       );
    //       //     },
    // ),
    // GoRoute(
    //   path: '/seva',
    //   builder: (context, state) => SevaScreen(),
    //       // pageBuilder: (context, state) {
    //       //       return MaterialPage(
    //       //         key: state.pageKey,
    //       //         child: SevaScreen(),
    //       //       );
    //       //     },
    // ),
    // GoRoute(
    //   path: '/calendar',
    //   builder: (context, state) => CalendarScreen(),
    //       // pageBuilder: (context, state) {
    //       //       return MaterialPage(
    //       //         key: state.pageKey,
    //       //         child: CalendarScreen(),
    //       //       );
    //       //     },
    // ),
  
  // initialLocation: '/home',

