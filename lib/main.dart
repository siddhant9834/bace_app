import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/routes/routes.dart';
import 'package:mayapur_bace/core/side_drawer/bloc/drawer_bloc.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{
  
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
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
