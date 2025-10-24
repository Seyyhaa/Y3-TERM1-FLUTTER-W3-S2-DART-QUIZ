import 'package:test/test.dart';
import 'package:my_first_project/domain/quiz.dart';

void main() {
  Question q1 = Question(
    title: "4 - 2 = ?",
    choices: ["1", "2", "3"],
    goodChoice: "2",
    point: 50,
  );

  Question q2 = Question(
    title: "4 + 2 = ?",
    choices: ["5", "6", "7"],
    goodChoice: "6",
    point: 50,
  );

 
  Quiz quiz = Quiz(questions: [q1, q2]);

  setUp(() {
    quiz.players.clear();
  });

  test("Test 1: All correct answers", () {
    Player seyha = quiz.getOrCreatePlayer("Seyha");

    seyha.addAnswer(Answer(questionId: q1.id, answerChoice: "2"));
    seyha.addAnswer(Answer(questionId: q2.id, answerChoice: "6"));

    Map<String, int> result = quiz.getScore(seyha);

    expect(result['Score'], equals(100));
    expect(result['Percentage'], equals(100));
  });

  test("Test 2: All wrong answers", () {
    Player sok = quiz.getOrCreatePlayer("Sok");

    sok.addAnswer(Answer(questionId: q1.id, answerChoice: "3"));
    sok.addAnswer(Answer(questionId: q2.id, answerChoice: "5"));

    Map<String, int> result = quiz.getScore(sok);

    expect(result['Score'], equals(0));
    expect(result['Percentage'], equals(0));
  });

  test("Test 3: Half correct, half wrong", () {
    Player norin = quiz.getOrCreatePlayer("Norin");

    norin.addAnswer(Answer(questionId: q1.id, answerChoice: "2")); 
    norin.addAnswer(Answer(questionId: q2.id, answerChoice: "5"));

    Map<String, int> result = quiz.getScore(norin);

    expect(result['Score'], equals(50));
    expect(result['Percentage'], equals(50));
  });
}
