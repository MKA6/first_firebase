import 'package:firebase_core/firebase_core.dart';
import 'package:first_firedase/AppRouter/AppRouter.dart';
import 'package:first_firedase/Views/Splach/Splach.dart';
import 'package:first_firedase/firebase_options.dart';
import 'package:first_firedase/providers/AdminProvider/AdminProvider.dart';
import 'package:first_firedase/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context){
          return AuthProvider();
        },
      ),
      ChangeNotifierProvider(
        create: (context){
          return AdminProvider();
        },
      ),
    ],
      child: MaterialApp(
        navigatorKey: AppRouter.navKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: SplachScreen(),
      ),
    );
  }
}
