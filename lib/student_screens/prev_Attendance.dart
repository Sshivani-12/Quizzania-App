import 'package:flutter/material.dart';
import 'package:rait_online_portal/components/database.dart';

class PrevAttendance extends StatefulWidget {
  final String studentEamilId;
  PrevAttendance({@required this.studentEamilId});

  @override
  _PrevAttendanceState createState() => _PrevAttendanceState();
}

class _PrevAttendanceState extends State<PrevAttendance> {
  Stream prevAttendanceStream;
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    databaseService
        .getPrevAttendanceStudent(email: widget.studentEamilId)
        .then((value) {
      prevAttendanceStream = value;
      setState(() {});
    });
  }

  Widget attendanceList() {
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
          'Attendance History',
        ),
        backgroundColor: Color.fromRGBO(129, 28, 51, 1),
      ),
      body: attendanceList(),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String lecture, date, time, id;

  QuizTile({
    @required this.lecture,
    @required this.date,
    @required this.id,
    @required this.time,
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
                  lecture,
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
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Presentee Marked",
                      style: TextStyle(
                        color: Color.fromRGBO(129, 28, 51, 1),
                      ),
                    ),
                    onPressed: null,
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
