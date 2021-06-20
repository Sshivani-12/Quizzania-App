import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rait_online_portal/components/database.dart';
import 'package:rait_online_portal/components/question_model.dart';
import 'package:rait_online_portal/components/quiz_play_widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizPlay extends StatefulWidget {
  final String quizId;
  final String email;
  final String name;
  final String subject, quizTitle;

  QuizPlay(
      {@required this.quizId,
      @required this.email,
      @required this.name,
      @required this.subject,
      @required this.quizTitle});

  @override
  _QuizPlayState createState() => _QuizPlayState();
}

bool quizSubmitStatus = false;
// if (_formKey.currentState
//     .validate()) {
int _correct = 0;
int _incorrect = 0;
int _notAttempted;
int _attempted;
int total = 0;
DatabaseService databaseService = DatabaseService();

Stream infoStream;

class _QuizPlayState extends State<QuizPlay> {
  QuerySnapshot questionSnaphot;
  DatabaseService databaseService = DatabaseService();

  bool isLoading = true;

  @override
  void initState() {
    quizSubmitStatus = false;
    databaseService.getQuestionData(quizId: widget.quizId).then(
      (value) {
        questionSnaphot = value;
        total = value.documents.length;
        isLoading = false;
        _correct = 0;
        _incorrect = 0;
        _notAttempted = 0;
        _attempted = 0;
        setState(() {});
      },
    );

    if (infoStream == null) {
      infoStream = Stream<List<int>>.periodic(Duration(milliseconds: 100), (x) {
        print("this is x $x");
        return [_correct, _incorrect];
      });
    }

    super.initState();
  }

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot.data["question"];

    /// shuffling the options
    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"]
    ];

    if (!quizSubmitStatus) {
      options.shuffle();
    }

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(129, 28, 51, 1),
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  !quizSubmitStatus
                      ? 'Total Questions :  $total'
                      : 'Grade :  $_correct.00 out of $total.00',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Text(
                  !quizSubmitStatus ? 'Time Left : 7:36' : '',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: isLoading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      // InfoHeader(
                      //   length: questionSnaphot.documents.length,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      questionSnaphot.documents == null
                          ? Container(
                              child: Center(
                                child: Text("No Data"),
                              ),
                            )
                          : ListView.builder(
                              itemCount: questionSnaphot.documents.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return QuizPlayTile(
                                  questionModel:
                                      getQuestionModelFromDatasnapshot(
                                          questionSnaphot.documents[index]),
                                  index: index,
                                );
                              })
                    ],
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _notAttempted = total - _correct - _incorrect;
            _attempted = total - _notAttempted;
            var alertStyle = AlertStyle(
              isCloseButton: false,
            );
            Alert(
              context: context,
              style: alertStyle,
              type: AlertType.info,
              title: "",
              content: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        !quizSubmitStatus ? 'Attempted : ' : '   Correct : ',
                      ),
                      Text(
                        !quizSubmitStatus ? '$_attempted' : '$_correct',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(!quizSubmitStatus
                          ? '    Skipped : '
                          : 'Incorrect : '),
                      Text(
                        !quizSubmitStatus ? '$_notAttempted' : '$_incorrect',
                      ),
                    ],
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  child: Text(
                    !quizSubmitStatus ? "Continue" : "Review",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  color: Color.fromRGBO(129, 28, 51, 1),
                ),
                DialogButton(
                  child: Text(
                    !quizSubmitStatus ? "Submit" : "Finish",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    if (quizSubmitStatus) Navigator.pop(context);
                    if (!quizSubmitStatus)
                      setState(() {
                        quizSubmitStatus = true;
                        String grade = '$_correct.00 out of $total.00';
                        Map<String, String> quizDataForStudent = {
                          "grade": grade,
                          "subject": widget.subject,
                          "quizTitle": widget.quizTitle,
                        };
                        Map<String, String> quizDataForFaculty = {
                          "grade": grade,
                          "name": widget.name,
                          "subject": widget.subject,
                          "quizTitle": widget.quizTitle,
                        };
                        databaseService.addQuizDetailsOnStudentEnd(
                            studentEmail: widget.email,
                            quizId: widget.quizId,
                            quizData: quizDataForStudent);
                        databaseService.addQuizDetailsOnFacultyEnd(
                            studentEmail: widget.email,
                            quizId: widget.quizId,
                            quizData: quizDataForFaculty);
                      });
                  },
                  color: Color.fromRGBO(129, 28, 51, 1),
                ),
              ],
            ).show();
          },
          child: Icon(
            Icons.check,
          ),
          backgroundColor: Color.fromRGBO(129, 28, 51, 1),
        ));
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  QuizPlayTile({@required this.questionModel, @required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Q${widget.index + 1}. ${widget.questionModel.question}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                // if (!widget.questionModel.answered) {
                ///correct
                // if (widget.questionModel.option1 ==
                //     widget.questionModel.correctOption) {
                //   setState(() {
                //     optionSelected = widget.questionModel.option1;
                //     widget.questionModel.answered = true;
                //     _correct = _correct + 1;
                //     _notAttempted = _notAttempted + 1;
                //   });
                // } else {
                //   setState(() {
                //     optionSelected = widget.questionModel.option1;
                //     widget.questionModel.answered = true;
                //     _incorrect = _incorrect + 1;
                //     _notAttempted = _notAttempted - 1;
                //   });
                // }
                setState(() {
                  if (!quizSubmitStatus) {
                    if (optionSelected == widget.questionModel.option1) {
                      optionSelected = null;
                      if (widget.questionModel.option1 ==
                          widget.questionModel.correctOption)
                        _correct = _correct - 1;
                      else
                        _incorrect = _incorrect - 1;
                    } else
                      optionSelected = widget.questionModel.option1;
                    if (optionSelected == widget.questionModel.option1) {
                      if (widget.questionModel.option1 ==
                          widget.questionModel.correctOption)
                        _correct = _correct + 1;
                      else
                        _incorrect = _incorrect + 1;
                    }
                  }
                });
              },
              child: OptionTile(
                option: "A",
                description: "${widget.questionModel.option1}",
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected,
                quizSubmitStatus: quizSubmitStatus,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                // if (!widget.questionModel.answered) {
                ///correct
                // if (widget.questionModel.option1 ==
                //     widget.questionModel.correctOption) {
                //   setState(() {
                //     optionSelected = widget.questionModel.option1;
                //     widget.questionModel.answered = true;
                //     _correct = _correct + 1;
                //     _notAttempted = _notAttempted + 1;
                //   });
                // } else {
                //   setState(() {
                //     optionSelected = widget.questionModel.option1;
                //     widget.questionModel.answered = true;
                //     _incorrect = _incorrect + 1;
                //     _notAttempted = _notAttempted - 1;
                //   });
                // }
                setState(() {
                  if (!quizSubmitStatus) {
                    if (optionSelected == widget.questionModel.option2) {
                      optionSelected = null;
                      if (widget.questionModel.option2 ==
                          widget.questionModel.correctOption)
                        _correct = _correct - 1;
                      else
                        _incorrect = _incorrect - 1;
                    } else
                      optionSelected = widget.questionModel.option2;
                    if (optionSelected == widget.questionModel.option2) {
                      if (widget.questionModel.option2 ==
                          widget.questionModel.correctOption)
                        _correct = _correct + 1;
                      else
                        _incorrect = _incorrect + 1;
                    }
                  }
                });
              },
              child: OptionTile(
                option: "B",
                description: "${widget.questionModel.option2}",
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected,
                quizSubmitStatus: quizSubmitStatus,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                // if (!widget.questionModel.answered) {
                ///correct
                // if (widget.questionModel.option1 ==
                //     widget.questionModel.correctOption) {
                //   setState(() {
                //     optionSelected = widget.questionModel.option1;
                //     widget.questionModel.answered = true;
                //     _correct = _correct + 1;
                //     _notAttempted = _notAttempted + 1;
                //   });
                // } else {
                //   setState(() {
                //     optionSelected = widget.questionModel.option1;
                //     widget.questionModel.answered = true;
                //     _incorrect = _incorrect + 1;
                //     _notAttempted = _notAttempted - 1;
                //   });
                // }
                setState(() {
                  if (!quizSubmitStatus) {
                    if (optionSelected == widget.questionModel.option3) {
                      optionSelected = null;
                      if (widget.questionModel.option3 ==
                          widget.questionModel.correctOption)
                        _correct = _correct - 1;
                      else
                        _incorrect = _incorrect - 1;
                    } else
                      optionSelected = widget.questionModel.option3;
                    if (optionSelected == widget.questionModel.option3) {
                      if (widget.questionModel.option3 ==
                          widget.questionModel.correctOption)
                        _correct = _correct + 1;
                      else
                        _incorrect = _incorrect + 1;
                    }
                  }
                });
              },
              child: OptionTile(
                option: "C",
                description: "${widget.questionModel.option3}",
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected,
                quizSubmitStatus: quizSubmitStatus,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                // if (!widget.questionModel.answered) {
                //   ///correct
                //   // if (widget.questionModel.option1 ==
                //   //     widget.questionModel.correctOption) {
                //   //   setState(() {
                //   //     optionSelected = widget.questionModel.option1;
                //   //     widget.questionModel.answered = true;
                //   //     _correct = _correct + 1;
                //   //     _notAttempted = _notAttempted + 1;
                //   //   });
                //   // } else {
                //   //   setState(() {
                //   //     optionSelected = widget.questionModel.option1;
                //   //     widget.questionModel.answered = true;
                //   //     _incorrect = _incorrect + 1;
                //   //     _notAttempted = _notAttempted - 1;
                //   //   });
                //   // }
                //   setState(() {
                //     optionSelected = widget.questionModel.option4;
                //   });
                // } else {
                //   setState(() {
                //     if (optionSelected != widget.questionModel.option4) {
                //       optionSelected = widget.questionModel.option4;
                //     } else {
                //       setState(() {
                //         optionSelected = 'cdsa';
                //       });
                //     }
                //   });
                // }
                setState(() {
                  if (!quizSubmitStatus) {
                    if (optionSelected == widget.questionModel.option4) {
                      optionSelected = null;
                      if (widget.questionModel.option4 ==
                          widget.questionModel.correctOption)
                        _correct = _correct - 1;
                      else
                        _incorrect = _incorrect - 1;
                    } else
                      optionSelected = widget.questionModel.option4;
                    if (optionSelected == widget.questionModel.option4) {
                      if (widget.questionModel.option4 ==
                          widget.questionModel.correctOption)
                        _correct = _correct + 1;
                      else
                        _incorrect = _incorrect + 1;
                    }
                  }
                });
              },
              child: OptionTile(
                option: "D",
                description: "${widget.questionModel.option4}",
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected,
                quizSubmitStatus: quizSubmitStatus,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
