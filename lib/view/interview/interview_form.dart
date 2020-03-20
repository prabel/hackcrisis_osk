class InterviewForm {
  static const example = InterviewForm(
    "Czy miałaś kontakt z osobą zarażoną przez ponad 15 minut w odległości poniżej 2 metrów?",
    [
      InterviewAnswer("Tak", "yes", isPrimaryAnswer: true),
      InterviewAnswer("Nie", "no"),
      InterviewAnswer("Nie wiem", "dont_know"),
    ],
  );

  static const allInterviewForms = [
    InterviewForm(
      "Czy miałaś kontakt z osobą zarażoną przez ponad 15 minut w odległości poniżej 2 metrów?",
      [
        InterviewAnswer("Tak", "yes", isPrimaryAnswer: true),
        InterviewAnswer("Nie", "no"),
        InterviewAnswer("Nie wiem", "dont_know"),
      ],
    ),
    InterviewForm(
      "Czy wraz z gorączką (powyżej 38 st.) towarzyszy Ci kaszel lub duszności?",
      [
        InterviewAnswer("Tak", "tak", isPrimaryAnswer: true),
        InterviewAnswer("Nie", "nie"),
      ],
    ),
    InterviewForm(
      "Czy w ciągu ostatnich 14 dni przebywałeś poza granicami państwa?",
      [
        InterviewAnswer("Tak", "tak", isPrimaryAnswer: true),
        InterviewAnswer("Nie", "nie"),
      ],
    ),
    InterviewForm(
      "Czy zadzwoniłaś już do stacji epidemiologicznej?",
      [
        InterviewAnswer("Tak", "tak", isPrimaryAnswer: true),
        InterviewAnswer("Nie", "nie"),
      ],
    )
  ];

  final String question;
  final List<InterviewAnswer> answers;

  const InterviewForm(this.question, this.answers);
}

class InterviewAnswer {
  final String title;
  final String value;
  final bool isPrimaryAnswer;

  const InterviewAnswer(this.title, this.value, {this.isPrimaryAnswer = false});
}
