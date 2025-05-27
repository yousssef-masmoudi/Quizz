class QuestionAttempt {
  final String questionText;
  final String selectedAnswer;
  final String correctAnswer;

  QuestionAttempt({
    required this.questionText,
    required this.selectedAnswer,
    required this.correctAnswer,
  });

  // Convert QuestionAttempt to JSON
  Map<String, dynamic> toJson() => {
        'questionText': questionText,
        'selectedAnswer': selectedAnswer,
        'correctAnswer': correctAnswer,
      };

  // Create QuestionAttempt from JSON
  factory QuestionAttempt.fromJson(Map<String, dynamic> json) =>
      QuestionAttempt(
        questionText: json['questionText'],
        selectedAnswer: json['selectedAnswer'],
        correctAnswer: json['correctAnswer'],
      );
}
