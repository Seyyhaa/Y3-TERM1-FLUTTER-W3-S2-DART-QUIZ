
import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';

void main() {
  Question q1 =
      Question(title: "4-2", choices: ["1", "2", "3"], goodChoice: "2",point:100);
  Question q2 =
      Question(title: "4+2", choices: ["1", "2", "3"], goodChoice: "6",point:102);

  Quiz quiz = Quiz(questions: [q1, q2]);

  setUp(() {});

  test("test 1", () {
    List<Answer> answers = [];
    answers.add(Answer(question: q1, answerChoice: "2"));
    answers.add(Answer(question: q2, answerChoice: "6"));
    quiz.answers = answers;

    // Score should be 100%
    expect(quiz.getScore()['Score'], equals(100));
    expect(quiz.getScore()['Percentage'], equals(100));
  });

  test("test 2", () {
    List<Answer> answers = [];
    answers.add(Answer(question: q1, answerChoice: "7"));
    answers.add(Answer(question: q2, answerChoice: "9"));
    quiz.answers = answers;

    print("asnwer size = ${quiz.answers.length}");

    // Score should be 100%
    expect(quiz.getScore()['Score'], equals(0));
    expect(quiz.getScore()['Percentage'], equals(0));
  });
}