import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String _email = "";
  String _pass = "";

  void _handleSignUp() async{

    try{
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _pass,
      );
      print("New user Registered : ${userCredential.user!.email}");
      Navigator.of(context).pushReplacementNamed('/homepage');
    }catch(e) {
      print("Error During Registration : $e");
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
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){

                      _handleSignUp();
                    }
                  },
                  child: Text("Sign Up"),)


              ],
            ),
          ),
        ),
      ),

    );
  }
}
