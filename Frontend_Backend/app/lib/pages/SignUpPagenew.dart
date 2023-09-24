import 'package:flutter/material.dart';

class SignUpPageNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView( // Wrap the body with SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Name Input Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),

              SizedBox(height: 20.0),

              // Mobile Number Input Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                ),
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 20.0),

              // Email Input Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 20.0),

              // Password Input Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true, // Password is hidden
              ),

              SizedBox(height: 20.0),

              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  // Handle sign-up logic here
                  // You can create the user's account and perform necessary actions.
                  // After successful sign-up, you can navigate to the login page.
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
