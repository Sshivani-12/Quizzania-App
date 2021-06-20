import 'package:flutter/material.dart';
import 'package:rait_online_portal/components/database.dart';

class AddQuestion extends StatefulWidget {
  final String documentId;
  AddQuestion({@required this.documentId});

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  int i = 1;

  String question = "", option1 = "", option2 = "", option3 = "", option4 = "";

  uploadQuizData(int k) {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };

      databaseService
          .addQuestionData(
              questionData: questionMap,
              questionNo: i.toString(),
              documentId: widget.documentId)
          .then((value) {
        if (k == 0) {
          question = "";
          option1 = "";
          option2 = "";
          option3 = "";
          option4 = "";
          i++;
        } else {
          Navigator.pop(context);
        }
        setState(() {
          isLoading = false;
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is happening ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(129, 28, 51, 1),
          title: Text(
            'Add Question',
          ),
        ),
        body: SafeArea(
          child: Container(
            child: isLoading
                ? Container(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Enter Question" : null,
                              decoration: InputDecoration(
                                hintText: "Question",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(129, 28, 51, 1),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                question = val;
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Option1 " : null,
                              decoration: InputDecoration(
                                hintText: "Option1 (Correct Answer)",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(129, 28, 51, 1),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                option1 = val;
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Option2 " : null,
                              decoration: InputDecoration(
                                hintText: "Option2",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(129, 28, 51, 1),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                option2 = val;
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Option3 " : null,
                              decoration: InputDecoration(
                                hintText: "Option3",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(129, 28, 51, 1),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                option3 = val;
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Option4 " : null,
                              decoration: InputDecoration(
                                hintText: "Option4",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(129, 28, 51, 1),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                option4 = val;
                              },
                            ),
                            SizedBox(
                              height: 310.0,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    uploadQuizData(1);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            20,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(129, 28, 51, 1),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    uploadQuizData(0);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            40,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(129, 28, 51, 1),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Text(
                                      "Add Question",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
