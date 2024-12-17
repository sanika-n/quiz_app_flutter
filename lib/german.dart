import 'package:flutter/material.dart';
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  String? selectedOption; // Tracks which option user selected
  bool showAnswer = false; // Flag to show correct/wrong answers

  final List<Map<String, Object>> questions = [
    {
      'question': 'What is "to write"?',
      'options': ['Schreiben', 'Schule', 'Schlange', 'Sonntag'],
      'correct': 'Schreiben',
    },
    {
      'question': 'Wir sind der Jäger',
      'options': ['We are hunters', 'We are hungry', 'You are hungry', 'I am a hunter'],
      'correct': 'We are hunters',
    },
    {
      'question': 'What is the capital of Germany?',
      'options': ['Berlin', 'Munich', 'Hamburg', 'Frankfurt'],
      'correct': 'Berlin',
    },
    // Add 7 more questions here
  ];

  void handleOptionSelect(String option) {
    if (!showAnswer) {
      setState(() {
        selectedOption = option;
        showAnswer = true; // Reveal correct and selected options
      });
    }
  }

  void goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = null; // Reset selection
        showAnswer = false; // Hide answers
      } else {
        // Quiz is finished, handle end state
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Quiz Finished! Well done.")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex]['question'] as String;
    final options = questions[currentQuestionIndex]['options'] as List<String>;
    final correctAnswer = questions[currentQuestionIndex]['correct'] as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quiz",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 24, 10, 71),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...options.map(
              (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => handleOptionSelect(option),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: showAnswer
                        ? (option == correctAnswer
                            ? Colors.green // Correct answer turns green
                            : option == selectedOption
                                ? Colors.red // Incorrect selected option turns red
                                : Colors.grey[300]) // Other options dimmed
                        : const Color.fromARGB(255, 24, 10, 71),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 18,
                      color: showAnswer && option != correctAnswer
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (showAnswer)
              Center(
                child: ElevatedButton(
                  onPressed: goToNextQuestion,
                  child: Text("Next Question"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 24, 10, 71),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}