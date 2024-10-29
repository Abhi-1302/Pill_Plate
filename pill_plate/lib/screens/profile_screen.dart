import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          SizedBox(height: 16),
          Text('Username: johndoe', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('Email: johndoe@example.com', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
