import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:osk_flutter/model/assistance_extra_information_model.dart';
import 'package:osk_flutter/model/interview_question_model.dart';
import 'package:osk_flutter/model/quiz_question_model.dart';
import 'package:osk_flutter/model/statistic_model.dart';

class FirebaseRepository {
  final DatabaseReference statisticNode = FirebaseDatabase.instance.reference().child("statistics");
  final DatabaseReference quizNode = FirebaseDatabase.instance.reference().child("quiz");
  final DatabaseReference interviewNode = FirebaseDatabase.instance.reference().child("interview");
  final DatabaseReference assistancewNode = FirebaseDatabase.instance.reference().child("assistance");

  StatisticModel _statisticModelForPoland;
  StatisticModel _statisticModelForDistrict;

  /// Statistics
  Future<StatisticModel> getStatisticForPoland() async {
    _statisticModelForPoland =
        _statisticModelForPoland ?? StatisticModel.fromMap((await statisticNode.child("poland").once()).value);
    return _statisticModelForPoland;
  }

  Future<StatisticModel> getStatisticForDistrict(String districtName) async {
    _statisticModelForDistrict = _statisticModelForDistrict ??
        StatisticModel.fromMap((await statisticNode.child("districts").child(districtName).once()).value);
    return _statisticModelForDistrict;
  }

  ///Quiz
  Future<List<QuizQuestionModel>> getQuizQuestions() async {
    final questions = (await quizNode.child("questions").once()).value;
    return (questions as List).map((it) => QuizQuestionModel.fromMap(it)).toList();
  }

  /// Interview
  Future<List<InterviewQuestionModel>> getInterviewQuestions() async {
    final questions = (await interviewNode.child("questions").once()).value;
    return (questions as List).map((it) => InterviewQuestionModel.fromMap(it)).toList();
  }

  Future<String> getInterviewVideoUrl() async => (await interviewNode.child("videoUrl").once()).value;

  /// Assistance

  Future<HashMap<int, AssistanceExtraInformationModel>> getAssistanceExtraInformationsMap() async {
    final map = HashMap<int, AssistanceExtraInformationModel>();
    var model1 = AssistanceExtraInformationModel.fromMap((await assistancewNode.child("1").once()).value);
    map.putIfAbsent(1, () => model1);

    var model2 = AssistanceExtraInformationModel.fromMap((await assistancewNode.child("2").once()).value);
    map.putIfAbsent(2, () => model2);

    var model3 = AssistanceExtraInformationModel.fromMap((await assistancewNode.child("3").once()).value);
    map.putIfAbsent(3, () => model3);

    var model4 = AssistanceExtraInformationModel.fromMap((await assistancewNode.child("4").once()).value);
    map.putIfAbsent(4, () => model4);

    var model5 = AssistanceExtraInformationModel.fromMap((await assistancewNode.child("5").once()).value);
    map.putIfAbsent(5, () => model5);

    return map;
  }
}
