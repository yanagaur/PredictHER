import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:predicther_03/pages/LoginPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    String? _email = _auth.currentUser!.email;
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Logged in with $_email"),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  _auth.signOut();
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => LoginPage()
                  ));
                },
                child: Text("Signout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
