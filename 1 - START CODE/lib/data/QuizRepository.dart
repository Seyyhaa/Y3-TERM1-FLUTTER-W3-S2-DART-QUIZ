import 'dart:convert';
import 'dart:io';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;
  QuizRepository(this.filePath);

  
Quiz readQuiz() {
  final file = File(filePath);
  if (!file.existsSync()) throw Exception('File not found: $filePath');

  final content = file.readAsStringSync();
  final data = jsonDecode(content);

  var questions = (data['questions'] as List).map((q) {
    return Question(
      id: q['id'],
      title: q['title'],
      choices: List<String>.from(q['choices']),
      goodChoice: q['goodChoice'],
      point: q['point'] ?? 0,
    );
  }).toList();

  var quiz = Quiz(questions: questions);

  if (data['players'] != null) {
    for (var p in data['players']) {
      Player player = Player(id: p['id'], name: p['name']);
      if (p['answers'] != null) {
        for (var a in p['answers']) {
          player.addAnswer(Answer(
            id: a['id'],
            questionId: a['questionId'],
            answerChoice: a['answerChoice'],
          ));
        }
      }
      quiz.addPlayer(player);
    }
  }

  return quiz;
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
    }).toList(),
    'players': quiz.players.map((p) {
      return {
        'id': p.id,
        'name': p.name,
        'answers': p.answers.map((a) {
          return {
            'id': a.id ?? '',
            'questionId': a.questionId,
            'answerChoice': a.answerChoice,
          };
        }).toList(),
      };
    }).toList(),
  };

  file.writeAsStringSync(jsonEncode(data), flush: true);
  print('Quiz saved to $filePath');
}
}
