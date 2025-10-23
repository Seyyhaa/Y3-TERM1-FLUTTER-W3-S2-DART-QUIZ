import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---');

    while (true) {
      stdout.write('\nYour name: ');
      String? name = stdin.readLineSync();

      if (name == null || name.isEmpty) {
        print('\n--- Quiz Finished ---');
        break;
      }

      // Get or create the player
      Player player = quiz.getOrCreatePlayer(name);

      for (var question in quiz.questions) {
        print('Question: ${question.title} - ( ${question.point} points )');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(question: question, answerChoice: userInput);
          player.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      // Calculate and show this player's score
      Map<String, int> result = quiz.getScore(player);
      print('${name}, your score in percentage: ${result['Percentage']} %');
      print('${name}, your score in points: ${result['Score']}');

      // Show leaderboard
      for (var entry in quiz.getAllScores().entries) {
        print('Player: ${entry.key}\tScore:${entry.value}');
      }
    }
  }
}
