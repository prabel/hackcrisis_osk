class InterviewQuestionModel {
  final String question;
  final List<String> answers;

  const InterviewQuestionModel({this.question, this.answers});

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answers': answers,
    };
  }

  factory InterviewQuestionModel.fromMap(Map<dynamic, dynamic> map) {
    return new InterviewQuestionModel(
      question: map['question'] as String,
      answers: (map['answers'] as List<dynamic>).cast<String>(),
    );
  }
}
