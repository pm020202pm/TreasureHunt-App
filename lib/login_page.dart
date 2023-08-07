import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:treasure/widgets/button.dart';
import 'constants.dart';
import 'widgets/custom_textfield.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /////SIGN IN WITH EMAIL AND PASSWORD
  void signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        setState(() {
          userUid=user.uid;
          int length = user.email!.length-10;
          userName = user.email!.substring(0, length);
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
      }
      emailController.clear();
      passwordController.clear();
    }
    catch (e) {
      print('WRONG EMAIL OR PASSWORD');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 200),
          child: Center(
            child: Column(
                children: [
                  const SizedBox(height: 30,),
                  CustomTextField(controller: emailController, obscureText: false, labelText: 'Email', boxHeight: 50, ),
                  const SizedBox(height: 30),
                  CustomTextField(controller: passwordController, obscureText: true, labelText: 'Password', boxHeight: 50, ),
                  const SizedBox(height: 60,),
                  Button(
                    buttonText: 'Login',
                    textColor: Colors.lightBlue,
                    buttonBgColor: Colors.lightGreenAccent,
                    onPressed:(){
                      signInWithEmailAndPassword(emailController.text, passwordController.text);
                      },
                    height: 45, width: screenSize.width*0.9, borderRadius: 15,
                    splashColor: Colors.green[500],
                  ),
                ],
              ),
          ),
        ),
      )
    );

  }
}
