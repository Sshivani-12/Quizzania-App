import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // Future<void> addData(userData) async {
  //   Firestore.instance.collection("users").add(userData).catchError((e) {
  //     print(e);
  //   });
  // }

  // getData() async {
  //   return await Firestore.instance.collection("users").snapshots();
  // }

  Future<void> addQuizData(Map quizData, String documentId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(documentId)
        .setData(quizData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addAttendanceData(Map attendanceData, String documentId) async {
    await Firestore.instance
        .collection("Attendance")
        .document(documentId)
        .setData(attendanceData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addQuestionData(
      {@required Map questionData,
      @required String questionNo,
      @required String documentId}) async {
    await Firestore.instance
        .collection("Quiz")
        .document(documentId)
        .collection('QNA')
        .document('Question_No_$questionNo')
        .setData(questionData)
        .catchError((e) {
      print(e);
    });
  }

  // getTotalCount({@required String quizId}) async {
  //   return await Firestore.instance
  //       .collection('Quiz')
  //       .document(quizId)
  //       .collection('Attempted')
  //       .snapshots()
  //       .length
  //       .toString();
  // }

  getQuizDetails({@required String quizId}) async {
    return Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("Attempted")
        .snapshots();
  }

  getAttendanceDetails({@required String attendanceId}) async {
    return Firestore.instance
        .collection("Attendance")
        .document(attendanceId)
        .collection("Present")
        .snapshots();
  }

  getPrevQuizStudent({@required String email}) async {
    return Firestore.instance
        .collection("Student_User_Details")
        .document(email)
        .collection("Quiz")
        .snapshots();
  }

  getPrevAttendanceStudent({@required String email}) async {
    return Firestore.instance
        .collection("Student_User_Details")
        .document(email)
        .collection("Attendance")
        .snapshots();
  }

  getPrevQuizFaculty({@required String facultySdrn}) async {
    return Firestore.instance
        .collection("Quiz")
        .where('maker', isEqualTo: facultySdrn)
        .snapshots();
  }

  getPrevAttendanceFaculty({@required String facultySdrn}) async {
    return Firestore.instance
        .collection("Attendance")
        .where('maker', isEqualTo: facultySdrn)
        .snapshots();
  }

  getQuizDataCollege() async {
    return Firestore.instance
        .collection("Quiz")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: '0')
        .where('year', isEqualTo: '0')
        .where('div', isEqualTo: '0')
        .where('batch', isEqualTo: '0')
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getQuizDataByBranch({
    @required String branch,
  }) async {
    return Firestore.instance
        .collection("Quiz")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: '0')
        .where('div', isEqualTo: '0')
        .where('batch', isEqualTo: '0')
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getQuizDataByYear({
    @required String year,
  }) async {
    return Firestore.instance
        .collection("Quiz")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('year', isEqualTo: year)
        .where('branch', isEqualTo: '0')
        .where('div', isEqualTo: '0')
        .where('batch', isEqualTo: '0')
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getQuizDataByBranchYear({
    @required String year,
    @required String branch,
  }) async {
    return Firestore.instance
        .collection("Quiz")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: year)
        .where('div', isEqualTo: '0')
        .where('batch', isEqualTo: '0')
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getQuizDataByDiv({
    @required String branch,
    @required String year,
    @required String div,
  }) async {
    return Firestore.instance
        .collection("Quiz")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: year)
        .where('div', isEqualTo: div)
        .where('batch', isEqualTo: '0')
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getQuizDataByBatch({
    @required String branch,
    @required String year,
    @required String div,
    @required String batch,
  }) async {
    return Firestore.instance
        .collection("Quiz")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: year)
        .where('div', isEqualTo: div)
        .where('batch', isEqualTo: batch)
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getQuizDataBySelectedOptional({
    @required String branch,
    @required String year,
    @required String div,
    @required String batch,
    @required String optionalSubject,
  }) async {
    return Firestore.instance
        .collection("Quiz")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: year)
        .where('div', isEqualTo: div)
        .where('batch', isEqualTo: batch)
        .where('optional_subject', isEqualTo: optionalSubject)
        .snapshots();
  }

  getQuizDataByOptional({
    @required String branch,
    @required String year,
    @required String optionalSubject,
  }) async {
    return Firestore.instance
        .collection("Quiz")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: year)
        .where('optional_subject', isEqualTo: optionalSubject)
        .where('batch', isEqualTo: '0')
        .where('div', isEqualTo: '0')
        .snapshots();
  }

  getAttendanceDataCollege() async {
    return Firestore.instance
        .collection("Attendance")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: '0')
        .where('year', isEqualTo: '0')
        .where('div', isEqualTo: '0')
        .where('batch', isEqualTo: '0')
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getAttendanceDataByBranch({
    @required String branch,
  }) async {
    return Firestore.instance
        .collection("Attendance")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: '0')
        .where('div', isEqualTo: '0')
        .where('batch', isEqualTo: '0')
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getAttendanceDataByYear({
    @required String year,
  }) async {
    return Firestore.instance
        .collection("Attendance")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('year', isEqualTo: year)
        .where('branch', isEqualTo: '0')
        .where('div', isEqualTo: '0')
        .where('batch', isEqualTo: '0')
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getAttendanceDataByBranchYear({
    @required String year,
    @required String branch,
  }) async {
    return Firestore.instance
        .collection("Attendance")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: year)
        .where('div', isEqualTo: '0')
        .where('batch', isEqualTo: '0')
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getAttendanceDataByDiv({
    @required String branch,
    @required String year,
    @required String div,
  }) async {
    return Firestore.instance
        .collection("Attendance")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: year)
        .where('div', isEqualTo: div)
        .where('batch', isEqualTo: '0')
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getAttendanceDataByBatch({
    @required String branch,
    @required String year,
    @required String div,
    @required String batch,
  }) async {
    return Firestore.instance
        .collection("Attendance")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: year)
        .where('div', isEqualTo: div)
        .where('batch', isEqualTo: batch)
        .where('optional_subject', isEqualTo: '0')
        .snapshots();
  }

  getAttendanceDataBySelectedOptional({
    @required String branch,
    @required String year,
    @required String div,
    @required String batch,
    @required String optionalSubject,
  }) async {
    return Firestore.instance
        .collection("Attendance")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: year)
        .where('div', isEqualTo: div)
        .where('batch', isEqualTo: batch)
        .where('optional_subject', isEqualTo: optionalSubject)
        .snapshots();
  }

  getAttendanceDataByOptional({
    @required String branch,
    @required String year,
    @required String optionalSubject,
  }) async {
    return Firestore.instance
        .collection("Attendance")
        // .where('is_Avaialble', isEqualTo: 'True')
        .where('branch', isEqualTo: branch)
        .where('year', isEqualTo: year)
        .where('optional_subject', isEqualTo: optionalSubject)
        .where('batch', isEqualTo: '0')
        .where('div', isEqualTo: '0')
        .snapshots();
  }

  getQuestionData({@required String quizId}) async {
    return await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection('QNA')
        .getDocuments();
  }

  getTotalQuestionCount({@required String quizId}) async {
    return await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection('QNA')
        .snapshots()
        .length;
  }

  addQuizDetailsOnStudentEnd(
      {@required String studentEmail,
      @required String quizId,
      @required Map quizData}) async {
    await Firestore.instance
        .collection("Student_User_Details")
        .document(studentEmail)
        .collection("Quiz")
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e);
    });
  }

  addAttendanceDetailsOnStudentEnd(
      {@required String studentEmail,
      @required String attendanceId,
      @required Map attendanceData}) async {
    await Firestore.instance
        .collection("Student_User_Details")
        .document(studentEmail)
        .collection("Attendance")
        .document(attendanceId)
        .setData(attendanceData)
        .catchError((e) {
      print(e);
    });
  }

  addQuizDetailsOnFacultyEnd(
      {@required String studentEmail,
      @required String quizId,
      @required Map quizData}) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("Attempted")
        .document(studentEmail)
        .setData(quizData)
        .catchError((e) {
      print(e);
    });
  }

  addAttendanceDetailsOnFacultyEnd(
      {@required String studentEmail,
      @required String attendanceId,
      @required Map attendanceData}) async {
    await Firestore.instance
        .collection("Attendance")
        .document(attendanceId)
        .collection("Present")
        .document(studentEmail)
        .setData(attendanceData)
        .catchError((e) {
      print(e);
    });
  }
}
