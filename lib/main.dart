import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mayapur_bace/core/side_drawer/presentation/bloc/drawer_bloc.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:mayapur_bace/features/seva/presentation/bloc/seva_bloc.dart';


void main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUp();
  // WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<HomeBloc>(
        // ),
        BlocProvider<DrawerBloc>(
          create: (context) => DrawerBloc(),
        ),
         BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      BlocProvider<SevaBloc>(
          create: (context) => SevaBloc(),
        ),
     
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
