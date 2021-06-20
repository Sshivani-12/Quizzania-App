import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rait_online_portal/components/alertButton.dart';
import 'package:provider/provider.dart';
import 'package:rait_online_portal/faculty_screen/add_quiz.dart';
import 'package:rait_online_portal/faculty_screen/attendance.dart';
import 'package:rait_online_portal/faculty_screen/prev_Attendance.dart';
import 'package:rait_online_portal/faculty_screen/prev_Quiz.dart';
import 'package:rait_online_portal/states/currentUser.dart';
import 'package:rait_online_portal/common_screen/root.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _firestore = Firestore.instance;

class FacultyDashboard extends StatefulWidget {
  @override
  FacultyDashboardState createState() => FacultyDashboardState();
}

class FacultyDashboardState extends State<FacultyDashboard> {
  String facutlySdrn;
  String facultyName;
  String facultyEmailId;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    facultyEmailId = user.email;
    getDrawerDetails();
  }

  getDrawerDetails() async {
    try {
      DocumentSnapshot facultyDetails = await _firestore
          .collection('Faculty_User_Details')
          .document(facultyEmailId)
          .get();
      {
        setState(() {
          facutlySdrn = facultyDetails.data["sdrn"];
          facultyName = facultyDetails.data["name"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(129, 28, 51, 1),
        title: Text(
          'Dashboard',
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(129, 28, 51, 0.8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  Text(
                    facultyName == null
                        ? 'faculty Name'
                        : facultyName.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'SDRN : $facutlySdrn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Attendance'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAttendance(
                      facultyEmailId: facultyEmailId,
                      facutlySdrn: facutlySdrn,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Prev. Attendance'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrevAttendanceFaculty(
                              facultySdrn: facutlySdrn,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Quiz'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddQuiz(
                      facultyEmailId: facultyEmailId,
                      facutlySdrn: facutlySdrn,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Prev. Quiz'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrevQuizFaculty(
                              facultySdrn: facutlySdrn,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            GestureDetector(
              onTap: () async {
                CurrentUser _currentUser =
                    Provider.of<CurrentUser>(context, listen: false);
                await _currentUser.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => OurRoot()),
                    (route) => false);
              },
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onAlertButtonsPressed(
            context: context,
            type: AlertType.info,
            title: 'Wish to',
            desc: 'Add',
            label1: 'Quiz',
            label2: 'Attendance',
            onPressed1: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddQuiz(
                    facultyEmailId: facultyEmailId,
                    facutlySdrn: facutlySdrn,
                  ),
                ),
              );
            },
            onPressed2: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAttendance(
                    facultyEmailId: facultyEmailId,
                    facutlySdrn: facutlySdrn,
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(129, 28, 51, 1),
      ),
    );
  }
}
