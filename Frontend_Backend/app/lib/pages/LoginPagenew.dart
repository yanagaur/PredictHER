import 'package:flutter/material.dart';

class LoginPageNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView( // Wrap the body with SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Logo or Image could be added here related to women hygiene

              SizedBox(height: 20.0),

              // Email Input Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),

              // Password Input Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true, // Password is hidden
              ),

              SizedBox(height: 20.0),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Handle login logic here
                  // For now, we'll navigate to the homepage
                  Navigator.of(context).pushReplacementNamed('/homepage');
                },
                child: Text('Login'),
              ),

              SizedBox(height: 10.0),

              // Forgot Password Button
              TextButton(
                onPressed: () {
                  // Navigate to the reset password page
                  Navigator.of(context).pushNamed('/resetpassword'); // Change 'reset password' to 'resetpassword'
                },
                child: Text('Forgot Password?'),
              ),

              SizedBox(height: 10.0),

              // Sign Up Button
              TextButton(
                onPressed: () {
                  // Navigate to the signup page
                  Navigator.of(context).pushReplacementNamed('/signup');
                },
                child: Text('Not registered? Sign Up'),
              ),

              // Error Message for Incorrect Login
              // You can display this message conditionally based on login errors
              Text(
                'Incorrect ID or Password',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
