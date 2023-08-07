import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:treasure/home_page.dart';
import 'constants.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLogin=false;
  checkIfLogin() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if(user!=null && mounted){
        setState(() {
          isLogin= true;
          userUid=user.uid;
          int length = user.email!.length-10;
          userName = user.email!.substring(0, length);
        });
        print('USER UID IS : $userUid');
        print('USER NAME IS : $userName');
      }
    });
  }
  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        '/homepage' : (context) => const MyHomePage(),
        '/loginpage' : (context) => LoginPage(),
      },
      title: 'Treasure Hunt',
      home: isLogin? MyHomePage() : LoginPage() ,
    );
  }
}
