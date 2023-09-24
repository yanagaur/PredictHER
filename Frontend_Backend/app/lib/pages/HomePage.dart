import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('predictHer'),
    ),
    drawer: Drawer(
    child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
    DrawerHeader(
    decoration: BoxDecoration(
    color: Colors.pink,
    ),
    child: Text(
    'Menu',
    style: TextStyle(
    color: Colors.white,
    fontSize: 24,
    ),
    ),
    ),
    ListTile(
    leading: Icon(Icons.home),
    title: Text('Home'),
    onTap: () {
    Navigator.pop(context); // Close the drawer
    // Handle navigation to the homepage here
    // You can use Navigator.of(context).pushNamed('/homepage')
    },
    ),
    ListTile(
    leading: Icon(Icons.person),
    title: Text('Profile'),
    onTap: () {
    Navigator.pop(context); // Close the drawer
    // Handle navigation to the profile page here
    // You can use Navigator.of(context).pushNamed('/profile')
    },
    ),
    ListTile(
    leading: Icon(Icons.settings),
    title: Text('Settings'),
    onTap: () {
    Navigator.pop(context); // Close the drawer
    // Handle navigation to the settings page here
    // You can use Navigator.of(context).pushNamed('/settings')
    },
    ),
    ListTile(
    leading: Icon(Icons.logout),
    title: Text('Logout'),
    onTap: () {
    Navigator.pop(context); // Close the drawer
    // Handle the logout action here
    // You can implement the logout logic
    },
    ),
    ],
    ),
    ),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text(
    'Welcome to predictHer!',
    style: TextStyle(fontSize: 24),
    ),
    SizedBox(height: 20),
    // Placeholder for displaying articles
    Text('Add articles here'),

    SizedBox(height: 20),
    Text(
    'You can start entering your data to test for PCOS',
    style: TextStyle(fontSize: 18),
    ),
    SizedBox(height: 10),
    ElevatedButton(
    onPressed: () {
    // Redirect users to the "Menstrual Cycle Data" page
    Navigator.of(context).pushNamed('/cycle');
    },
    child: Text('Start Data Entry'),
    ),
    ],
    ),
    ),
    );
  }
}
