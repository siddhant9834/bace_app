import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mayapur_bace/core/routes/page_route_constants.dart';
import 'package:mayapur_bace/core/side_drawer/presentation/pages/drawer.dart';
import 'package:mayapur_bace/features/authentication/presentation/pages/login_page.dart';
import 'package:mayapur_bace/features/authentication/presentation/pages/registration_screen.dart';
import 'package:mayapur_bace/features/home/presentation/pages/home_screen.dart';
import 'package:mayapur_bace/features/home/presentation/pages/quote_screen.dart';
import 'package:mayapur_bace/features/members/presentation/pages/members_list_view.dart';
import 'package:mayapur_bace/features/morning_program/presentation/pages/morning_aarti.dart';
import 'package:mayapur_bace/features/photos/presentation/pages/photos_category.dart';
import 'package:mayapur_bace/features/photos/presentation/pages/photos_page.dart';
import 'package:mayapur_bace/features/seva/presentation/pages/seva_details_calendar.dart';
import 'package:mayapur_bace/features/seva/presentation/pages/seva_list_screen.dart';
import 'package:mayapur_bace/features/seva/presentation/pages/seva_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final homeTabNavigatorKey = GlobalKey<NavigatorState>();
final imageTabNavigationKey = GlobalKey<NavigatorState>();
final booksTabNavigatorKey = GlobalKey<NavigatorState>();
final settingsTabNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final onboardingTabNavigatorKey = GlobalKey<NavigatorState>();
final membersTabNavigatorKey = GlobalKey<NavigatorState>();
final sevaNavigationKey = GlobalKey<NavigatorState>();
final sevaListNavigatorKey = GlobalKey<NavigatorState>();
final morningProgramTabNavigatorKey = GlobalKey<NavigatorState>();

const String KEYLOGIN = 'Login';

final GoRouter router = GoRouter(
    initialLocation: '/login',
    navigatorKey: _rootNavigatorKey,

    // redirect: (context, state) async {
    //   final sharedPref = await SharedPreferences.getInstance();
    //   final isLoggedIN = sharedPref.getBool(KEYLOGIN) ?? false;

    //   await Future.delayed(const Duration(seconds: 2));

    //   if (isLoggedIN) {
    //     context.go('/');
    //   } else {
    //     context.go('/login');
    //   }
    // },
    redirect: (context, state) async {
      final sharedPref = await SharedPreferences.getInstance();
      final isLoggedIN = sharedPref.getBool('Login') ?? false;

      if (isLoggedIN) {
        if (state.uri.toString() == '/' ||
            state.uri.toString().startsWith('/login')) {
          return '/home';
        }
      } else {
        if (state.uri.toString() != '/' &&
            !state.uri.toString().startsWith('/login')) {
          return '/login';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
          path: '/login',
          name: MyAppRouteConstants.loginRouteName,
          builder: (context, state) => Login(),
          routes: [
            GoRoute(
              path: 'register',
              // name: MyAppRouteConstants.registerRouteName,
              builder: (context, state) => Registration(),
            ),
          ]),

      // GoRoute(
      //   path: '/home',
      //   name: MyAppRouteConstants.homeRouteName,
      //   builder: (context, state) => HomeScreen(),
      // ),
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
            StatefulShellBranch(navigatorKey: homeTabNavigatorKey, routes: [
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
                            child: ShowPerticularQuoteScreen(
                                selectDate: selectDate ?? DateTime.now()),
                          );
                          //  selectDate(context);
                        })
                  ])
            ]),
            StatefulShellBranch(navigatorKey: imageTabNavigationKey, routes: [
              GoRoute(
                  path: '/images',
                  name: MyAppRouteConstants.imagesRouteName,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: PhotosCategory(),
                    );
                  },
                  routes: [
                    GoRoute(
                        path: 'image_screen',
                        name: MyAppRouteConstants.imageDispalyScreen,
                        pageBuilder: (context, state) {
                          final selectedCategory = state.extra as String;
                          // final selectedCategory = state.pathParameters['categoryId'] ?? ''; this line created very big chaos in project developement i am not removing this line because by this rememberance we can avoid such bugs

                          return MaterialPage(
                            key: state.pageKey,
                            child:
                                CategoryImagesPage(category: selectedCategory),
                          );
                          //  selectDate(context);
                        })
                  ]
                  // )
                  // ]
                  )
            ]),
            StatefulShellBranch(navigatorKey: sevaNavigationKey, routes: [
              GoRoute(
                path: '/seva',
                name: MyAppRouteConstants.sevaRouteName,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: DailySevaScreen(),
                  );
                },
              )
            ]),
            StatefulShellBranch(navigatorKey: sevaListNavigatorKey, routes: [
              GoRoute(
                  path: '/seva_list',
                  name: MyAppRouteConstants.sevaListScreen,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: SevaListScreen(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'seva_details_screen/:inputEmail/:seva/:fullName',
                      name: MyAppRouteConstants.sevaDetailsScreen,

                      // Access the Map directly from state.extra
                      // final data = state.extra as Map<String, dynamic>;
                      // final args = state.extra as SevaDetailsArguments;
                      // final inputEmail = state.extra as String;
                      builder: (context, state) {
                        return SevaDetailsScreen(
                            inputEmail:
                                state.pathParameters['inputEmail'] as String,
                            seva: state.pathParameters['seva'] as String,
                            fullName:
                                state.pathParameters['fullName'] as String);
                      },
                      // final List data = state.extra as List;
                      // final inputEmail = data[0];
                      // final seva = data[1];
                      // final fullName = data[2];

                      // return MaterialPage(
                      //   key: state.pageKey,
                      //   child: SevaDetailsScreen(
                      //     inputEmail: inputEmail,
                      //     seva: seva,
                      //     fullName: fullName, // Pass the email to the screen
                      //   ),
                      // );

                      // Extract the values from the map
                      // final inputEmail = data['inputEmail'] as String;
                      // // final seva = data['seva'] as String;
                      // // final fullName = data['fullName'] as String;

                      // return MaterialPage(
                      //   key: state.pageKey,
                      //   child: SevaDetailsScreen(
                      //     inputEmail: args.inputEmail,
                      //     seva: args.seva,
                      //     fullName: args.fullName,
                      //   ),
                      // );
                    ),
                    // GoRoute(
                    //     path: 'seva_details_screen',
                    //     name: MyAppRouteConstants.sevaDetailsScreen,
                    //     pageBuilder: (context, state) {
                    //       final inputEmail = state.extra as String;
                    //       // final selectedCategory = state.pathParameters['categoryId'] ?? ''; this line created very big chaos in project developement i am not removing this line because by this rememberance we can avoid such bugs
                    //       (context, state) {
                    //         final data = state.extra as Map<String, dynamic>;
                    //         final seva = data['seva'];
                    //         final fullName = data['fullName'];

                    //         return SevaDetailsScreen(
                    //             inputEmail: inputEmail,
                    //             seva: seva,
                    //             fullName: fullName);
                    //       };
                    //       // return MaterialPage(
                    //       //   key: state.pageKey,
                    //       //   child:
                    //       //       SevaDetailsScreen(inputEmail: inputEmail),
                    //       // );
                    //       //  selectDate(context);
                    //     }
                    //   )
                  ])
            ]),
            StatefulShellBranch(navigatorKey: membersTabNavigatorKey, routes: [
              GoRoute(
                path: '/members',
                name: MyAppRouteConstants.membersScreenList,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: UserListView(),
                  );
                },
              )
            ]),
            StatefulShellBranch(
                navigatorKey: morningProgramTabNavigatorKey,
                routes: [
                  GoRoute(
                    path: '/morning_program',
                    name: MyAppRouteConstants.morningProgramScreen,
                    pageBuilder: (context, state) {
                      return MaterialPage(
                        key: state.pageKey,
                        child: MorningAarti(),
                      );
                    },
                  )
                ]),
          ]),
    ]);
