import 'dart:convert';
import 'dart:io';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;
  QuizRepository(this.filePath);

  
  Quiz readQuiz() {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('File not found: $filePath');
    }

    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q) {
      return Question(
        id: q['id'],
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        point: q['point'] ?? 0,
      );
    }).toList();

    return Quiz(questions: questions);
  }

  
  void writeQuiz(Quiz quiz) {
    final file = File(filePath);

    var data = {
      'questions': quiz.questions.map((q) {
        return {
          'id': q.id,
          'title': q.title,
          'choices': q.choices,
          'goodChoice': q.goodChoice,
          'point': q.point,
        };
      }).toList()
    };

    file.writeAsStringSync(jsonEncode(data), flush: true);
    print('Quiz saved to $filePath');
  }
}
