import 'package:flutter/material.dart';

class Forgot_pass extends StatelessWidget {
  const Forgot_pass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Instruction Text
            const Text(
              'Enter your email address below to reset your password.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20.0),

            // Email Input Field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),

            const SizedBox(height: 20.0),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Handle password reset logic here
                // You can display a message to inform the user
                // that a reset link has been sent to their email address.
                // For now, we'll navigate back to the login page.
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
