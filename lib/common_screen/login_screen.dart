import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rait_online_portal/components/alertButton.dart';
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
  int toastmessage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                color: Color.fromRGBO(129, 28, 51, 1),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(30, 80, 30, 60),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SafeArea(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'images/RAIT_logo.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Ramrao Adik Institute of Technology',
                                      style: TextStyle(
                                        fontSize: 17.0,
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
                                          height: 30.0,
                                        ),
                                        TextFormField(
                                          validator: (val) => val.isEmpty
                                              ? "Email cannot be blank"
                                              : null,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: "Email",
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    129, 28, 51, 1),
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            email = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        TextFormField(
                                          validator: (val) => val.isEmpty
                                              ? "Password cannot be blank"
                                              : null,
                                          obscureText: true,
                                          onChanged: (value) {
                                            password = value;
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Password",
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    129, 28, 51, 1),
                                              ),
                                            ),
                                          ),
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
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'New member? ',
                                              style: TextStyle(
                                                color: Colors.black54,
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
                                                    onPressed1: () => Navigator
                                                        .popAndPushNamed(
                                                            context,
                                                            '/faculty_signup'),
                                                    onPressed2: () => Navigator
                                                        .popAndPushNamed(
                                                            context,
                                                            '/student_signup'),
                                                  );
                                                },
                                                child: Text(
                                                  ' Sign Up',
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.black54,
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
                                            if (_formKey.currentState
                                                .validate()) {
                                              setState(() {
                                                showSpinner = true;
                                              });

                                              try {
                                                final user = await _auth
                                                    .signInWithEmailAndPassword(
                                                  email: email,
                                                  password: password,
                                                );
                                                {
                                                  //user != null means the user exists
                                                  if (user != null) {
                                                    //checking for is it a faculty if not then it is a student
                                                    try {
                                                      var isFaculty =
                                                          await Firestore
                                                              .instance
                                                              .collection(
                                                                  "Faculty_User_Details")
                                                              .document(email)
                                                              .get();
                                                      {
                                                        if (isFaculty.data !=
                                                            null) {
                                                          //If data is not null means the user has data in faculty user i.e te user is faculty

                                                          Navigator.pushNamed(
                                                              context,
                                                              '/faculty_dashboard');
                                                          toastmessage = 1;
                                                        } else {
                                                          //else student dashoboard
                                                          Navigator.pushNamed(
                                                              context,
                                                              '/student_dashboard');
                                                          toastmessage = 1;
                                                        }
                                                      }
                                                    } catch (e) {}
                                                  }
                                                  // } else {
                                                  //   Fluttertoast.showToast(
                                                  //     msg:
                                                  //         "Be inside University Premises Before Attempting the Quiz",
                                                  //     toastLength:
                                                  //         Toast.LENGTH_LONG,
                                                  //     gravity:
                                                  //         ToastGravity.BOTTOM,
                                                  //     timeInSecForIosWeb: 1,
                                                  //     backgroundColor:
                                                  //         Colors.black,
                                                  //     textColor: Colors.red,
                                                  //     fontSize: 10.0,
                                                  //   );
                                                  // }
                                                }
                                              } catch (e) {
                                                print(e);
                                                setState(() {
                                                  showSpinner = false;
                                                });
                                                if (toastmessage == 0) {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Username doesn't exist",
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.white,
                                                    textColor: Color.fromRGBO(
                                                        129, 28, 51, 1),
                                                    fontSize: 15.0,
                                                  );
                                                }
                                              }
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 20),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    51, 51, 51, 1),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
