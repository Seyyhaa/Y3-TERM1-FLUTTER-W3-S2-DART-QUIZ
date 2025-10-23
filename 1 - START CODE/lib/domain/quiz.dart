class Player{
  final String name;
  List <Answer> answers =[];
   int score = 0;

  Player({required this.name});
  
  void addAnswer(Answer answer){
    return answers.add(answer);
  }

  int getScore(){
    int totalScore = 0;

    for(Answer answer in answers){
      if(answer.isGood()){
        totalScore += answer.question.point ;
      }
    }
    return totalScore;
  }

}

class Question{
  final String title;
  final List<String> choices;
  final String goodChoice;
  int point;

  Question({required this.title, required this.choices, required this.goodChoice,required this.point});
}

class Answer{
  final Question question;
  final String answerChoice;
 

  Answer({required this.question, required this.answerChoice});

  bool isGood() => answerChoice == question.goodChoice; 
 
}

class Quiz{
  List<Player> players = [];
  List<Question> questions;
  List<Answer> answers = [];
  
  Quiz({required this.questions});

  
Map<String, int> getScore(Player player) {
  int totalScore = 0;
  for (Answer answer in player.answers) {
    if (answer.isGood()) {
      totalScore += answer.question.point;
    }
  }

  int totalPoint = questions.fold(0, (sum, q) => sum + q.point);
  int percent = ((totalScore / totalPoint) * 100).toInt();

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
      scores[p.name] = p.getScore();
    }
    return scores;
  }

}