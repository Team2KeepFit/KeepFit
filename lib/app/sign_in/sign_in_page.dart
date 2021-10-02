import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keepfit/app/sign_in/sign_in_button.dart';
import 'package:keepfit/app/sign_in/social_sign_in_button.dart';
import 'package:keepfit/app/common_widgets/custom_raised_button.dart';

import '../../homepage.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final userCredentials = await FirebaseAuth.instance.signInAnonymously();
      print('${userCredentials.user!.uid}');
      Navigator.of(context).push (
          MaterialPageRoute(
            builder: (context) => HomePage(),
          )
      );
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keep Fit'),
        elevation: 2.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 48.0),
          SignInButton(
            //assetName: 'images/google-logo.png',
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          SignInButton(
            //assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          Text(
            'or',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Go anonymous',
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: () => _signInAnonymously,
          ),
        ],
      ),
    );
  }
}