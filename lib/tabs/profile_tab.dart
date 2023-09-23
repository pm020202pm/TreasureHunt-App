import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../login_page.dart';
import '../widgets/text_button.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  TextEditingController feedbackController = TextEditingController();

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage())));
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80,),
          const CircleAvatar(
            radius: 80,
            foregroundImage: NetworkImage('https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            userName.toUpperCase(),
            style: const TextStyle(fontSize: 23),
          ),
          const SizedBox(
            height: 40,
          ),
          const SizedBox(height: 20,),
          Button(
            buttonText: 'Logout', textColor: Colors.grey[100],
            buttonBgColor: Colors.grey[400],
            onPressed: () {logout();},
            height: 50,
            width: screenSize.width * 0.9,
            borderRadius: 15,
            fontSize: 21,
            fontWeight: FontWeight.w500,
            splashColor: Colors.red[400],
          ),
        ]),
      ),
    );
  }
}
