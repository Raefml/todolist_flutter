//import 'package:firebase_auth/firebase_auth.dart';
import 'package:fa/reusable_widgets/reusable_widget.dart';
import 'package:fa/screens/home_screen.dart';
import 'package:fa/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../layout/layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController  _FirstTextController = TextEditingController();
  TextEditingController _LastTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("13a3f0"),
                hexStringToColor("2a74f5"),
                hexStringToColor("3E61F4")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    30, MediaQuery.of(context).size.height * 0.01, 30, 0),
                child: Column(
                  children: <Widget>[
                    logoWidget("assets/images/logo1.png"),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter First name", Icons.person_outline, false,
                        _FirstTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Last name", Icons.person_outline, false,
                        _LastTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Sign Up", () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                          .then((value) {
                        print("Created New Account");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Layout()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    })
                  ],
                ),
              ))),
    );
  }
}