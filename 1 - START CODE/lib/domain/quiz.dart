class Player{
  final String name;
  List <Answer> answers =[];

  Player(this.name);
  

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

  bool isGood(){
    return this.answerChoice == question.goodChoice;
  }

}

class Quiz{
  List<Question> questions;
  
  
  Quiz({required this.questions});



  Map<String, int> getScore(){
    int totalScore =0;
    for(Answer answer in answers){
      if (answer.isGood()) {
        totalScore += answer.question.point;
      }
    }
    int totalPoint = 0;
    for( Question question in questions ){
      totalPoint += question.point;
      
    }
   int percent = ((totalScore/ totalPoint)*100).toInt();

   return{
    'Score':totalScore,
    'Percentage':percent
   };

  }
  
  

}