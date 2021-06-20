import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rait_online_portal/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:rait_online_portal/common_screen/root.dart';
import 'package:rait_online_portal/student_screens/attendance_Dashboard.dart';
import 'package:rait_online_portal/student_screens/prev_Attendance.dart';
import 'package:rait_online_portal/student_screens/prev_Quiz.dart';
import 'package:rait_online_portal/student_screens/quiz_Dashboard.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _firestore = Firestore.instance;

class StudentDashboard extends StatefulWidget {
  @override
  StudentDashboardState createState() => StudentDashboardState();
}

class StudentDashboardState extends State<StudentDashboard> {
  String studentName;
  String studentEmailId;
  String studentRollNo;
  String studentYear;
  String studentBranch;
  String studentDiv;
  String studentBatch;
  String studentOptionalSubject;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    studentEmailId = user.email;
    getDrawerDetails();
  }

  getDrawerDetails() async {
    try {
      DocumentSnapshot studentDetails = await _firestore
          .collection('Student_User_Details')
          .document(studentEmailId)
          .get();
      {
        setState(() {
          studentRollNo = studentDetails.data["roll_no"];
          studentName = studentDetails.data["name"];
          studentYear = studentDetails.data["year"];
          studentBranch = studentDetails.data["branch"];
          studentDiv = studentDetails.data["div"];
          studentBatch = studentDetails.data["batch"];
          studentOptionalSubject = studentDetails.data["optional_subject"];
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
                color: Color.fromRGBO(129, 28, 51, .8),
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
                    studentName == null
                        ? 'student Name'
                        : studentName.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    studentRollNo == null ? 'Roll No' : studentRollNo,
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
                    builder: (context) => AttendanceDashBoardScreen(
                      studentName: studentName,
                      studentBatch: studentBatch,
                      studentBranch: studentBranch,
                      studentDiv: studentDiv,
                      studentEamilId: studentEmailId,
                      studentOptionalSubject: studentOptionalSubject,
                      studentYear: studentYear,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Prev. Attendance'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PrevAttendance(studentEamilId: studentEmailId)));
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
                    builder: (context) => DashBoardScreen(
                        studentName: studentName,
                        studentBatch: studentBatch,
                        studentBranch: studentBranch,
                        studentDiv: studentDiv,
                        studentEamilId: studentEmailId,
                        studentOptionalSubject: studentOptionalSubject,
                        studentYear: studentYear),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Prev. Quiz'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PrevQuiz(studentEamilId: studentEmailId)));
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
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[]),
        ),
      ),
    );
  }
}
