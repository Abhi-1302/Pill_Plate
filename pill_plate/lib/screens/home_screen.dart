import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to Home Page',
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: Colors.blue[800]),
      ),
    );
  }
}
