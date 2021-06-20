import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rait_online_portal/components/database.dart';

class AttendanceDashBoardScreen extends StatefulWidget {
  final String studentBranch;
  final String studentName;
  final String studentYear;
  final String studentDiv;
  final String studentBatch;
  final String studentOptionalSubject;
  final String studentEamilId;
  AttendanceDashBoardScreen(
      {@required this.studentBatch,
      @required this.studentBranch,
      @required this.studentDiv,
      @required this.studentEamilId,
      @required this.studentOptionalSubject,
      @required this.studentYear,
      @required this.studentName});

  @override
  _AttendanceDashBoardScreenState createState() =>
      _AttendanceDashBoardScreenState();
}

DatabaseService databaseService = DatabaseService();

class _AttendanceDashBoardScreenState extends State<AttendanceDashBoardScreen> {
  Stream attendanceStreamByBranch;
  Stream attendanceStreamByYear;
  Stream attendanceStreamByCollege;
  Stream attendanceStreamByBranchYear;
  Stream attendanceStreamByDiv;
  Stream attendanceStreamByBatch;
  Stream attendanceStreamByOptinalSubject;
  Stream attendanceStreamBySelectedOptional;

  @override
  void initState() {
    super.initState();

    databaseService.getAttendanceDataCollege().then((value) {
      attendanceStreamByCollege = value;
      setState(() {});
    });
    databaseService
        .getAttendanceDataByBranch(branch: widget.studentBranch)
        .then((value) {
      attendanceStreamByBranch = value;
      setState(() {});
    });
    databaseService
        .getAttendanceDataByYear(year: widget.studentYear)
        .then((value) {
      attendanceStreamByYear = value;
      setState(() {});
    });
    databaseService
        .getAttendanceDataByBranchYear(
            year: widget.studentYear, branch: widget.studentBranch)
        .then((value) {
      attendanceStreamByBranchYear = value;
      setState(() {});
    });
    databaseService
        .getAttendanceDataByDiv(
            year: widget.studentYear,
            branch: widget.studentBranch,
            div: widget.studentDiv)
        .then((value) {
      attendanceStreamByDiv = value;
      setState(() {});
    });
    databaseService
        .getAttendanceDataByBatch(
            year: widget.studentYear,
            branch: widget.studentBranch,
            div: widget.studentDiv,
            batch: widget.studentBatch)
        .then((value) {
      attendanceStreamByBatch = value;
      setState(() {});
    });
    databaseService
        .getAttendanceDataBySelectedOptional(
            year: widget.studentYear,
            branch: widget.studentBranch,
            div: widget.studentDiv,
            batch: widget.studentBatch,
            optionalSubject: widget.studentOptionalSubject)
        .then((value) {
      attendanceStreamBySelectedOptional = value;
      setState(() {});
    });
    databaseService
        .getAttendanceDataByOptional(
            year: widget.studentYear,
            branch: widget.studentBranch,
            optionalSubject: widget.studentOptionalSubject)
        .then((value) {
      attendanceStreamByOptinalSubject = value;
      setState(() {});
    });
  }

  Widget attendanceList() {
    return Container(
      child: ListView(
        children: [
          StreamBuilder(
            stream: attendanceStreamByCollege,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                          name: widget.studentName,
                          email: widget.studentEamilId,
                          lecture: snapshot
                              .data.documents[index].data['lectureName'],
                          date: snapshot.data.documents[index].data['date'],
                          time: snapshot.data.documents[index].data['time'],
                          id: snapshot
                              .data.documents[index].data['attendanceId'],
                        );
                      },
                    );
            },
          ),
          StreamBuilder(
            stream: attendanceStreamByBranch,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                          name: widget.studentName,
                          email: widget.studentEamilId,
                          lecture: snapshot
                              .data.documents[index].data['lectureName'],
                          date: snapshot.data.documents[index].data['date'],
                          time: snapshot.data.documents[index].data['time'],
                          id: snapshot
                              .data.documents[index].data['attendanceId'],
                        );
                      },
                    );
            },
          ),
          StreamBuilder(
            stream: attendanceStreamByYear,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                          name: widget.studentName,
                          email: widget.studentEamilId,
                          lecture: snapshot
                              .data.documents[index].data['lectureName'],
                          date: snapshot.data.documents[index].data['date'],
                          time: snapshot.data.documents[index].data['time'],
                          id: snapshot
                              .data.documents[index].data['attendanceId'],
                        );
                      },
                    );
            },
          ),
          StreamBuilder(
            stream: attendanceStreamByBranchYear,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                          name: widget.studentName,
                          email: widget.studentEamilId,
                          lecture: snapshot
                              .data.documents[index].data['lectureName'],
                          date: snapshot.data.documents[index].data['date'],
                          time: snapshot.data.documents[index].data['time'],
                          id: snapshot
                              .data.documents[index].data['attendanceId'],
                        );
                      },
                    );
            },
          ),
          StreamBuilder(
            stream: attendanceStreamByDiv,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                          name: widget.studentName,
                          email: widget.studentEamilId,
                          lecture: snapshot
                              .data.documents[index].data['lectureName'],
                          date: snapshot.data.documents[index].data['date'],
                          time: snapshot.data.documents[index].data['time'],
                          id: snapshot
                              .data.documents[index].data['attendanceId'],
                        );
                      },
                    );
            },
          ),
          StreamBuilder(
            stream: attendanceStreamByBatch,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                          name: widget.studentName,
                          email: widget.studentEamilId,
                          lecture: snapshot
                              .data.documents[index].data['lectureName'],
                          date: snapshot.data.documents[index].data['date'],
                          time: snapshot.data.documents[index].data['time'],
                          id: snapshot
                              .data.documents[index].data['attendanceId'],
                        );
                      },
                    );
            },
          ),
          StreamBuilder(
            stream: attendanceStreamBySelectedOptional,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                          name: widget.studentName,
                          email: widget.studentEamilId,
                          lecture: snapshot
                              .data.documents[index].data['lectureName'],
                          date: snapshot.data.documents[index].data['date'],
                          time: snapshot.data.documents[index].data['time'],
                          id: snapshot
                              .data.documents[index].data['attendanceId'],
                        );
                      },
                    );
            },
          ),
          StreamBuilder(
            stream: attendanceStreamByOptinalSubject,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                          name: widget.studentName,
                          email: widget.studentEamilId,
                          lecture: snapshot
                              .data.documents[index].data['lectureName'],
                          date: snapshot.data.documents[index].data['date'],
                          time: snapshot.data.documents[index].data['time'],
                          id: snapshot
                              .data.documents[index].data['attendanceId'],
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
        ),
        backgroundColor: Color.fromRGBO(129, 28, 51, 1),
      ),
      body: attendanceList(),
    );
  }
}

class QuizTile extends StatefulWidget {
  final String lecture, date, time, email, id, name;

  QuizTile(
      {@required this.lecture,
      @required this.date,
      @required this.id,
      @required this.time,
      @required this.email,
      @required this.name});

  @override
  _QuizTileState createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  int available;
  @override
  void initState() {
    super.initState();
    validator();
  }

  validator() async {
    try {
      var isAvailable = await Firestore.instance
          .collection("Student_User_Details")
          .document(widget.email)
          .collection('Attendance')
          .document(widget.id)
          .get();
      {
        if (isAvailable.data == null) {
          available = 1;
          setState(() {});
        } else {
          available = 0;
          setState(() {});
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return available == 1
        ? Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                right: 4.0,
              ),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.library_books),
                      title: Text(
                        widget.lecture,
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      subtitle: Text(
                        widget.date,
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        Text(
                          widget.time,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            'Mark Presentee.',
                            style: TextStyle(
                              color: Color.fromRGBO(129, 28, 51, 1),
                            ),
                          ),
                          onPressed: () {
                            // setState(() {
                            Map<String, String> attendanceDataForStudent = {
                              "lectureName": widget.lecture,
                              "date": widget.date,
                              "time": widget.time,
                            };
                            Map<String, String> attendanceDataForFaculty = {
                              "studentName": widget.name,
                            };
                            databaseService.addAttendanceDetailsOnStudentEnd(
                              studentEmail: widget.email,
                              attendanceData: attendanceDataForStudent,
                              attendanceId: widget.id,
                            );
                            databaseService.addAttendanceDetailsOnFacultyEnd(
                              studentEmail: widget.email,
                              attendanceData: attendanceDataForFaculty,
                              attendanceId: widget.id,
                            );
                            Navigator.pop(context);
                            // });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}

// GestureDetector(
//                 onTap: () async{
//                   Position position = await getCurrentLocation();
//                   var userLat = position.latitude.toString();
//                   var userLon = position.longitude.toString();
//                   double distanceInMeters = await Geolocator().distanceBetween(double.parse(userLon), double.parse(userLat), 72.8656507,19.259711);
//                   if(distanceInMeters < 20.00){
//                     print('This worked');
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AttendanceScreen(
//                             studentBranch: studentBranch,
//                             studentDiv: studentDiv,
//                             studentEmailId: studentEmailId,
//                             studentRollNo:studentRollNo,
//                             studentOptionalSubject: studentOptionalSubject,
//                             studentYear: studentYear),
//                       ),
//                     );
//                   }
//                   else
//                     {
//                       print('else worked');
//                       Fluttertoast.showToast(
//                           msg: "Be inside University Premises Before Attempting the Quiz",
//                           toastLength: Toast.LENGTH_LONG,
//                           gravity: ToastGravity.BOTTOM,
//                           timeInSecForIosWeb: 1,
//                           backgroundColor: Colors.red[900],
//                           textColor: Colors.white,
//                           fontSize: 10.0
//                       );
//                     }
//                 },
//                 child: Container(
//                   child: Text(
//                     'Take Attendance',
//                   ),
//                 ),
//               ),
