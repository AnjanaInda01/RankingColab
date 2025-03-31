import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String subject;
  final int totalQuestions;

  const QuizPage({
    super.key,
    required this.subject,
    this.totalQuestions = 10,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;

  // Sample questions data - replace with your actual data source
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Who is the father of Computers?',
      'answers': [
        'Charles Babbage',
        'Dennis Ritchie',
        'Bjarne Stroustrup',
        'James Gosling'
      ],
      'correctIndex': 0,
    },
    {
      'question': 'Who is the father of Compound?',
      'answers': [
        'Charles Babbage',
        'Dennis Ritchie',
        'Bjarne Stroustrup',
        'James Oosting'
      ],
      'correctIndex': 3,
    },
    // Add more questions here
  ];

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final questionNumber = _currentQuestionIndex + 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with user info and score
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'mcg', // Replace with actual username
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Quartette ${_score}', // Display score
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Question progress indicator
            Text(
              'Q$questionNumber/${widget.totalQuestions}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 16),

            // Question text
            Text(
              currentQuestion['question'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 32),

            // Answer options
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion['answers'].length,
                itemBuilder: (context, index) {
                  final answer = currentQuestion['answers'][index];
                  final isSelected = _selectedAnswerIndex == index;
                  final isCorrect = index == currentQuestion['correctIndex'];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? (isCorrect ? Colors.green[100] : Colors.red[100])
                            : Colors.grey[100],
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isSelected
                                ? (isCorrect ? Colors.green : Colors.red)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: _selectedAnswerIndex == null
                          ? () {
                              setState(() {
                                _selectedAnswerIndex = index;
                                if (index == currentQuestion['correctIndex']) {
                                  _score +=
                                      100; // Increment score for correct answer
                                }
                              });
                            }
                          : null,
                      child: Text(
                        answer,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    minimumSize: const Size(120, 50),
                  ),
                  onPressed: _currentQuestionIndex > 0
                      ? () {
                          setState(() {
                            _currentQuestionIndex--;
                            _selectedAnswerIndex = null;
                          });
                        }
                      : null,
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(120, 50),
                  ),
                  onPressed: () {
                    if (_selectedAnswerIndex != null) {
                      setState(() {
                        if (_currentQuestionIndex < _questions.length - 1) {
                          _currentQuestionIndex++;
                          _selectedAnswerIndex = null;
                        } else {
                          // Navigate to results page when all questions are answered
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultsPage(
                                score: _score,
                                totalQuestions: widget.totalQuestions,
                              ),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: Text(
                    _currentQuestionIndex < _questions.length - 1
                        ? 'Next'
                        : 'Finish',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Simple Results Page - customize as needed
class ResultsPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultsPage({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score/${totalQuestions * 100}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Subjects'),
            ),
          ],
        ),
      ),
    );
  }
}
