import 'package:flutter/material.dart';
import 'package:rait_online_portal/student_screens/testadd_quiz.dart';

class QuizHistory extends StatefulWidget {
  final String quizId;
  QuizHistory({@required this.quizId});

  @override
  _QuizHistoryState createState() => _QuizHistoryState();
}

class _QuizHistoryState extends State<QuizHistory> {
  Stream quizStream;
  int totalAttempts = 0;
  @override
  void initState() {
    super.initState();
    databaseService.getQuizDetails(quizId: widget.quizId).then((value) {
      quizStream = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(129, 28, 51, 1),
        title: Text(
          'Quiz Details',
        ),
      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 200.0,
                          width: double.infinity,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    'Total Attempts :',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 170.0),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.donut_large,
                                      color: Colors.green,
                                      size: 50.0,
                                    ),
                                    title: Text(
                                      snapshot.data.documents.length.toString(),
                                      style: TextStyle(fontSize: 40.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.0),
            child: Divider(
              color: Color.fromRGBO(129, 28, 51, 1),
              thickness: 2.0,
            ),
          ),
          StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NameTile(
                          name: snapshot.data.documents[index].data['name'],
                          grade: snapshot.data.documents[index].data['grade'],
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}

class NameTile extends StatelessWidget {
  final String name, grade;
  NameTile({@required this.name, @required this.grade});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 10.0,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 10.0,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 200.0,
                child: Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Color.fromRGBO(129, 28, 51, 1),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                grade,
                style: TextStyle(fontSize: 17.0, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
