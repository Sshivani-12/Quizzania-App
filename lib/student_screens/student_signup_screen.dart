import 'package:flutter/material.dart';
import 'package:rait_online_portal/components/dropdown_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class StudentSignUpScreen extends StatefulWidget {
  @override
  _StudentSignUpScreenState createState() => _StudentSignUpScreenState();
}

class _StudentSignUpScreenState extends State<StudentSignUpScreen> {
  final _firestore = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String name;
  String email;
  String rollno;
  String year;
  String branch;
  String div;
  String batch;
  String optionalsubject;
  String password;
  bool showSpinner = false;

  String selectedYear;
  String selectedBranch;
  String selectedBatch;
  String selectedDiv;
  String selectedOptionalSubject;
  bool checkBoxValue = false;
  dynamic i;

  List<DropdownMenuItem> getDropDownItems(List dropdownList) {
    List<DropdownMenuItem> dropDownItems = [];

    for (i in dropdownList) {
      var newItem = DropdownMenuItem(
        child: Text(i.toString()),
        value: i,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

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
                                              hintText: 'Enter Name',
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
                                                ? "Roll no. cannot be blank"
                                                : null,
                                            onChanged: (value) {
                                              rollno = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Enter roll no.',
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
                                          DropdownButtonFormField(
                                              validator: (val) => val == null
                                                  ? "Select Year"
                                                  : null,
                                              hint: Text('Select Year'),
                                              iconEnabledColor: Colors.red[900],
                                              value: selectedYear,
                                              items: getDropDownItems(YearList),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedYear = value;
                                                  year = value;
                                                });
                                              }),
                                          DropdownButtonFormField(
                                              validator: (val) => val == null
                                                  ? "Select Branch"
                                                  : null,
                                              hint: Text('Select Branch'),
                                              iconEnabledColor: Colors.red[900],
                                              value: selectedBranch,
                                              items:
                                                  getDropDownItems(BranchList),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedBranch = value;
                                                  branch = value;
                                                });
                                              }),
                                          DropdownButtonFormField(
                                              validator: (val) => val == null
                                                  ? "Select Division"
                                                  : null,
                                              hint: Text('Select Division'),
                                              iconEnabledColor: Colors.red[900],
                                              value: selectedDiv,
                                              items:
                                                  getDropDownItems(DivisonList),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedDiv = value;
                                                  div = value;
                                                });
                                              }),
                                          DropdownButtonFormField(
                                              validator: (val) => val == null
                                                  ? "Select Batch"
                                                  : null,
                                              hint: Text('Select Batch'),
                                              iconEnabledColor: Colors.red[900],
                                              value: selectedBatch,
                                              items:
                                                  getDropDownItems(BatchList),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedBatch = value;
                                                  batch = value;
                                                });
                                              }),
                                          DropdownButtonFormField(
                                              validator: (val) => val == null
                                                  ? "Select Optional Subject"
                                                  : null,
                                              hint: Text(
                                                  'Select Optional Subject'),
                                              iconEnabledColor: Colors.red[900],
                                              value: selectedOptionalSubject,
                                              items: getDropDownItems(
                                                  OptionalSubjectList),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedOptionalSubject =
                                                      value;
                                                  optionalsubject = value;
                                                });
                                              }),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          TextFormField(
                                            obscureText: true,
                                            validator: (val) => val.isEmpty
                                                ? "Password cannot be blank"
                                                : null,
                                            onChanged: (value) {
                                              password = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Create password',
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
                                            height: 20.0,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                setState(() {
                                                  showSpinner = true;
                                                });
                                                try {
                                                  final newUser = await _auth
                                                      .createUserWithEmailAndPassword(
                                                    email: email,
                                                    password: password,
                                                  );
                                                  if (newUser != null) {
                                                    await _firestore
                                                        .collection(
                                                            'Student_User_Details')
                                                        .document(email)
                                                        .setData({
                                                      'email': email,
                                                      'name': name,
                                                      'roll_no': rollno,
                                                      'year': year,
                                                      'branch': branch,
                                                      'div': div,
                                                      'batch': batch,
                                                      'optional_subject':
                                                          optionalsubject,
                                                      'password': password
                                                    });
                                                    Navigator.pop(context);
                                                    Navigator.popAndPushNamed(
                                                        context,
                                                        '/student_dashboard');
                                                  }
                                                } catch (e) {
                                                  print(e);
                                                }
                                                setState(() {
                                                  showSpinner = false;
                                                });
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
