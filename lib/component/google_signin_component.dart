import 'package:capstonefe/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInDemo extends StatefulWidget {
  @override
  _SignInDemoState createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  late GoogleSignIn _googleSignIn;
  late GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    _handleSignIn();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _currentUser = _googleSignIn.currentUser;
      });

      if (_currentUser != null) {
        // 사용자 정보 사용 예시:
        final userName = _currentUser!.displayName;
        final serverAuth = _currentUser!.serverAuthCode;
        _moveSignUpActivity();
      } else {
        print("Login was cancelled or failed");
      }
    } catch (error) {
      print(error);
    }
  }

  void _moveSignUpActivity() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            HomeScreen(), // Sign up activity 대신 실제 사용하는 화면으로 변경
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign in with Google'),
          onPressed: () {
            _handleSignIn();
          },
        ),
      ),
    );
  }
}
