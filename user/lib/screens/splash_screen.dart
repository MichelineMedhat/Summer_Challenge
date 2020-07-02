import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: CircleAvatar(
          child:
              Image.asset('assets/face-shield-girl.png', fit: BoxFit.scaleDown),
          backgroundColor: Colors.transparent,
          radius: MediaQuery.of(context).size.width / 8,
        ),
      ),
    );
  }
}
