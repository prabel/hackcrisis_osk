import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/model/interview_question_model.dart';

class GetInerviewQuestionsUseCase {
  final FirebaseRepository _firebaseRepository;

  GetInerviewQuestionsUseCase(this._firebaseRepository);

  Future<List<InterviewQuestionModel>> execute() => _firebaseRepository.getInterviewQuestions();
}
