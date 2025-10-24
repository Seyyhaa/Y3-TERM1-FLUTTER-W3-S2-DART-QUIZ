import 'package:uuid/uuid.dart';

class Player{
  String id;
  final String name;
  List <Answer> answers =[];
  int score = 0;

  Player({String? id, required this.name}):id=id ?? const Uuid().v4();
  
  void addAnswer(Answer answer){
    return answers.add(answer);
  }

  int getScore(List<Question> questions) {
  int totalScore = 0;

  for (Answer answer in answers) {
    var question = questions.firstWhere(
      (q) => q.id == answer.questionId,
      orElse: () => Question(title: '', choices: [], goodChoice: '', point: 0),
    );
    if (answer.isGood(question)) {
      totalScore += question.point;
    }
  }
  return totalScore;
}
}

class Question{
  String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  int point;

  Question({String? id, required this.title, required this.choices, required this.goodChoice,required this.point}):id=id ?? const Uuid().v4();

  
}

class Answer{
  String? id;
  String questionId;
  final String answerChoice;

  Answer({ this.id,required this.questionId, required this.answerChoice});
  bool isGood(Question question) => answerChoice == question.goodChoice;

}

class Quiz{
  String? Id;
  List<Player> players = [];
  List<Question> questions;
  List<Answer> answers = [];
  
  Quiz({required this.questions});

  Question? getQuestionById(String id) {
  try {
    return questions.firstWhere((q) => q.id == id);
  } catch (e) {
    return null;
  }
}

 Answer? getAnswerById(String id) {
  try {
    return answers.firstWhere((a) => a.id == id);
  } catch (e) {
    return null;
  }
}


  
Map<String, int> getScore(Player player) {
  int totalScore = 0;

  for (Answer answer in player.answers) {
    var question = getQuestionById(answer.questionId);
    if (question != null && answer.isGood(question)) {
      totalScore += question.point;
    }
  }

  int totalPoint = questions.fold(0, (sum, q) => sum + q.point);
  int percent = totalPoint == 0 ? 0 : ((totalScore / totalPoint) * 100).toInt();

  return {
    'Score': totalScore,
    'Percentage': percent,
  };
}

  void addPlayer(Player player){
    return players.add(player);
  }

  Player getOrCreatePlayer(String name) {
    for (var p in players) {
      if (p.name == name) {
        p.answers.clear(); 
        return p;
      }
    }
    final newPlayer = Player(name: name);
    players.add(newPlayer);
    return newPlayer;
  }

  Map<String, int> getAllScores() {
    Map<String, int> scores = {};
    for (var p in players) {
      scores[p.name] = p.getScore(questions);
    }
    return scores;
  }

}