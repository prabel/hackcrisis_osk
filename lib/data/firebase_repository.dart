import 'package:firebase_database/firebase_database.dart';
import 'package:osk_flutter/model/quiz_question_model.dart';
import 'package:osk_flutter/model/statistic_model.dart';

class FirebaseRepository {
  final DatabaseReference statisticNode = FirebaseDatabase.instance.reference().child("statistics");
  final DatabaseReference quizNode = FirebaseDatabase.instance.reference().child("quiz");

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
}
