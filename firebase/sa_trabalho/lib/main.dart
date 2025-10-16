import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/login.dart';
import 'views/home.dart';

// NOTE: You must add your Firebase config files (google-services.json / GoogleService-Info.plist)
// to the Android / iOS folders. This example initializes Firebase and shows a small
// login -> home flow for the point registration exercise.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Ponto',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/home': (context) => const HomeView(),
      },
    );
  }
}
