import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errormsg = '';
  bool islogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errormsg = e.message!;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errormsg = e.message!;
      });
    }
  }

  Widget _title() {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(bottom: 20.0),
      child: Text(
        'Welcome!👋🏻',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: GoogleFonts.sora().fontFamily,
          fontSize: 35, // Larger size for the main title
          fontWeight: FontWeight.w900,
          color: const Color.fromARGB(255, 234, 234, 234),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: _controllerEmail,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextField(
        obscureText: true,
        controller: _controllerPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

 Widget _errorMessage() {
  // Replace with your error handling logic
  return Text(
    'Invalid email or password', // Example error message
    style: TextStyle(
      color: Colors.redAccent,
      fontSize: 16,
    ),
  );
}

  Widget submitButton() {
    return ElevatedButton(
      onPressed:
          islogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.amberAccent, // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
      child: Text(islogin ? 'Login' : 'Register',
          style: TextStyle(fontSize: 18, color: Colors.blue)),
    );
  }

  Widget _loginOrRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          islogin = !islogin;
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue, // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
      child: Text(
        islogin ? 'Create an account' : 'Already have an account',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Taskifier 📝',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(235, 14, 134, 239), // Use a color from your theme
      ),
      body: Container(
        color: Color.fromARGB(243, 42, 43, 43),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _title(), // Set a larger font size for title
                        _emailField(),
                        _passwordField(),
                        // _errorMessage(),
                        submitButton(),
                      ],
                    ),
                  ),
                Column(
                  mainAxisSize: MainAxisSize.min, // Restrict column height
                  children: [
                    SizedBox(height: 10),
                    _loginOrRegisterButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
