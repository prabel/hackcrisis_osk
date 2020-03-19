class InterviewForm {
  static const example = InterviewForm(
    "Podstawowy wywiad medyczny",
    "Czy miałaś kontakt z osobą zarażoną przez ponad 15 minut w odległości poniżej 2 metrów?",
    [
      InterviewAnswer("Tak", "yes", isPrimaryAnswer: true),
      InterviewAnswer("Nie", "no"),
      InterviewAnswer("Nie wiem", "dont_know"),
    ],
  );

  final String title;
  final String subtitle;
  final List<InterviewAnswer> answers;

  const InterviewForm(this.title, this.subtitle, this.answers);
}

class InterviewAnswer {
  final String title;
  final String value;
  final bool isPrimaryAnswer;

  const InterviewAnswer(this.title, this.value, {this.isPrimaryAnswer = false});
}
