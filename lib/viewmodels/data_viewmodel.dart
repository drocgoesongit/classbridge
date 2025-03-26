import 'dart:developer';
import 'package:classbridge/model/reminder_model.dart';
import 'package:classbridge/model/student_model.dart';
import 'package:classbridge/model/subject_model.dart';
import 'package:classbridge/model/tests_model.dart';
import 'package:classbridge/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchData with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isUserDataLoading = false;
  bool get isUserDataLoading => _isUserDataLoading;
  bool _isTestDataLoading = false;
  bool get isTestDataLoading => _isTestDataLoading;
  String _studentName = "";
  String get studentName => _studentName;
  String _studentClass = "";
  String get studentClass => _studentClass;
  String _studentId = "";
  String get studentId => _studentId;

  List<StudentModel> _students = [];
  List<StudentModel> get students => _students;
  List<SubjectModel> _subjects = [];
  List<SubjectModel> get subjects => _subjects;
  List<ReminderModel> _reminders = [];
  List<ReminderModel> get reminders => _reminders;

  UserModel? _user;
  UserModel? get user => _user;
  List<TestsModel> _tests = [];
  List<TestsModel> get tests => _tests;

  FetchData() {
    getFunction();
    addListeners();
    if (FirebaseAuth.instance.currentUser != null) {
      getUserData();
    }
  }

  void addListeners() {
    FirebaseFirestore.instance
        .collection("students")
        .snapshots()
        .listen((event) {
      getFunction();
      notifyListeners();
    });
    FirebaseFirestore.instance
        .collection("subjects")
        .snapshots()
        .listen((event) {
      getFunction();
      notifyListeners();
    });
    FirebaseFirestore.instance
        .collection("reminders")
        .snapshots()
        .listen((event) {
      getFunction();
      notifyListeners();
    });
  }

  Future<void> getFunction() async {
    _isLoading = true;
    notifyListeners();
    try {
      await FirebaseFirestore.instance
          .collection("students")
          .get()
          .then((value) {
        _students =
            value.docs.map((e) => StudentModel.fromJson(e.data())).toList();
      });
      await FirebaseFirestore.instance
          .collection("subjects")
          .get()
          .then((value) async {
        List<SubjectModel> tempSubjects = [];
        for (var doc in value.docs) {
          int testsCount = await doc.reference
              .collection("tests")
              .get()
              .then((value) => value.size);
          SubjectModel subject = SubjectModel.fromJson(doc.data());
          subject.numberOfTests = testsCount;
          tempSubjects.add(subject);
        }
        _subjects = tempSubjects;
      });
      await FirebaseFirestore.instance
          .collection("reminders")
          .get()
          .then((value) {
        _reminders =
            value.docs.map((e) => ReminderModel.fromJson(e.data())).toList();
        _reminders.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
      });
      notifyListeners();
    } catch (e) {
      log("Error in getFunction: e", name: "FetchData");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getUserData() async {
    _isUserDataLoading = true;
    notifyListeners();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? type = prefs.getString("type");
      if (type == "parents") {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection("users").doc(uid).get();
        if (userDoc.exists) {
          _user = UserModel.fromJson(userDoc.data()! as Map<String, dynamic>);
          QuerySnapshot studentDocs = await FirebaseFirestore.instance
              .collection("students")
              .where("id", isEqualTo: _user!.studentId)
              .limit(1)
              .get();

          if (studentDocs.docs.isNotEmpty) {
            DocumentSnapshot studentDoc = studentDocs.docs.first;
            _studentName = studentDoc["name"];
            _studentClass = studentDoc["class"];
            _studentId = studentDoc["id"];
          } else {
            log("Student document does not exist", name: "FetchData");
          }
        }
      }

      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if (userDoc.exists) {
        _user = UserModel.fromJson(userDoc.data()! as Map<String, dynamic>);
      }
      notifyListeners();
    } catch (e) {
      log("Error in getFunction: e", name: "FetchData");
    }
    _isUserDataLoading = false;
    notifyListeners();
  }

  Future<void> getTestDataForSubject(String subjectName) async {
    _isTestDataLoading = true;
    notifyListeners();
    try {
      _tests.clear(); // Clear the previous tests data
      QuerySnapshot subjectQuery = await FirebaseFirestore.instance
          .collection('subjects')
          .where('subjectName', isEqualTo: subjectName)
          .get();

      if (subjectQuery.docs.isNotEmpty) {
        String subjectDocId = subjectQuery.docs.first.id;

        QuerySnapshot testQuery = await FirebaseFirestore.instance
            .collection('subjects')
            .doc(subjectDocId)
            .collection("tests")
            .get();

        for (var doc in testQuery.docs) {
          TestsModel test = TestsModel.fromJson({
            "name": doc.id,
            "data": doc.data() as Map<String, dynamic>,
          });
          _tests.add(test);
        }
      }
      notifyListeners();
    } catch (e) {
      log("Error in getTestDataForSubject: e", name: "FetchData");
    }
    _isTestDataLoading = false;
    notifyListeners();
  }
}
