
import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';

void main() {
  Question q1 =
      Question(title: "4-2", choices: ["1", "2", "3"], goodChoice: "2",point:50);
  Question q2 =
      Question(title: "4+2", choices: ["1", "2", "3"], goodChoice: "6",point:50);

  Quiz quiz = Quiz(questions: [q1, q2]);

  setUp(() {});

  test("test 1", () {
    Player seyha = quiz.getOrCreatePlayer("Seyha");
    seyha.addAnswer(Answer(question: q1, answerChoice: "2"));
    seyha.addAnswer(Answer(question: q2, answerChoice: "6"));
    
    Map<String, int> result = quiz.getScore(seyha);
    // Score should be 100%
    expect(result['Score'], equals(100));
    expect(result['Percentage'], equals(100));
  });

  test("test 2", () {
    Player sok = quiz.getOrCreatePlayer("Sok");
    sok.addAnswer(Answer(question: q1, answerChoice: "7"));
    sok.addAnswer(Answer(question: q2, answerChoice: "9"));
    
  Map<String, int> result = quiz.getScore(sok);
    

    // Score should be 0%
    expect(result['Score'], equals(0));
    expect(result['Percentage'], equals(0));
  });
}