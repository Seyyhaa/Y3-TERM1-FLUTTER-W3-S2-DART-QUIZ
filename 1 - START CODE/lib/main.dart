import 'dart:io';
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/QuizRepository.dart';

void main() {
  try {
    QuizRepository qr = QuizRepository("./quiz.json");
    Quiz quiz;

    final file = File("./quiz.json");
    if (file.existsSync()) {
      
      quiz = qr.readQuiz();
    } else {
    
      List<Question> questions = [
        Question(
            title: "Capital of France?",
            choices: ["Paris", "London", "Rome"],
            goodChoice: "Paris",
            point: 100),
        Question(
            title: "2 + 2 = ?",
            choices: ["2", "4", "5"],
            goodChoice: "4",
            point: 100),
        Question(
            title: "What color is the sky?",
            choices: ["Blue", "Green", "Red"],
            goodChoice: "Blue",
            point: 50),
        Question(
            title: "Who is the Best?",
            choices: ["RONAN", "SABAY", "SOK"],
            goodChoice: "RONAN",
            point: 999),
      ];

      quiz = Quiz(questions: questions);
      qr.writeQuiz(quiz);
    }

    QuizConsole console = QuizConsole(quiz: quiz);
    console.startQuiz();

  } catch (e) {
    print("Error: $e");
  }
}
