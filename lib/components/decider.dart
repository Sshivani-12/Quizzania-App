import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rait_online_portal/faculty_screen/faculty_dashboard.dart';
import 'package:rait_online_portal/student_screens/student_Dashboard.dart';

Future<Widget> getUserType(email) async {
  var result;
  try {
    var isFaculty = await Firestore.instance
        .collection("Faculty_User_Details")
        .document(email)
        .get();
    {
      result = isFaculty.data != null ? FacultyDashboard() : StudentDashboard();
    }
  } catch (e) {}
  return result;
}
