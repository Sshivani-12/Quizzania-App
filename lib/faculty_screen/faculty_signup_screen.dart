import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FacultySignUpScreen extends StatefulWidget {
  @override
  _FacultySignUpScreenState createState() => _FacultySignUpScreenState();
}

class _FacultySignUpScreenState extends State<FacultySignUpScreen> {
  final _firestore = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String name;
  String email;
  String sdrn;
  String password;
  String adminkey;
  bool showSpinner = false;

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
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Image.asset(
                                        'images/RAIT_logo.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
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
                                                ? "Name cannot be blank"
                                                : null,
                                            onChanged: (value) {
                                              name = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Enter name',
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      129, 28, 51, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          TextFormField(
                                            validator: (val) => val.isEmpty
                                                ? "Email cannot be blank"
                                                : null,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onChanged: (value) {
                                              email = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Enter email',
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      129, 28, 51, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          TextFormField(
                                            validator: (val) => val.isEmpty
                                                ? "SDRN no. cannot be blank"
                                                : null,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              sdrn = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Enter SDRN no',
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      129, 28, 51, 1),
                                                ),
                                              ),
                                            ),
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
                                              hintText: 'Enter password',
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      129, 28, 51, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          TextFormField(
                                            validator: (val) => val.isEmpty
                                                ? "Admin key cannot be blank"
                                                : null,
                                            obscureText: true,
                                            onChanged: (value) {
                                              adminkey = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Enter admin key',
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      129, 28, 51, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25.0,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                setState(() {
                                                  showSpinner = true;
                                                });

                                                if (adminkey == 'admin') {
                                                  try {
                                                    final newUser = await _auth
                                                        .createUserWithEmailAndPassword(
                                                      email: email,
                                                      password: password,
                                                    );
                                                    if (newUser != null) {
                                                      await _firestore
                                                          .collection(
                                                              'Faculty_User_Details')
                                                          .document(email)
                                                          .setData({
                                                        'name': name,
                                                        'email': email,
                                                        'sdrn': sdrn,
                                                        'password': password
                                                      });
                                                      Navigator.pop(context);
                                                      Navigator.popAndPushNamed(
                                                          context,
                                                          '/faculty_dashboard');
                                                    }
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                  setState(() {
                                                    showSpinner = false;
                                                  });
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
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Text(
                                                "Sign Up",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
