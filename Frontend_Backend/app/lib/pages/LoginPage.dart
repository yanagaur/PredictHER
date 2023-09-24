

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:predicther_03/pages/WelcomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String _email = "";
  String _pass = "";

  void _handleLogin() async{
    try{
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _pass,
      );

      Navigator.of(context).pushReplacementNamed('/homepage');
    }catch(e) {
      print("Error During Login : $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PredictHER"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email"
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please Enter Your Email";
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password"
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please Enter Your Password";
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      _pass = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _handleLogin();
                    }

                  },
                  child: Text("Login"),
                ),
                SizedBox(height: 20),


                TextButton(
                  onPressed: () {
                    // Navigate to the signup page
                    Navigator.of(context).pushReplacementNamed('/signup');
                  },
                  child: Text('Not registered? Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
