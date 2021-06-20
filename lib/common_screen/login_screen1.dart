import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rait_online_portal/components/alertButton.dart';
import 'package:rait_online_portal/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool checkBoxValue = false;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Image.asset(
                          'images/RAIT_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        25.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60.0,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Email cannot be blank" : null,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Enter your email'),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Password cannot be blank" : null,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Enter your password'),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                // print('hello');
                              },
                              child: Text(
                                'Forgot password',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'New member? ',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    onAlertButtonsPressed(
                                      context: context,
                                      type: AlertType.none,
                                      title: 'Sign Up',
                                      desc: 'Who are you?',
                                      label1: 'Faculty',
                                      label2: 'Student',
                                      onPressed1: () =>
                                          Navigator.popAndPushNamed(
                                              context, '/faculty_signup'),
                                      onPressed2: () =>
                                          Navigator.popAndPushNamed(
                                              context, '/student_signup'),
                                    );
                                  },
                                  child: Text(
                                    ' Sign Up',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );
                                  {
                                    //user != null means the user exists
                                    if (user != null) {
                                      //checking for is it a faculty if not then it is a student
                                      try {
                                        var isFaculty = await Firestore.instance
                                            .collection("Faculty_User_Details")
                                            .document(email)
                                            .get();
                                        {
                                          if (isFaculty.data != null)
                                            //If data is not null means the user has data in faculty user i.e te user is faculty

                                            Navigator.pushNamed(
                                                context, '/faculty_dashboard');
                                          else
                                            //else student dashoboard
                                            Navigator.pushNamed(
                                                context, '/student_dashboard');
                                        }
                                      } catch (e) {}
                                    }
                                  }
                                } catch (e) {
                                  print(e);
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
