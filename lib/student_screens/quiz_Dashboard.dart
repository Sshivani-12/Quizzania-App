import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rait_online_portal/components/database.dart';
import 'package:rait_online_portal/student_screens/testadd_quiz.dart';

class DashBoardScreen extends StatefulWidget {
  final String studentBranch;
  final String studentName;
  final String studentYear;
  final String studentDiv;
  final String studentBatch;
  final String studentOptionalSubject;
  final String studentEamilId;
  DashBoardScreen(
      {@required this.studentBatch,
      @required this.studentBranch,
      @required this.studentDiv,
      @required this.studentEamilId,
      @required this.studentOptionalSubject,
      @required this.studentYear,
      @required this.studentName});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  Stream quizStreamByCollege;
  Stream quizStreamByBranch;
  Stream quizStreamByYear;
  Stream quizStreamByBranchYear;
  Stream quizStreamByDiv;
  Stream quizStreamByBatch;
  Stream quizStreamByOptinalSubject;
  Stream quizStreamBySelectedOptional;

  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();

    databaseService.getQuizDataCollege().then((value) {
      quizStreamByCollege = value;
      setState(() {});
    });
    databaseService
        .getQuizDataByBranch(branch: widget.studentBranch)
        .then((value) {
      quizStreamByBranch = value;
      setState(() {});
    });
    databaseService.getQuizDataByYear(year: widget.studentYear).then((value) {
      quizStreamByYear = value;
      setState(() {});
    });
    databaseService
        .getQuizDataByBranchYear(
            year: widget.studentYear, branch: widget.studentBranch)
        .then((value) {
      quizStreamByBranchYear = value;
      setState(() {});
    });
    databaseService
        .getQuizDataByDiv(
            year: widget.studentYear,
            branch: widget.studentBranch,
            div: widget.studentDiv)
        .then((value) {
      quizStreamByDiv = value;
      setState(() {});
    });
    databaseService
        .getQuizDataByBatch(
            year: widget.studentYear,
            branch: widget.studentBranch,
            div: widget.studentDiv,
            batch: widget.studentBatch)
        .then((value) {
      quizStreamByBatch = value;
      setState(() {});
    });
    databaseService
        .getQuizDataBySelectedOptional(
            year: widget.studentYear,
            branch: widget.studentBranch,
            div: widget.studentDiv,
            batch: widget.studentBatch,
            optionalSubject: widget.studentOptionalSubject)
        .then((value) {
      quizStreamBySelectedOptional = value;
      setState(() {});
    });
    databaseService
        .getQuizDataByOptional(
            year: widget.studentYear,
            branch: widget.studentBranch,
            optionalSubject: widget.studentOptionalSubject)
        .then((value) {
      quizStreamByOptinalSubject = value;
      setState(() {});
    });

  }

  Widget quizList() {
    return Container(
      child: ListView(
        children: [
          StreamBuilder(
            stream: quizStreamByCollege,
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
          StreamBuilder(
            stream: quizStreamByBranch,
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
          StreamBuilder(
            stream: quizStreamByYear,
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
          StreamBuilder(
            stream: quizStreamByBranchYear,
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
          StreamBuilder(
            stream: quizStreamByDiv,
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
          StreamBuilder(
            stream: quizStreamByBatch,
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
          StreamBuilder(
            stream: quizStreamBySelectedOptional,
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
          StreamBuilder(
            stream: quizStreamByOptinalSubject,
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
          'Quiz',
        ),
        backgroundColor: Color.fromRGBO(129, 28, 51, 1),
      ),
      body: quizList(),
    );
  }
}

class QuizTile extends StatefulWidget {
  final String title, subject, email, id, name;

  QuizTile(
      {@required this.title,
      @required this.subject,
      @required this.id,
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
          .collection('Quiz')
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
                        widget.subject,
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      subtitle: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        Text(
                          'By Faculty Name',
                        ),
                        FlatButton(
                            child: Text(
                              'START QUIZ',
                              style: TextStyle(
                                color: Color.fromRGBO(129, 28, 51, 1),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizPlay(
                                    quizTitle: widget.title,
                                    subject: widget.subject,
                                    name: widget.name,
                                    email: widget.email,
                                    quizId: widget.id,
                                  ),
                                ),
                              );
                            }),
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
