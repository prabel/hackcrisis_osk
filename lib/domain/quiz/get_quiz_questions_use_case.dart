import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/model/quiz_question_model.dart';

class GetQuizQuestionsUseCase {
  final FirebaseRepository _firebaseRepository;

  GetQuizQuestionsUseCase(this._firebaseRepository);

  Future<List<QuizQuestionModel>> execute() => _firebaseRepository.getQuizQuestions();
}
