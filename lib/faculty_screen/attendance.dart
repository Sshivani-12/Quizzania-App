import 'package:flutter/material.dart';
import 'package:rait_online_portal/components/database.dart';
import 'package:rait_online_portal/components/dropdown_list.dart';
import 'package:random_string/random_string.dart';

class AddAttendance extends StatefulWidget {
  final String facutlySdrn;
  final String facultyEmailId;
  AddAttendance({
    @required this.facultyEmailId,
    @required this.facutlySdrn,
  });

  @override
  _AddAttendanceState createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {
  DatabaseService databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String year = '0';
  String branch = '0';
  String div = '0';
  String batch = '0';
  String optionalsubject = '0';
  dynamic i;
  String lectureName, date, time;
  String selectedYear;
  String selectedBranch;
  String selectedBatch;
  String selectedDiv;
  String selectedOptionalSubject;

  bool isLoading = false;
  String documentId;
  String facultyEmailId;
  String quizfor;

  createAttendance() {
    documentId = randomAlphaNumeric(20);
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> attendanceData = {
        "lectureName": lectureName,
        "date": date,
        "time": time,
        "attendanceId": documentId,
        'year': year,
        'branch': branch,
        'div': div,
        'batch': batch,
        'optional_subject': optionalsubject,
        "maker": widget.facutlySdrn
      };

      databaseService.addAttendanceData(attendanceData, documentId).then(
        (value) {
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        },
      );
    }
  }

  List<DropdownMenuItem> getDropDownItems(List dropdownList) {
    List<DropdownMenuItem> dropDownItems = [];

    for (i in dropdownList) {
      var newItem = DropdownMenuItem(
        child: Text(i.toString()),
        value: i,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
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
            'Add Attendance',
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
                          children: [
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Enter Lecture Name" : null,
                              decoration: InputDecoration(
                                hintText: "Lecture Name",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(129, 28, 51, 1),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                lectureName = val;
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Enter Date" : null,
                              decoration: InputDecoration(
                                hintText: "Date",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(129, 28, 51, 1),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                date = val;
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Enter Time" : null,
                              decoration: InputDecoration(
                                hintText: "Time",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(129, 28, 51, 1),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                time = val;
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70.0),
                              child: Divider(
                                color: Color.fromRGBO(129, 28, 51, 1),
                                thickness: 2.0,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'For',
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            DropdownButtonFormField(
                                hint: Text('Select Year'),
                                iconEnabledColor: Colors.red[900],
                                value: selectedYear,
                                items: getDropDownItems(YearList),
                                onChanged: (value) {
                                  setState(() {
                                    selectedYear = value;
                                    year = value;
                                  });
                                }),
                            DropdownButtonFormField(
                                hint: Text('Select Branch'),
                                iconEnabledColor: Colors.red[900],
                                value: selectedBranch,
                                items: getDropDownItems(BranchList),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBranch = value;
                                    branch = value;
                                  });
                                }),
                            DropdownButtonFormField(
                                hint: Text('Select Division'),
                                iconEnabledColor: Colors.red[900],
                                value: selectedDiv,
                                items: getDropDownItems(DivisonList),
                                onChanged: (value) {
                                  setState(() {
                                    selectedDiv = value;
                                    div = value;
                                  });
                                }),
                            DropdownButtonFormField(
                                hint: Text('Select Batch'),
                                iconEnabledColor: Colors.red[900],
                                value: selectedBatch,
                                items: getDropDownItems(BatchList),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBatch = value;
                                    batch = value;
                                  });
                                }),
                            DropdownButtonFormField(
                                hint: Text('Select Optional Subject'),
                                iconEnabledColor: Colors.red[900],
                                value: selectedOptionalSubject,
                                items: getDropDownItems(OptionalSubjectList),
                                onChanged: (value) {
                                  setState(() {
                                    selectedOptionalSubject = value;
                                    optionalsubject = value;
                                  });
                                }),
                            SizedBox(
                              height: 100,
                            ),
                            GestureDetector(
                              onTap: () {
                                createAttendance();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 20),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(129, 28, 51, 1),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  "Create Attendance",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
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
