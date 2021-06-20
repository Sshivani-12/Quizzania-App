import 'package:flutter/material.dart';
import 'package:rait_online_portal/components/database.dart';
import 'package:rait_online_portal/faculty_screen/quiz_history.dart';

class PrevQuizFaculty extends StatefulWidget {
  final String facultySdrn;
  PrevQuizFaculty({@required this.facultySdrn});

  @override
  _PrevQuizFacultyState createState() => _PrevQuizFacultyState();
}

class _PrevQuizFacultyState extends State<PrevQuizFaculty> {
  Stream prevQuizStream;
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    databaseService
        .getPrevQuizFaculty(facultySdrn: widget.facultySdrn)
        .then((value) {
      prevQuizStream = value;
      setState(() {});
    });
  }

  Widget quizList() {
    return Container(
      child: ListView(
        children: [
          StreamBuilder(
            stream: prevQuizStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                          title:
                              snapshot.data.documents[index].data['quizTitle'],
                          subject:
                              snapshot.data.documents[index].data['subject'],
                          id: snapshot.data.documents[index].data['quizId'],
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
          'Quiz History',
        ),
        backgroundColor: Color.fromRGBO(129, 28, 51, 1),
      ),
      body: quizList(),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String title, subject, id;

  QuizTile({
    @required this.title,
    @required this.subject,
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
                  subject,
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                subtitle: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              ButtonBar(
                children: <Widget>[
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
                          builder: (context) => QuizHistory(
                            quizId: id,
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
