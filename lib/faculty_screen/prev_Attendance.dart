import 'package:flutter/material.dart';
import 'package:rait_online_portal/components/database.dart';
import 'package:rait_online_portal/faculty_screen/attendance_history.dart';

class PrevAttendanceFaculty extends StatefulWidget {
  final String facultySdrn;
  PrevAttendanceFaculty({@required this.facultySdrn});

  @override
  _PrevAttendanceFacultyState createState() => _PrevAttendanceFacultyState();
}

class _PrevAttendanceFacultyState extends State<PrevAttendanceFaculty> {
  Stream prevAttendanceStream;
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    databaseService
        .getPrevAttendanceFaculty(facultySdrn: widget.facultySdrn)
        .then((value) {
      prevAttendanceStream = value;
      setState(() {});
    });
  }

  Widget quizList() {
    return Container(
      child: ListView(
        children: [
          StreamBuilder(
            stream: prevAttendanceStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                          id: snapshot
                              .data.documents[index].data['attendanceId'],
                          name: snapshot
                              .data.documents[index].data['lectureName'],
                          date: snapshot.data.documents[index].data['date'],
                          time: snapshot.data.documents[index].data['time'],
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
          'Attendance History',
        ),
        backgroundColor: Color.fromRGBO(129, 28, 51, 1),
      ),
      body: quizList(),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String name, date, time, id;

  QuizTile({
    @required this.name,
    @required this.date,
    @required this.time,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  name,
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                subtitle: Text(
                  date,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Color.fromRGBO(129, 28, 51, 1),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        color: Color.fromRGBO(129, 28, 51, 1),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttendanceHistory(
                            attendanceId: id,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
