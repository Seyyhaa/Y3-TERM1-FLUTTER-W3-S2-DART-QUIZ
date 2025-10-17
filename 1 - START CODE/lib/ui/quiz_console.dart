import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');
    stdout.write('Your answer: ');
    String? userInput = stdin.readLineSync();
    for (var question in quiz.questions) {
      print('Question: ${question.title} - (${question.point} points)');
      print('Choices: ${question.choices}');
      stdout.write('Your answer: ');
      String? userInput = stdin.readLineSync();

      // Check for null input
      if (userInput != null && userInput.isNotEmpty) {
        Answer answer = Answer(question: question, answerChoice: userInput);
        quiz.addAnswer(answer);
      } else {
        print('No answer entered. Skipping question.');
      }

      print('');
    }

    Map<String, int> result = quiz.getScore();
    print('--- Quiz Finished ---');
    print('Your score: ${result['Percentage']} %');
    print('Your score: ${result['Score']} ');
    
  }
}
 