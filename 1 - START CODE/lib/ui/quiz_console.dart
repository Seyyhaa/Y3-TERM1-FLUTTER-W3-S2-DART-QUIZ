import 'dart:io';
import 'package:my_first_project/data/QuizRepository.dart';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;
   QuizRepository repo;

  QuizConsole({required this.quiz,required this.repo});

  void startQuiz() {
    print('--- Welcome to the Quiz ---');

    while (true) {
      stdout.write('\nYour name: ');
      String? name = stdin.readLineSync();

      if (name == null || name.isEmpty) {
        print('\n--- Quiz Finished ---');
        break;
      }

      Player player = quiz.getOrCreatePlayer(name);

      for (var question in quiz.questions) {
        print('Question: ${question.title} - ( ${question.point} points )');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(
            questionId: question.id,
            answerChoice: userInput,
          );
          player.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      Map<String, int> result = quiz.getScore(player);
      print('${name}, your score in percentage: ${result['Percentage']} %');
      print('${name}, your score in : ${result['Score']} points');

      for (var entry in quiz.getAllScores().entries) {
        print('Player: ${entry.key}\tScore:${entry.value}');
      }
       repo.writeQuiz(quiz);
    }
  }
}
